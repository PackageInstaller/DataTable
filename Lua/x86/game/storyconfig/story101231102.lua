return {
	Play123112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123112001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play123112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K06g"

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
				local var_4_5 = arg_1_1.bgs_.K06g

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
					if iter_4_0 ~= "K06g" then
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
			local var_4_23 = 0.866666666666667

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

			local var_4_28 = 2
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_4_battle_xiajingqu", "bgm_activity_2_4_battle_xiajingqu", "bgm_activity_2_4_battle_xiajingqu.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_4_battle_xiajingqu", "bgm_activity_2_4_battle_xiajingqu")

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
			local var_4_35 = 0.95

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

				local var_4_37 = arg_1_1:GetWordFromCfg(123112001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 38
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
	Play123112002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 123112002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play123112003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1055ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1055ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1055ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1055ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -0.965, -6.2)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1055ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1055ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1055ui_story == nil then
				arg_9_1.var_.characterEffect1055ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1055ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1055ui_story then
				arg_9_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.075

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[481].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(123112002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112002", "story_v_out_123112.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_123112", "123112002", "story_v_out_123112.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_123112", "123112002", "story_v_out_123112.awb")

						arg_9_1:RecordAudio("123112002", var_12_29)
						arg_9_1:RecordAudio("123112002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_123112", "123112002", "story_v_out_123112.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_123112", "123112002", "story_v_out_123112.awb")
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play123112003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 123112003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play123112004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1055ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1055ui_story == nil then
				arg_13_1.var_.characterEffect1055ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1055ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1055ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1055ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1055ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.5

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(123112003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 20
				local var_16_11 = utf8.len(var_16_9)
				local var_16_12 = var_16_10 <= 0 and var_16_7 or var_16_7 * (var_16_11 / var_16_10)

				if var_16_12 > 0 and var_16_7 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_13 and arg_13_1.time_ < var_16_6 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play123112004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 123112004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play123112005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1055ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1055ui_story == nil then
				arg_17_1.var_.characterEffect1055ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1055ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1055ui_story then
				arg_17_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_20_4 = 0

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_20_6 = 0
			local var_20_7 = 0.075

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[481].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_9 = arg_17_1:GetWordFromCfg(123112004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 3
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112004", "story_v_out_123112.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112004", "story_v_out_123112.awb") / 1000

					if var_20_14 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_6
					end

					if var_20_9.prefab_name ~= "" and arg_17_1.actors_[var_20_9.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_9.prefab_name].transform, "story_v_out_123112", "123112004", "story_v_out_123112.awb")

						arg_17_1:RecordAudio("123112004", var_20_15)
						arg_17_1:RecordAudio("123112004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_123112", "123112004", "story_v_out_123112.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_123112", "123112004", "story_v_out_123112.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_16 and arg_17_1.time_ < var_20_6 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play123112005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 123112005
		arg_21_1.duration_ = 7.3

		local var_21_0 = {
			zh = 7.3,
			ja = 5.8
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play123112006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1093ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["1093ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos1093ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0, -1.11, -5.88)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1093ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["1093ui_story"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = var_24_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_16 = 0.200000002980232

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.characterEffect1093ui_story and not isNil(var_24_14) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_24_20 = arg_21_1.actors_["1055ui_story"]
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.characterEffect1055ui_story == nil then
				arg_21_1.var_.characterEffect1055ui_story = var_24_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_22 = 0.200000002980232

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 and not isNil(var_24_20) then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22

				if arg_21_1.var_.characterEffect1055ui_story and not isNil(var_24_20) then
					local var_24_24 = Mathf.Lerp(0, 0.5, var_24_23)

					arg_21_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1055ui_story.fillRatio = var_24_24
				end
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.characterEffect1055ui_story then
				local var_24_25 = 0.5

				arg_21_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1055ui_story.fillRatio = var_24_25
			end

			local var_24_26 = arg_21_1.actors_["1055ui_story"].transform
			local var_24_27 = 0

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				arg_21_1.var_.moveOldPos1055ui_story = var_24_26.localPosition
			end

			local var_24_28 = 0.001

			if var_24_27 <= arg_21_1.time_ and arg_21_1.time_ < var_24_27 + var_24_28 then
				local var_24_29 = (arg_21_1.time_ - var_24_27) / var_24_28
				local var_24_30 = Vector3.New(0, 100, 0)

				var_24_26.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1055ui_story, var_24_30, var_24_29)

				local var_24_31 = manager.ui.mainCamera.transform.position - var_24_26.position

				var_24_26.forward = Vector3.New(var_24_31.x, var_24_31.y, var_24_31.z)

				local var_24_32 = var_24_26.localEulerAngles

				var_24_32.z = 0
				var_24_32.x = 0
				var_24_26.localEulerAngles = var_24_32
			end

			if arg_21_1.time_ >= var_24_27 + var_24_28 and arg_21_1.time_ < var_24_27 + var_24_28 + arg_24_0 then
				var_24_26.localPosition = Vector3.New(0, 100, 0)

				local var_24_33 = manager.ui.mainCamera.transform.position - var_24_26.position

				var_24_26.forward = Vector3.New(var_24_33.x, var_24_33.y, var_24_33.z)

				local var_24_34 = var_24_26.localEulerAngles

				var_24_34.z = 0
				var_24_34.x = 0
				var_24_26.localEulerAngles = var_24_34
			end

			local var_24_35 = 0
			local var_24_36 = 0.675

			if var_24_35 < arg_21_1.time_ and arg_21_1.time_ <= var_24_35 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_37 = arg_21_1:FormatText(StoryNameCfg[73].name)

				arg_21_1.leftNameTxt_.text = var_24_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_38 = arg_21_1:GetWordFromCfg(123112005)
				local var_24_39 = arg_21_1:FormatText(var_24_38.content)

				arg_21_1.text_.text = var_24_39

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_40 = 27
				local var_24_41 = utf8.len(var_24_39)
				local var_24_42 = var_24_40 <= 0 and var_24_36 or var_24_36 * (var_24_41 / var_24_40)

				if var_24_42 > 0 and var_24_36 < var_24_42 then
					arg_21_1.talkMaxDuration = var_24_42

					if var_24_42 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_42 + var_24_35
					end
				end

				arg_21_1.text_.text = var_24_39
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112005", "story_v_out_123112.awb") ~= 0 then
					local var_24_43 = manager.audio:GetVoiceLength("story_v_out_123112", "123112005", "story_v_out_123112.awb") / 1000

					if var_24_43 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_43 + var_24_35
					end

					if var_24_38.prefab_name ~= "" and arg_21_1.actors_[var_24_38.prefab_name] ~= nil then
						local var_24_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_38.prefab_name].transform, "story_v_out_123112", "123112005", "story_v_out_123112.awb")

						arg_21_1:RecordAudio("123112005", var_24_44)
						arg_21_1:RecordAudio("123112005", var_24_44)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_123112", "123112005", "story_v_out_123112.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_123112", "123112005", "story_v_out_123112.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_45 = math.max(var_24_36, arg_21_1.talkMaxDuration)

			if var_24_35 <= arg_21_1.time_ and arg_21_1.time_ < var_24_35 + var_24_45 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_35) / var_24_45

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_35 + var_24_45 and arg_21_1.time_ < var_24_35 + var_24_45 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play123112006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 123112006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play123112007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1055ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1055ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1055ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1055ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1055ui_story == nil then
				arg_25_1.var_.characterEffect1055ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1055ui_story and not isNil(var_28_9) then
					local var_28_13 = Mathf.Lerp(0, 0.5, var_28_12)

					arg_25_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1055ui_story.fillRatio = var_28_13
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1055ui_story then
				local var_28_14 = 0.5

				arg_25_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1055ui_story.fillRatio = var_28_14
			end

			local var_28_15 = arg_25_1.actors_["1093ui_story"].transform
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.var_.moveOldPos1093ui_story = var_28_15.localPosition
			end

			local var_28_17 = 0.001

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17
				local var_28_19 = Vector3.New(0, 100, 0)

				var_28_15.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1093ui_story, var_28_19, var_28_18)

				local var_28_20 = manager.ui.mainCamera.transform.position - var_28_15.position

				var_28_15.forward = Vector3.New(var_28_20.x, var_28_20.y, var_28_20.z)

				local var_28_21 = var_28_15.localEulerAngles

				var_28_21.z = 0
				var_28_21.x = 0
				var_28_15.localEulerAngles = var_28_21
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 then
				var_28_15.localPosition = Vector3.New(0, 100, 0)

				local var_28_22 = manager.ui.mainCamera.transform.position - var_28_15.position

				var_28_15.forward = Vector3.New(var_28_22.x, var_28_22.y, var_28_22.z)

				local var_28_23 = var_28_15.localEulerAngles

				var_28_23.z = 0
				var_28_23.x = 0
				var_28_15.localEulerAngles = var_28_23
			end

			local var_28_24 = arg_25_1.actors_["1093ui_story"]
			local var_28_25 = 0

			if var_28_25 < arg_25_1.time_ and arg_25_1.time_ <= var_28_25 + arg_28_0 and not isNil(var_28_24) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = var_28_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_26 = 0.200000002980232

			if var_28_25 <= arg_25_1.time_ and arg_25_1.time_ < var_28_25 + var_28_26 and not isNil(var_28_24) then
				local var_28_27 = (arg_25_1.time_ - var_28_25) / var_28_26

				if arg_25_1.var_.characterEffect1093ui_story and not isNil(var_28_24) then
					local var_28_28 = Mathf.Lerp(0, 0.5, var_28_27)

					arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1093ui_story.fillRatio = var_28_28
				end
			end

			if arg_25_1.time_ >= var_28_25 + var_28_26 and arg_25_1.time_ < var_28_25 + var_28_26 + arg_28_0 and not isNil(var_28_24) and arg_25_1.var_.characterEffect1093ui_story then
				local var_28_29 = 0.5

				arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1093ui_story.fillRatio = var_28_29
			end

			local var_28_30 = 0
			local var_28_31 = 1.35

			if var_28_30 < arg_25_1.time_ and arg_25_1.time_ <= var_28_30 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_32 = arg_25_1:GetWordFromCfg(123112006)
				local var_28_33 = arg_25_1:FormatText(var_28_32.content)

				arg_25_1.text_.text = var_28_33

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_34 = 54
				local var_28_35 = utf8.len(var_28_33)
				local var_28_36 = var_28_34 <= 0 and var_28_31 or var_28_31 * (var_28_35 / var_28_34)

				if var_28_36 > 0 and var_28_31 < var_28_36 then
					arg_25_1.talkMaxDuration = var_28_36

					if var_28_36 + var_28_30 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_36 + var_28_30
					end
				end

				arg_25_1.text_.text = var_28_33
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_37 = math.max(var_28_31, arg_25_1.talkMaxDuration)

			if var_28_30 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_37 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_30) / var_28_37

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_30 + var_28_37 and arg_25_1.time_ < var_28_30 + var_28_37 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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

		arg_25_1:InitPlayNodeList()
	end,
	Play123112007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 123112007
		arg_29_1.duration_ = 3.37

		local var_29_0 = {
			zh = 3.366,
			ja = 2.8
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
				arg_29_0:Play123112008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.225

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[499].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(123112007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 9
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112007", "story_v_out_123112.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112007", "story_v_out_123112.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_123112", "123112007", "story_v_out_123112.awb")

						arg_29_1:RecordAudio("123112007", var_32_9)
						arg_29_1:RecordAudio("123112007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_123112", "123112007", "story_v_out_123112.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_123112", "123112007", "story_v_out_123112.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play123112008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 123112008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play123112009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.15

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(123112008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 46
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play123112009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 123112009
		arg_37_1.duration_ = 4.6

		local var_37_0 = {
			zh = 1.999999999999,
			ja = 4.6
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
				arg_37_0:Play123112010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1055ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1055ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -0.965, -6.2)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1055ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1055ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1055ui_story == nil then
				arg_37_1.var_.characterEffect1055ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1055ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1055ui_story then
				arg_37_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_40_15 = 0
			local var_40_16 = 0.1

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[481].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(123112009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 4
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112009", "story_v_out_123112.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_123112", "123112009", "story_v_out_123112.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_123112", "123112009", "story_v_out_123112.awb")

						arg_37_1:RecordAudio("123112009", var_40_24)
						arg_37_1:RecordAudio("123112009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_123112", "123112009", "story_v_out_123112.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_123112", "123112009", "story_v_out_123112.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play123112010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 123112010
		arg_41_1.duration_ = 10.73

		local var_41_0 = {
			zh = 10.733,
			ja = 9.6
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play123112011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1055ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1055ui_story == nil then
				arg_41_1.var_.characterEffect1055ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1055ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1055ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1055ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1055ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 1.15

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[499].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(123112010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 46
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112010", "story_v_out_123112.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112010", "story_v_out_123112.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_123112", "123112010", "story_v_out_123112.awb")

						arg_41_1:RecordAudio("123112010", var_44_15)
						arg_41_1:RecordAudio("123112010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_123112", "123112010", "story_v_out_123112.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_123112", "123112010", "story_v_out_123112.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_16 and arg_41_1.time_ < var_44_6 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play123112011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 123112011
		arg_45_1.duration_ = 6.03

		local var_45_0 = {
			zh = 6.033,
			ja = 4.733
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play123112012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1093ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1093ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0.7, -1.11, -5.88)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1093ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1093ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1093ui_story == nil then
				arg_45_1.var_.characterEffect1093ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1093ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1093ui_story then
				arg_45_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_48_15 = arg_45_1.actors_["1055ui_story"].transform
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.var_.moveOldPos1055ui_story = var_48_15.localPosition
			end

			local var_48_17 = 0.001

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17
				local var_48_19 = Vector3.New(-0.7, -0.965, -6.2)

				var_48_15.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1055ui_story, var_48_19, var_48_18)

				local var_48_20 = manager.ui.mainCamera.transform.position - var_48_15.position

				var_48_15.forward = Vector3.New(var_48_20.x, var_48_20.y, var_48_20.z)

				local var_48_21 = var_48_15.localEulerAngles

				var_48_21.z = 0
				var_48_21.x = 0
				var_48_15.localEulerAngles = var_48_21
			end

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 then
				var_48_15.localPosition = Vector3.New(-0.7, -0.965, -6.2)

				local var_48_22 = manager.ui.mainCamera.transform.position - var_48_15.position

				var_48_15.forward = Vector3.New(var_48_22.x, var_48_22.y, var_48_22.z)

				local var_48_23 = var_48_15.localEulerAngles

				var_48_23.z = 0
				var_48_23.x = 0
				var_48_15.localEulerAngles = var_48_23
			end

			local var_48_24 = 0
			local var_48_25 = 0.475

			if var_48_24 < arg_45_1.time_ and arg_45_1.time_ <= var_48_24 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_26 = arg_45_1:FormatText(StoryNameCfg[73].name)

				arg_45_1.leftNameTxt_.text = var_48_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_27 = arg_45_1:GetWordFromCfg(123112011)
				local var_48_28 = arg_45_1:FormatText(var_48_27.content)

				arg_45_1.text_.text = var_48_28

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_29 = 19
				local var_48_30 = utf8.len(var_48_28)
				local var_48_31 = var_48_29 <= 0 and var_48_25 or var_48_25 * (var_48_30 / var_48_29)

				if var_48_31 > 0 and var_48_25 < var_48_31 then
					arg_45_1.talkMaxDuration = var_48_31

					if var_48_31 + var_48_24 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_24
					end
				end

				arg_45_1.text_.text = var_48_28
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112011", "story_v_out_123112.awb") ~= 0 then
					local var_48_32 = manager.audio:GetVoiceLength("story_v_out_123112", "123112011", "story_v_out_123112.awb") / 1000

					if var_48_32 + var_48_24 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_32 + var_48_24
					end

					if var_48_27.prefab_name ~= "" and arg_45_1.actors_[var_48_27.prefab_name] ~= nil then
						local var_48_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_27.prefab_name].transform, "story_v_out_123112", "123112011", "story_v_out_123112.awb")

						arg_45_1:RecordAudio("123112011", var_48_33)
						arg_45_1:RecordAudio("123112011", var_48_33)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_123112", "123112011", "story_v_out_123112.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_123112", "123112011", "story_v_out_123112.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_34 = math.max(var_48_25, arg_45_1.talkMaxDuration)

			if var_48_24 <= arg_45_1.time_ and arg_45_1.time_ < var_48_24 + var_48_34 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_24) / var_48_34

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_24 + var_48_34 and arg_45_1.time_ < var_48_24 + var_48_34 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play123112012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 123112012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play123112013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1093ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1093ui_story == nil then
				arg_49_1.var_.characterEffect1093ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1093ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1093ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1093ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1093ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.9

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(123112012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 36
				local var_52_11 = utf8.len(var_52_9)
				local var_52_12 = var_52_10 <= 0 and var_52_7 or var_52_7 * (var_52_11 / var_52_10)

				if var_52_12 > 0 and var_52_7 < var_52_12 then
					arg_49_1.talkMaxDuration = var_52_12

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_13 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_13 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_13

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_13 and arg_49_1.time_ < var_52_6 + var_52_13 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play123112013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 123112013
		arg_53_1.duration_ = 5.97

		local var_53_0 = {
			zh = 1.999999999999,
			ja = 5.966
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
				arg_53_0:Play123112014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1055ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1055ui_story == nil then
				arg_53_1.var_.characterEffect1055ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1055ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1055ui_story then
				arg_53_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_56_4 = 0

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_6 = 0
			local var_56_7 = 0.2

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[481].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_9 = arg_53_1:GetWordFromCfg(123112013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 8
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112013", "story_v_out_123112.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112013", "story_v_out_123112.awb") / 1000

					if var_56_14 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_6
					end

					if var_56_9.prefab_name ~= "" and arg_53_1.actors_[var_56_9.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_9.prefab_name].transform, "story_v_out_123112", "123112013", "story_v_out_123112.awb")

						arg_53_1:RecordAudio("123112013", var_56_15)
						arg_53_1:RecordAudio("123112013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_123112", "123112013", "story_v_out_123112.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_123112", "123112013", "story_v_out_123112.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_16 and arg_53_1.time_ < var_56_6 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play123112014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 123112014
		arg_57_1.duration_ = 2.03

		local var_57_0 = {
			zh = 1.666,
			ja = 2.033
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
				arg_57_0:Play123112015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1055ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1055ui_story == nil then
				arg_57_1.var_.characterEffect1055ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1055ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1055ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1055ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1055ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.125

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[499].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_9 = arg_57_1:GetWordFromCfg(123112014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 5
				local var_60_12 = utf8.len(var_60_10)
				local var_60_13 = var_60_11 <= 0 and var_60_7 or var_60_7 * (var_60_12 / var_60_11)

				if var_60_13 > 0 and var_60_7 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112014", "story_v_out_123112.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112014", "story_v_out_123112.awb") / 1000

					if var_60_14 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_6
					end

					if var_60_9.prefab_name ~= "" and arg_57_1.actors_[var_60_9.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_9.prefab_name].transform, "story_v_out_123112", "123112014", "story_v_out_123112.awb")

						arg_57_1:RecordAudio("123112014", var_60_15)
						arg_57_1:RecordAudio("123112014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_123112", "123112014", "story_v_out_123112.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_123112", "123112014", "story_v_out_123112.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_16 and arg_57_1.time_ < var_60_6 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play123112015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 123112015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play123112016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.075

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(123112015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 43
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play123112016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 123112016
		arg_65_1.duration_ = 5.2

		local var_65_0 = {
			zh = 2.166,
			ja = 5.2
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
				arg_65_0:Play123112017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1055ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1055ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(-0.7, -0.965, -6.2)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1055ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(-0.7, -0.965, -6.2)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1055ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1055ui_story == nil then
				arg_65_1.var_.characterEffect1055ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1055ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1055ui_story then
				arg_65_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_68_15 = 0
			local var_68_16 = 0.3

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[481].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(123112016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 12
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112016", "story_v_out_123112.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_123112", "123112016", "story_v_out_123112.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_123112", "123112016", "story_v_out_123112.awb")

						arg_65_1:RecordAudio("123112016", var_68_24)
						arg_65_1:RecordAudio("123112016", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_123112", "123112016", "story_v_out_123112.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_123112", "123112016", "story_v_out_123112.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play123112017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 123112017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play123112018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1055ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1055ui_story == nil then
				arg_69_1.var_.characterEffect1055ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1055ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1055ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1055ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1055ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 1.25

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(123112017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 50
				local var_72_11 = utf8.len(var_72_9)
				local var_72_12 = var_72_10 <= 0 and var_72_7 or var_72_7 * (var_72_11 / var_72_10)

				if var_72_12 > 0 and var_72_7 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_13 and arg_69_1.time_ < var_72_6 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play123112018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 123112018
		arg_73_1.duration_ = 5.9

		local var_73_0 = {
			zh = 5.9,
			ja = 4.366
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
				arg_73_0:Play123112019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.2

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[500].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(123112018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 8
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112018", "story_v_out_123112.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112018", "story_v_out_123112.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_123112", "123112018", "story_v_out_123112.awb")

						arg_73_1:RecordAudio("123112018", var_76_9)
						arg_73_1:RecordAudio("123112018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_123112", "123112018", "story_v_out_123112.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_123112", "123112018", "story_v_out_123112.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play123112019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 123112019
		arg_77_1.duration_ = 2.23

		local var_77_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_77_0:Play123112020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1093ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1093ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0.7, -1.11, -5.88)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1093ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["1093ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1093ui_story == nil then
				arg_77_1.var_.characterEffect1093ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect1093ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect1093ui_story then
				arg_77_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action465")
			end

			local var_80_14 = 0

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_80_15 = 0
			local var_80_16 = 0.1

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[73].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(123112019)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 4
				local var_80_21 = utf8.len(var_80_19)
				local var_80_22 = var_80_20 <= 0 and var_80_16 or var_80_16 * (var_80_21 / var_80_20)

				if var_80_22 > 0 and var_80_16 < var_80_22 then
					arg_77_1.talkMaxDuration = var_80_22

					if var_80_22 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_19
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112019", "story_v_out_123112.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_123112", "123112019", "story_v_out_123112.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_123112", "123112019", "story_v_out_123112.awb")

						arg_77_1:RecordAudio("123112019", var_80_24)
						arg_77_1:RecordAudio("123112019", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_123112", "123112019", "story_v_out_123112.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_123112", "123112019", "story_v_out_123112.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_25 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_25

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_25 and arg_77_1.time_ < var_80_15 + var_80_25 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play123112020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 123112020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play123112021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1093ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1093ui_story == nil then
				arg_81_1.var_.characterEffect1093ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1093ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1093ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1093ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1093ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.45

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(123112020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 18
				local var_84_11 = utf8.len(var_84_9)
				local var_84_12 = var_84_10 <= 0 and var_84_7 or var_84_7 * (var_84_11 / var_84_10)

				if var_84_12 > 0 and var_84_7 < var_84_12 then
					arg_81_1.talkMaxDuration = var_84_12

					if var_84_12 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_13 and arg_81_1.time_ < var_84_6 + var_84_13 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play123112021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 123112021
		arg_85_1.duration_ = 7.43

		local var_85_0 = {
			zh = 6.8,
			ja = 7.433
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
				arg_85_0:Play123112022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1055ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1055ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(-0.7, -0.965, -6.2)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1055ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-0.7, -0.965, -6.2)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["1055ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1055ui_story == nil then
				arg_85_1.var_.characterEffect1055ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect1055ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1055ui_story then
				arg_85_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_2")
			end

			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_15 = 0

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action5_2")
			end

			local var_88_16 = 0
			local var_88_17 = 0.65

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_18 = arg_85_1:FormatText(StoryNameCfg[481].name)

				arg_85_1.leftNameTxt_.text = var_88_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_19 = arg_85_1:GetWordFromCfg(123112021)
				local var_88_20 = arg_85_1:FormatText(var_88_19.content)

				arg_85_1.text_.text = var_88_20

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_21 = 26
				local var_88_22 = utf8.len(var_88_20)
				local var_88_23 = var_88_21 <= 0 and var_88_17 or var_88_17 * (var_88_22 / var_88_21)

				if var_88_23 > 0 and var_88_17 < var_88_23 then
					arg_85_1.talkMaxDuration = var_88_23

					if var_88_23 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_16
					end
				end

				arg_85_1.text_.text = var_88_20
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112021", "story_v_out_123112.awb") ~= 0 then
					local var_88_24 = manager.audio:GetVoiceLength("story_v_out_123112", "123112021", "story_v_out_123112.awb") / 1000

					if var_88_24 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_16
					end

					if var_88_19.prefab_name ~= "" and arg_85_1.actors_[var_88_19.prefab_name] ~= nil then
						local var_88_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_19.prefab_name].transform, "story_v_out_123112", "123112021", "story_v_out_123112.awb")

						arg_85_1:RecordAudio("123112021", var_88_25)
						arg_85_1:RecordAudio("123112021", var_88_25)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_123112", "123112021", "story_v_out_123112.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_123112", "123112021", "story_v_out_123112.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_26 = math.max(var_88_17, arg_85_1.talkMaxDuration)

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_26 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_16) / var_88_26

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_16 + var_88_26 and arg_85_1.time_ < var_88_16 + var_88_26 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play123112022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 123112022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play123112023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1055ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1055ui_story == nil then
				arg_89_1.var_.characterEffect1055ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1055ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1055ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1055ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1055ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.725

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(123112022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 29
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_7 or var_92_7 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_7 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_13 and arg_89_1.time_ < var_92_6 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play123112023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 123112023
		arg_93_1.duration_ = 3.33

		local var_93_0 = {
			zh = 3.333,
			ja = 2.5
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
				arg_93_0:Play123112024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1093ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1093ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, 100, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1093ui_story, var_96_4, var_96_3)

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

			local var_96_9 = arg_93_1.actors_["1093ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1093ui_story == nil then
				arg_93_1.var_.characterEffect1093ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1093ui_story and not isNil(var_96_9) then
					local var_96_13 = Mathf.Lerp(0, 0.5, var_96_12)

					arg_93_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1093ui_story.fillRatio = var_96_13
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1093ui_story then
				local var_96_14 = 0.5

				arg_93_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1093ui_story.fillRatio = var_96_14
			end

			local var_96_15 = arg_93_1.actors_["1055ui_story"].transform
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.var_.moveOldPos1055ui_story = var_96_15.localPosition
			end

			local var_96_17 = 0.001

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17
				local var_96_19 = Vector3.New(0, -0.965, -6.2)

				var_96_15.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1055ui_story, var_96_19, var_96_18)

				local var_96_20 = manager.ui.mainCamera.transform.position - var_96_15.position

				var_96_15.forward = Vector3.New(var_96_20.x, var_96_20.y, var_96_20.z)

				local var_96_21 = var_96_15.localEulerAngles

				var_96_21.z = 0
				var_96_21.x = 0
				var_96_15.localEulerAngles = var_96_21
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 then
				var_96_15.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_96_22 = manager.ui.mainCamera.transform.position - var_96_15.position

				var_96_15.forward = Vector3.New(var_96_22.x, var_96_22.y, var_96_22.z)

				local var_96_23 = var_96_15.localEulerAngles

				var_96_23.z = 0
				var_96_23.x = 0
				var_96_15.localEulerAngles = var_96_23
			end

			local var_96_24 = arg_93_1.actors_["1055ui_story"]
			local var_96_25 = 0

			if var_96_25 < arg_93_1.time_ and arg_93_1.time_ <= var_96_25 + arg_96_0 and not isNil(var_96_24) and arg_93_1.var_.characterEffect1055ui_story == nil then
				arg_93_1.var_.characterEffect1055ui_story = var_96_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_26 = 0.200000002980232

			if var_96_25 <= arg_93_1.time_ and arg_93_1.time_ < var_96_25 + var_96_26 and not isNil(var_96_24) then
				local var_96_27 = (arg_93_1.time_ - var_96_25) / var_96_26

				if arg_93_1.var_.characterEffect1055ui_story and not isNil(var_96_24) then
					local var_96_28 = Mathf.Lerp(0, 0.5, var_96_27)

					arg_93_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1055ui_story.fillRatio = var_96_28
				end
			end

			if arg_93_1.time_ >= var_96_25 + var_96_26 and arg_93_1.time_ < var_96_25 + var_96_26 + arg_96_0 and not isNil(var_96_24) and arg_93_1.var_.characterEffect1055ui_story then
				local var_96_29 = 0.5

				arg_93_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1055ui_story.fillRatio = var_96_29
			end

			local var_96_30 = 0
			local var_96_31 = 0.325

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_32 = arg_93_1:FormatText(StoryNameCfg[500].name)

				arg_93_1.leftNameTxt_.text = var_96_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_33 = arg_93_1:GetWordFromCfg(123112023)
				local var_96_34 = arg_93_1:FormatText(var_96_33.content)

				arg_93_1.text_.text = var_96_34

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_35 = 13
				local var_96_36 = utf8.len(var_96_34)
				local var_96_37 = var_96_35 <= 0 and var_96_31 or var_96_31 * (var_96_36 / var_96_35)

				if var_96_37 > 0 and var_96_31 < var_96_37 then
					arg_93_1.talkMaxDuration = var_96_37

					if var_96_37 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_37 + var_96_30
					end
				end

				arg_93_1.text_.text = var_96_34
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112023", "story_v_out_123112.awb") ~= 0 then
					local var_96_38 = manager.audio:GetVoiceLength("story_v_out_123112", "123112023", "story_v_out_123112.awb") / 1000

					if var_96_38 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_38 + var_96_30
					end

					if var_96_33.prefab_name ~= "" and arg_93_1.actors_[var_96_33.prefab_name] ~= nil then
						local var_96_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_33.prefab_name].transform, "story_v_out_123112", "123112023", "story_v_out_123112.awb")

						arg_93_1:RecordAudio("123112023", var_96_39)
						arg_93_1:RecordAudio("123112023", var_96_39)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_123112", "123112023", "story_v_out_123112.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_123112", "123112023", "story_v_out_123112.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_40 = math.max(var_96_31, arg_93_1.talkMaxDuration)

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_40 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_30) / var_96_40

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_30 + var_96_40 and arg_93_1.time_ < var_96_30 + var_96_40 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play123112024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 123112024
		arg_97_1.duration_ = 5.6

		local var_97_0 = {
			zh = 5.6,
			ja = 4.9
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
				arg_97_0:Play123112025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.625

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[500].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(123112024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 25
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112024", "story_v_out_123112.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112024", "story_v_out_123112.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_123112", "123112024", "story_v_out_123112.awb")

						arg_97_1:RecordAudio("123112024", var_100_9)
						arg_97_1:RecordAudio("123112024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_123112", "123112024", "story_v_out_123112.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_123112", "123112024", "story_v_out_123112.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play123112025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 123112025
		arg_101_1.duration_ = 12.77

		local var_101_0 = {
			zh = 7.833,
			ja = 12.766
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
				arg_101_0:Play123112026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1055ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1055ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -0.965, -6.2)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1055ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1055ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1055ui_story == nil then
				arg_101_1.var_.characterEffect1055ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1055ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1055ui_story then
				arg_101_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_104_15 = 0
			local var_104_16 = 1.1

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[481].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(123112025)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 44
				local var_104_21 = utf8.len(var_104_19)
				local var_104_22 = var_104_20 <= 0 and var_104_16 or var_104_16 * (var_104_21 / var_104_20)

				if var_104_22 > 0 and var_104_16 < var_104_22 then
					arg_101_1.talkMaxDuration = var_104_22

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112025", "story_v_out_123112.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_out_123112", "123112025", "story_v_out_123112.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_out_123112", "123112025", "story_v_out_123112.awb")

						arg_101_1:RecordAudio("123112025", var_104_24)
						arg_101_1:RecordAudio("123112025", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_123112", "123112025", "story_v_out_123112.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_123112", "123112025", "story_v_out_123112.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_25 and arg_101_1.time_ < var_104_15 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play123112026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 123112026
		arg_105_1.duration_ = 4.9

		local var_105_0 = {
			zh = 4.5,
			ja = 4.9
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
				arg_105_0:Play123112027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1055ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1055ui_story == nil then
				arg_105_1.var_.characterEffect1055ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1055ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1055ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1055ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1055ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.525

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[500].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_9 = arg_105_1:GetWordFromCfg(123112026)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 21
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112026", "story_v_out_123112.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112026", "story_v_out_123112.awb") / 1000

					if var_108_14 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_6
					end

					if var_108_9.prefab_name ~= "" and arg_105_1.actors_[var_108_9.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_9.prefab_name].transform, "story_v_out_123112", "123112026", "story_v_out_123112.awb")

						arg_105_1:RecordAudio("123112026", var_108_15)
						arg_105_1:RecordAudio("123112026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_123112", "123112026", "story_v_out_123112.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_123112", "123112026", "story_v_out_123112.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_16 and arg_105_1.time_ < var_108_6 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play123112027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 123112027
		arg_109_1.duration_ = 2.9

		local var_109_0 = {
			zh = 2.866,
			ja = 2.9
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
				arg_109_0:Play123112028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.225

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[499].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(123112027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 9
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112027", "story_v_out_123112.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112027", "story_v_out_123112.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_123112", "123112027", "story_v_out_123112.awb")

						arg_109_1:RecordAudio("123112027", var_112_9)
						arg_109_1:RecordAudio("123112027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_123112", "123112027", "story_v_out_123112.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_123112", "123112027", "story_v_out_123112.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play123112028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 123112028
		arg_113_1.duration_ = 5.23

		local var_113_0 = {
			zh = 5.233,
			ja = 5
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
				arg_113_0:Play123112029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.55

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[500].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(123112028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 22
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112028", "story_v_out_123112.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112028", "story_v_out_123112.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_123112", "123112028", "story_v_out_123112.awb")

						arg_113_1:RecordAudio("123112028", var_116_9)
						arg_113_1:RecordAudio("123112028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_123112", "123112028", "story_v_out_123112.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_123112", "123112028", "story_v_out_123112.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play123112029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 123112029
		arg_117_1.duration_ = 6

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play123112030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_1 = 1

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_1 then
				local var_120_2 = (arg_117_1.time_ - var_120_0) / var_120_1
				local var_120_3 = Color.New(1, 1, 1)

				var_120_3.a = Mathf.Lerp(1, 0, var_120_2)
				arg_117_1.mask_.color = var_120_3
			end

			if arg_117_1.time_ >= var_120_0 + var_120_1 and arg_117_1.time_ < var_120_0 + var_120_1 + arg_120_0 then
				local var_120_4 = Color.New(1, 1, 1)
				local var_120_5 = 0

				arg_117_1.mask_.enabled = false
				var_120_4.a = var_120_5
				arg_117_1.mask_.color = var_120_4
			end

			local var_120_6 = arg_117_1.actors_["1055ui_story"].transform
			local var_120_7 = 0

			if var_120_7 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1.var_.moveOldPos1055ui_story = var_120_6.localPosition
			end

			local var_120_8 = 0.001

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_8 then
				local var_120_9 = (arg_117_1.time_ - var_120_7) / var_120_8
				local var_120_10 = Vector3.New(0, 100, 0)

				var_120_6.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1055ui_story, var_120_10, var_120_9)

				local var_120_11 = manager.ui.mainCamera.transform.position - var_120_6.position

				var_120_6.forward = Vector3.New(var_120_11.x, var_120_11.y, var_120_11.z)

				local var_120_12 = var_120_6.localEulerAngles

				var_120_12.z = 0
				var_120_12.x = 0
				var_120_6.localEulerAngles = var_120_12
			end

			if arg_117_1.time_ >= var_120_7 + var_120_8 and arg_117_1.time_ < var_120_7 + var_120_8 + arg_120_0 then
				var_120_6.localPosition = Vector3.New(0, 100, 0)

				local var_120_13 = manager.ui.mainCamera.transform.position - var_120_6.position

				var_120_6.forward = Vector3.New(var_120_13.x, var_120_13.y, var_120_13.z)

				local var_120_14 = var_120_6.localEulerAngles

				var_120_14.z = 0
				var_120_14.x = 0
				var_120_6.localEulerAngles = var_120_14
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_15 = 1
			local var_120_16 = 0.775

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_17 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_17:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(123112029)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 31
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22
					var_120_15 = var_120_15 + 0.3

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_23 = var_120_15 + 0.3
			local var_120_24 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_24 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_23) / var_120_24

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_23 + var_120_24 and arg_117_1.time_ < var_120_23 + var_120_24 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123112030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 123112030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play123112031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.1

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(123112030)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 44
				local var_126_5 = utf8.len(var_126_3)
				local var_126_6 = var_126_4 <= 0 and var_126_1 or var_126_1 * (var_126_5 / var_126_4)

				if var_126_6 > 0 and var_126_1 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_7 and arg_123_1.time_ < var_126_0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play123112031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 123112031
		arg_127_1.duration_ = 13.8

		local var_127_0 = {
			zh = 11.433,
			ja = 13.8
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
				arg_127_0:Play123112032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1055ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1055ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(0, -0.965, -6.2)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1055ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["1055ui_story"]
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect1055ui_story == nil then
				arg_127_1.var_.characterEffect1055ui_story = var_130_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_11 = 0.200000002980232

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 and not isNil(var_130_9) then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11

				if arg_127_1.var_.characterEffect1055ui_story and not isNil(var_130_9) then
					arg_127_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect1055ui_story then
				arg_127_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_130_13 = 0

			if var_130_13 < arg_127_1.time_ and arg_127_1.time_ <= var_130_13 + arg_130_0 then
				arg_127_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action3_1")
			end

			local var_130_14 = 0

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_130_15 = 0
			local var_130_16 = 1

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_17 = arg_127_1:FormatText(StoryNameCfg[481].name)

				arg_127_1.leftNameTxt_.text = var_130_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_18 = arg_127_1:GetWordFromCfg(123112031)
				local var_130_19 = arg_127_1:FormatText(var_130_18.content)

				arg_127_1.text_.text = var_130_19

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_20 = 40
				local var_130_21 = utf8.len(var_130_19)
				local var_130_22 = var_130_20 <= 0 and var_130_16 or var_130_16 * (var_130_21 / var_130_20)

				if var_130_22 > 0 and var_130_16 < var_130_22 then
					arg_127_1.talkMaxDuration = var_130_22

					if var_130_22 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_22 + var_130_15
					end
				end

				arg_127_1.text_.text = var_130_19
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112031", "story_v_out_123112.awb") ~= 0 then
					local var_130_23 = manager.audio:GetVoiceLength("story_v_out_123112", "123112031", "story_v_out_123112.awb") / 1000

					if var_130_23 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_23 + var_130_15
					end

					if var_130_18.prefab_name ~= "" and arg_127_1.actors_[var_130_18.prefab_name] ~= nil then
						local var_130_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_18.prefab_name].transform, "story_v_out_123112", "123112031", "story_v_out_123112.awb")

						arg_127_1:RecordAudio("123112031", var_130_24)
						arg_127_1:RecordAudio("123112031", var_130_24)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_123112", "123112031", "story_v_out_123112.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_123112", "123112031", "story_v_out_123112.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_25 = math.max(var_130_16, arg_127_1.talkMaxDuration)

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_25 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_15) / var_130_25

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_15 + var_130_25 and arg_127_1.time_ < var_130_15 + var_130_25 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play123112032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 123112032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play123112033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1055ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1055ui_story == nil then
				arg_131_1.var_.characterEffect1055ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1055ui_story and not isNil(var_134_0) then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1055ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1055ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1055ui_story.fillRatio = var_134_5
			end

			local var_134_6 = 0
			local var_134_7 = 1.375

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(123112032)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 55
				local var_134_11 = utf8.len(var_134_9)
				local var_134_12 = var_134_10 <= 0 and var_134_7 or var_134_7 * (var_134_11 / var_134_10)

				if var_134_12 > 0 and var_134_7 < var_134_12 then
					arg_131_1.talkMaxDuration = var_134_12

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_13 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_13 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_13

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_13 and arg_131_1.time_ < var_134_6 + var_134_13 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play123112033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 123112033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play123112034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action3_2")
			end

			local var_138_1 = 0
			local var_138_2 = 0.975

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:GetWordFromCfg(123112033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 39
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_2 or var_138_2 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_2 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_8 and arg_135_1.time_ < var_138_1 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play123112034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 123112034
		arg_139_1.duration_ = 3.17

		local var_139_0 = {
			zh = 1.999999999999,
			ja = 3.166
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play123112035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1093ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1093ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0.7, -1.11, -5.88)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1093ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1093ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1093ui_story == nil then
				arg_139_1.var_.characterEffect1093ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect1093ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1093ui_story then
				arg_139_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_1")
			end

			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_142_15 = arg_139_1.actors_["1055ui_story"].transform
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.var_.moveOldPos1055ui_story = var_142_15.localPosition
			end

			local var_142_17 = 0.001

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17
				local var_142_19 = Vector3.New(-0.7, -0.965, -6.2)

				var_142_15.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1055ui_story, var_142_19, var_142_18)

				local var_142_20 = manager.ui.mainCamera.transform.position - var_142_15.position

				var_142_15.forward = Vector3.New(var_142_20.x, var_142_20.y, var_142_20.z)

				local var_142_21 = var_142_15.localEulerAngles

				var_142_21.z = 0
				var_142_21.x = 0
				var_142_15.localEulerAngles = var_142_21
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 then
				var_142_15.localPosition = Vector3.New(-0.7, -0.965, -6.2)

				local var_142_22 = manager.ui.mainCamera.transform.position - var_142_15.position

				var_142_15.forward = Vector3.New(var_142_22.x, var_142_22.y, var_142_22.z)

				local var_142_23 = var_142_15.localEulerAngles

				var_142_23.z = 0
				var_142_23.x = 0
				var_142_15.localEulerAngles = var_142_23
			end

			local var_142_24 = arg_139_1.actors_["1055ui_story"]
			local var_142_25 = 0

			if var_142_25 < arg_139_1.time_ and arg_139_1.time_ <= var_142_25 + arg_142_0 and not isNil(var_142_24) and arg_139_1.var_.characterEffect1055ui_story == nil then
				arg_139_1.var_.characterEffect1055ui_story = var_142_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_26 = 0.200000002980232

			if var_142_25 <= arg_139_1.time_ and arg_139_1.time_ < var_142_25 + var_142_26 and not isNil(var_142_24) then
				local var_142_27 = (arg_139_1.time_ - var_142_25) / var_142_26

				if arg_139_1.var_.characterEffect1055ui_story and not isNil(var_142_24) then
					local var_142_28 = Mathf.Lerp(0, 0.5, var_142_27)

					arg_139_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1055ui_story.fillRatio = var_142_28
				end
			end

			if arg_139_1.time_ >= var_142_25 + var_142_26 and arg_139_1.time_ < var_142_25 + var_142_26 + arg_142_0 and not isNil(var_142_24) and arg_139_1.var_.characterEffect1055ui_story then
				local var_142_29 = 0.5

				arg_139_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1055ui_story.fillRatio = var_142_29
			end

			local var_142_30 = 0

			if var_142_30 < arg_139_1.time_ and arg_139_1.time_ <= var_142_30 + arg_142_0 then
				arg_139_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_142_31 = 0
			local var_142_32 = 0.15

			if var_142_31 < arg_139_1.time_ and arg_139_1.time_ <= var_142_31 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_33 = arg_139_1:FormatText(StoryNameCfg[73].name)

				arg_139_1.leftNameTxt_.text = var_142_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_34 = arg_139_1:GetWordFromCfg(123112034)
				local var_142_35 = arg_139_1:FormatText(var_142_34.content)

				arg_139_1.text_.text = var_142_35

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_36 = 6
				local var_142_37 = utf8.len(var_142_35)
				local var_142_38 = var_142_36 <= 0 and var_142_32 or var_142_32 * (var_142_37 / var_142_36)

				if var_142_38 > 0 and var_142_32 < var_142_38 then
					arg_139_1.talkMaxDuration = var_142_38

					if var_142_38 + var_142_31 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_38 + var_142_31
					end
				end

				arg_139_1.text_.text = var_142_35
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112034", "story_v_out_123112.awb") ~= 0 then
					local var_142_39 = manager.audio:GetVoiceLength("story_v_out_123112", "123112034", "story_v_out_123112.awb") / 1000

					if var_142_39 + var_142_31 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_39 + var_142_31
					end

					if var_142_34.prefab_name ~= "" and arg_139_1.actors_[var_142_34.prefab_name] ~= nil then
						local var_142_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_34.prefab_name].transform, "story_v_out_123112", "123112034", "story_v_out_123112.awb")

						arg_139_1:RecordAudio("123112034", var_142_40)
						arg_139_1:RecordAudio("123112034", var_142_40)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_123112", "123112034", "story_v_out_123112.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_123112", "123112034", "story_v_out_123112.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_41 = math.max(var_142_32, arg_139_1.talkMaxDuration)

			if var_142_31 <= arg_139_1.time_ and arg_139_1.time_ < var_142_31 + var_142_41 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_31) / var_142_41

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_31 + var_142_41 and arg_139_1.time_ < var_142_31 + var_142_41 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play123112035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 123112035
		arg_143_1.duration_ = 9.7

		local var_143_0 = {
			zh = 7.766,
			ja = 9.7
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play123112036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1055ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1055ui_story == nil then
				arg_143_1.var_.characterEffect1055ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1055ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1055ui_story then
				arg_143_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_146_4 = 0

			if var_146_4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_146_5 = 0

			if var_146_5 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_146_6 = arg_143_1.actors_["1093ui_story"]
			local var_146_7 = 0

			if var_146_7 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect1093ui_story == nil then
				arg_143_1.var_.characterEffect1093ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_8 = 0.200000002980232

			if var_146_7 <= arg_143_1.time_ and arg_143_1.time_ < var_146_7 + var_146_8 and not isNil(var_146_6) then
				local var_146_9 = (arg_143_1.time_ - var_146_7) / var_146_8

				if arg_143_1.var_.characterEffect1093ui_story and not isNil(var_146_6) then
					local var_146_10 = Mathf.Lerp(0, 0.5, var_146_9)

					arg_143_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1093ui_story.fillRatio = var_146_10
				end
			end

			if arg_143_1.time_ >= var_146_7 + var_146_8 and arg_143_1.time_ < var_146_7 + var_146_8 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect1093ui_story then
				local var_146_11 = 0.5

				arg_143_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1093ui_story.fillRatio = var_146_11
			end

			local var_146_12 = 0
			local var_146_13 = 0.875

			if var_146_12 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_14 = arg_143_1:FormatText(StoryNameCfg[481].name)

				arg_143_1.leftNameTxt_.text = var_146_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_15 = arg_143_1:GetWordFromCfg(123112035)
				local var_146_16 = arg_143_1:FormatText(var_146_15.content)

				arg_143_1.text_.text = var_146_16

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_17 = 35
				local var_146_18 = utf8.len(var_146_16)
				local var_146_19 = var_146_17 <= 0 and var_146_13 or var_146_13 * (var_146_18 / var_146_17)

				if var_146_19 > 0 and var_146_13 < var_146_19 then
					arg_143_1.talkMaxDuration = var_146_19

					if var_146_19 + var_146_12 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_19 + var_146_12
					end
				end

				arg_143_1.text_.text = var_146_16
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112035", "story_v_out_123112.awb") ~= 0 then
					local var_146_20 = manager.audio:GetVoiceLength("story_v_out_123112", "123112035", "story_v_out_123112.awb") / 1000

					if var_146_20 + var_146_12 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_20 + var_146_12
					end

					if var_146_15.prefab_name ~= "" and arg_143_1.actors_[var_146_15.prefab_name] ~= nil then
						local var_146_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_15.prefab_name].transform, "story_v_out_123112", "123112035", "story_v_out_123112.awb")

						arg_143_1:RecordAudio("123112035", var_146_21)
						arg_143_1:RecordAudio("123112035", var_146_21)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_123112", "123112035", "story_v_out_123112.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_123112", "123112035", "story_v_out_123112.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_22 = math.max(var_146_13, arg_143_1.talkMaxDuration)

			if var_146_12 <= arg_143_1.time_ and arg_143_1.time_ < var_146_12 + var_146_22 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_12) / var_146_22

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_12 + var_146_22 and arg_143_1.time_ < var_146_12 + var_146_22 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play123112036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 123112036
		arg_147_1.duration_ = 5.57

		local var_147_0 = {
			zh = 4.666,
			ja = 5.566
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play123112037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1093ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1093ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0.7, -1.11, -5.88)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1093ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1093ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1093ui_story == nil then
				arg_147_1.var_.characterEffect1093ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect1093ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1093ui_story then
				arg_147_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_150_14 = arg_147_1.actors_["1055ui_story"]
			local var_150_15 = 0

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 and not isNil(var_150_14) and arg_147_1.var_.characterEffect1055ui_story == nil then
				arg_147_1.var_.characterEffect1055ui_story = var_150_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_16 = 0.200000002980232

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_16 and not isNil(var_150_14) then
				local var_150_17 = (arg_147_1.time_ - var_150_15) / var_150_16

				if arg_147_1.var_.characterEffect1055ui_story and not isNil(var_150_14) then
					local var_150_18 = Mathf.Lerp(0, 0.5, var_150_17)

					arg_147_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1055ui_story.fillRatio = var_150_18
				end
			end

			if arg_147_1.time_ >= var_150_15 + var_150_16 and arg_147_1.time_ < var_150_15 + var_150_16 + arg_150_0 and not isNil(var_150_14) and arg_147_1.var_.characterEffect1055ui_story then
				local var_150_19 = 0.5

				arg_147_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1055ui_story.fillRatio = var_150_19
			end

			local var_150_20 = 0

			if var_150_20 < arg_147_1.time_ and arg_147_1.time_ <= var_150_20 + arg_150_0 then
				arg_147_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action486")
			end

			local var_150_21 = 0
			local var_150_22 = 0.575

			if var_150_21 < arg_147_1.time_ and arg_147_1.time_ <= var_150_21 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_23 = arg_147_1:FormatText(StoryNameCfg[73].name)

				arg_147_1.leftNameTxt_.text = var_150_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_24 = arg_147_1:GetWordFromCfg(123112036)
				local var_150_25 = arg_147_1:FormatText(var_150_24.content)

				arg_147_1.text_.text = var_150_25

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_26 = 22
				local var_150_27 = utf8.len(var_150_25)
				local var_150_28 = var_150_26 <= 0 and var_150_22 or var_150_22 * (var_150_27 / var_150_26)

				if var_150_28 > 0 and var_150_22 < var_150_28 then
					arg_147_1.talkMaxDuration = var_150_28

					if var_150_28 + var_150_21 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_28 + var_150_21
					end
				end

				arg_147_1.text_.text = var_150_25
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112036", "story_v_out_123112.awb") ~= 0 then
					local var_150_29 = manager.audio:GetVoiceLength("story_v_out_123112", "123112036", "story_v_out_123112.awb") / 1000

					if var_150_29 + var_150_21 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_29 + var_150_21
					end

					if var_150_24.prefab_name ~= "" and arg_147_1.actors_[var_150_24.prefab_name] ~= nil then
						local var_150_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_24.prefab_name].transform, "story_v_out_123112", "123112036", "story_v_out_123112.awb")

						arg_147_1:RecordAudio("123112036", var_150_30)
						arg_147_1:RecordAudio("123112036", var_150_30)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_123112", "123112036", "story_v_out_123112.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_123112", "123112036", "story_v_out_123112.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_31 = math.max(var_150_22, arg_147_1.talkMaxDuration)

			if var_150_21 <= arg_147_1.time_ and arg_147_1.time_ < var_150_21 + var_150_31 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_21) / var_150_31

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_21 + var_150_31 and arg_147_1.time_ < var_150_21 + var_150_31 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play123112037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 123112037
		arg_151_1.duration_ = 2.5

		local var_151_0 = {
			zh = 2.5,
			ja = 2.433
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play123112038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1055ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1055ui_story == nil then
				arg_151_1.var_.characterEffect1055ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1055ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1055ui_story then
				arg_151_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_154_6 = arg_151_1.actors_["1093ui_story"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1093ui_story == nil then
				arg_151_1.var_.characterEffect1093ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.200000002980232

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 and not isNil(var_154_6) then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8

				if arg_151_1.var_.characterEffect1093ui_story and not isNil(var_154_6) then
					local var_154_10 = Mathf.Lerp(0, 0.5, var_154_9)

					arg_151_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1093ui_story.fillRatio = var_154_10
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1093ui_story then
				local var_154_11 = 0.5

				arg_151_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1093ui_story.fillRatio = var_154_11
			end

			local var_154_12 = 0
			local var_154_13 = 0.225

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_14 = arg_151_1:FormatText(StoryNameCfg[481].name)

				arg_151_1.leftNameTxt_.text = var_154_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_15 = arg_151_1:GetWordFromCfg(123112037)
				local var_154_16 = arg_151_1:FormatText(var_154_15.content)

				arg_151_1.text_.text = var_154_16

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_17 = 9
				local var_154_18 = utf8.len(var_154_16)
				local var_154_19 = var_154_17 <= 0 and var_154_13 or var_154_13 * (var_154_18 / var_154_17)

				if var_154_19 > 0 and var_154_13 < var_154_19 then
					arg_151_1.talkMaxDuration = var_154_19

					if var_154_19 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_12
					end
				end

				arg_151_1.text_.text = var_154_16
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112037", "story_v_out_123112.awb") ~= 0 then
					local var_154_20 = manager.audio:GetVoiceLength("story_v_out_123112", "123112037", "story_v_out_123112.awb") / 1000

					if var_154_20 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_20 + var_154_12
					end

					if var_154_15.prefab_name ~= "" and arg_151_1.actors_[var_154_15.prefab_name] ~= nil then
						local var_154_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_15.prefab_name].transform, "story_v_out_123112", "123112037", "story_v_out_123112.awb")

						arg_151_1:RecordAudio("123112037", var_154_21)
						arg_151_1:RecordAudio("123112037", var_154_21)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_123112", "123112037", "story_v_out_123112.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_123112", "123112037", "story_v_out_123112.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_22 = math.max(var_154_13, arg_151_1.talkMaxDuration)

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_22 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_12) / var_154_22

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_12 + var_154_22 and arg_151_1.time_ < var_154_12 + var_154_22 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play123112038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 123112038
		arg_155_1.duration_ = 10.8

		local var_155_0 = {
			zh = 10.8,
			ja = 9.1
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play123112039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1055ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1055ui_story == nil then
				arg_155_1.var_.characterEffect1055ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1055ui_story and not isNil(var_158_0) then
					local var_158_4 = Mathf.Lerp(0, 0.5, var_158_3)

					arg_155_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1055ui_story.fillRatio = var_158_4
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1055ui_story then
				local var_158_5 = 0.5

				arg_155_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1055ui_story.fillRatio = var_158_5
			end

			local var_158_6 = arg_155_1.actors_["1093ui_story"]
			local var_158_7 = 0

			if var_158_7 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect1093ui_story == nil then
				arg_155_1.var_.characterEffect1093ui_story = var_158_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_8 = 0.200000002980232

			if var_158_7 <= arg_155_1.time_ and arg_155_1.time_ < var_158_7 + var_158_8 and not isNil(var_158_6) then
				local var_158_9 = (arg_155_1.time_ - var_158_7) / var_158_8

				if arg_155_1.var_.characterEffect1093ui_story and not isNil(var_158_6) then
					arg_155_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_7 + var_158_8 and arg_155_1.time_ < var_158_7 + var_158_8 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect1093ui_story then
				arg_155_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_158_10 = 0
			local var_158_11 = 1.075

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_12 = arg_155_1:FormatText(StoryNameCfg[73].name)

				arg_155_1.leftNameTxt_.text = var_158_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_13 = arg_155_1:GetWordFromCfg(123112038)
				local var_158_14 = arg_155_1:FormatText(var_158_13.content)

				arg_155_1.text_.text = var_158_14

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_15 = 43
				local var_158_16 = utf8.len(var_158_14)
				local var_158_17 = var_158_15 <= 0 and var_158_11 or var_158_11 * (var_158_16 / var_158_15)

				if var_158_17 > 0 and var_158_11 < var_158_17 then
					arg_155_1.talkMaxDuration = var_158_17

					if var_158_17 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_10
					end
				end

				arg_155_1.text_.text = var_158_14
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112038", "story_v_out_123112.awb") ~= 0 then
					local var_158_18 = manager.audio:GetVoiceLength("story_v_out_123112", "123112038", "story_v_out_123112.awb") / 1000

					if var_158_18 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_18 + var_158_10
					end

					if var_158_13.prefab_name ~= "" and arg_155_1.actors_[var_158_13.prefab_name] ~= nil then
						local var_158_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_13.prefab_name].transform, "story_v_out_123112", "123112038", "story_v_out_123112.awb")

						arg_155_1:RecordAudio("123112038", var_158_19)
						arg_155_1:RecordAudio("123112038", var_158_19)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_123112", "123112038", "story_v_out_123112.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_123112", "123112038", "story_v_out_123112.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_20 = math.max(var_158_11, arg_155_1.talkMaxDuration)

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_20 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_10) / var_158_20

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_10 + var_158_20 and arg_155_1.time_ < var_158_10 + var_158_20 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play123112039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 123112039
		arg_159_1.duration_ = 13.17

		local var_159_0 = {
			zh = 11.933,
			ja = 13.166
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play123112040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_1 = 0
			local var_162_2 = 1.1

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_3 = arg_159_1:FormatText(StoryNameCfg[73].name)

				arg_159_1.leftNameTxt_.text = var_162_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:GetWordFromCfg(123112039)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 44
				local var_162_7 = utf8.len(var_162_5)
				local var_162_8 = var_162_6 <= 0 and var_162_2 or var_162_2 * (var_162_7 / var_162_6)

				if var_162_8 > 0 and var_162_2 < var_162_8 then
					arg_159_1.talkMaxDuration = var_162_8

					if var_162_8 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112039", "story_v_out_123112.awb") ~= 0 then
					local var_162_9 = manager.audio:GetVoiceLength("story_v_out_123112", "123112039", "story_v_out_123112.awb") / 1000

					if var_162_9 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_1
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_123112", "123112039", "story_v_out_123112.awb")

						arg_159_1:RecordAudio("123112039", var_162_10)
						arg_159_1:RecordAudio("123112039", var_162_10)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_123112", "123112039", "story_v_out_123112.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_123112", "123112039", "story_v_out_123112.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_11 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_11 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_11

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_11 and arg_159_1.time_ < var_162_1 + var_162_11 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play123112040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 123112040
		arg_163_1.duration_ = 4.17

		local var_163_0 = {
			zh = 2.866,
			ja = 4.166
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play123112041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1055ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1055ui_story == nil then
				arg_163_1.var_.characterEffect1055ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1055ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1055ui_story then
				arg_163_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_166_4 = 0

			if var_166_4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_1")
			end

			local var_166_5 = 0

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_166_6 = arg_163_1.actors_["1093ui_story"]
			local var_166_7 = 0

			if var_166_7 < arg_163_1.time_ and arg_163_1.time_ <= var_166_7 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1093ui_story == nil then
				arg_163_1.var_.characterEffect1093ui_story = var_166_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_8 = 0.200000002980232

			if var_166_7 <= arg_163_1.time_ and arg_163_1.time_ < var_166_7 + var_166_8 and not isNil(var_166_6) then
				local var_166_9 = (arg_163_1.time_ - var_166_7) / var_166_8

				if arg_163_1.var_.characterEffect1093ui_story and not isNil(var_166_6) then
					local var_166_10 = Mathf.Lerp(0, 0.5, var_166_9)

					arg_163_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1093ui_story.fillRatio = var_166_10
				end
			end

			if arg_163_1.time_ >= var_166_7 + var_166_8 and arg_163_1.time_ < var_166_7 + var_166_8 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1093ui_story then
				local var_166_11 = 0.5

				arg_163_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1093ui_story.fillRatio = var_166_11
			end

			local var_166_12 = 0
			local var_166_13 = 0.25

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_14 = arg_163_1:FormatText(StoryNameCfg[481].name)

				arg_163_1.leftNameTxt_.text = var_166_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_15 = arg_163_1:GetWordFromCfg(123112040)
				local var_166_16 = arg_163_1:FormatText(var_166_15.content)

				arg_163_1.text_.text = var_166_16

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_17 = 10
				local var_166_18 = utf8.len(var_166_16)
				local var_166_19 = var_166_17 <= 0 and var_166_13 or var_166_13 * (var_166_18 / var_166_17)

				if var_166_19 > 0 and var_166_13 < var_166_19 then
					arg_163_1.talkMaxDuration = var_166_19

					if var_166_19 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_19 + var_166_12
					end
				end

				arg_163_1.text_.text = var_166_16
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112040", "story_v_out_123112.awb") ~= 0 then
					local var_166_20 = manager.audio:GetVoiceLength("story_v_out_123112", "123112040", "story_v_out_123112.awb") / 1000

					if var_166_20 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_20 + var_166_12
					end

					if var_166_15.prefab_name ~= "" and arg_163_1.actors_[var_166_15.prefab_name] ~= nil then
						local var_166_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_15.prefab_name].transform, "story_v_out_123112", "123112040", "story_v_out_123112.awb")

						arg_163_1:RecordAudio("123112040", var_166_21)
						arg_163_1:RecordAudio("123112040", var_166_21)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_123112", "123112040", "story_v_out_123112.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_123112", "123112040", "story_v_out_123112.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_22 = math.max(var_166_13, arg_163_1.talkMaxDuration)

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_22 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_12) / var_166_22

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_12 + var_166_22 and arg_163_1.time_ < var_166_12 + var_166_22 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play123112041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 123112041
		arg_167_1.duration_ = 2.63

		local var_167_0 = {
			zh = 1.999999999999,
			ja = 2.633
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play123112042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1093ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1093ui_story == nil then
				arg_167_1.var_.characterEffect1093ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1093ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1093ui_story then
				arg_167_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_170_4 = 0

			if var_170_4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_170_5 = arg_167_1.actors_["1055ui_story"]
			local var_170_6 = 0

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1055ui_story == nil then
				arg_167_1.var_.characterEffect1055ui_story = var_170_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_7 = 0.200000002980232

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_7 and not isNil(var_170_5) then
				local var_170_8 = (arg_167_1.time_ - var_170_6) / var_170_7

				if arg_167_1.var_.characterEffect1055ui_story and not isNil(var_170_5) then
					local var_170_9 = Mathf.Lerp(0, 0.5, var_170_8)

					arg_167_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1055ui_story.fillRatio = var_170_9
				end
			end

			if arg_167_1.time_ >= var_170_6 + var_170_7 and arg_167_1.time_ < var_170_6 + var_170_7 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1055ui_story then
				local var_170_10 = 0.5

				arg_167_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1055ui_story.fillRatio = var_170_10
			end

			local var_170_11 = 0
			local var_170_12 = 0.2

			if var_170_11 < arg_167_1.time_ and arg_167_1.time_ <= var_170_11 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_13 = arg_167_1:FormatText(StoryNameCfg[73].name)

				arg_167_1.leftNameTxt_.text = var_170_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_14 = arg_167_1:GetWordFromCfg(123112041)
				local var_170_15 = arg_167_1:FormatText(var_170_14.content)

				arg_167_1.text_.text = var_170_15

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_16 = 8
				local var_170_17 = utf8.len(var_170_15)
				local var_170_18 = var_170_16 <= 0 and var_170_12 or var_170_12 * (var_170_17 / var_170_16)

				if var_170_18 > 0 and var_170_12 < var_170_18 then
					arg_167_1.talkMaxDuration = var_170_18

					if var_170_18 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_18 + var_170_11
					end
				end

				arg_167_1.text_.text = var_170_15
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112041", "story_v_out_123112.awb") ~= 0 then
					local var_170_19 = manager.audio:GetVoiceLength("story_v_out_123112", "123112041", "story_v_out_123112.awb") / 1000

					if var_170_19 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_19 + var_170_11
					end

					if var_170_14.prefab_name ~= "" and arg_167_1.actors_[var_170_14.prefab_name] ~= nil then
						local var_170_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_14.prefab_name].transform, "story_v_out_123112", "123112041", "story_v_out_123112.awb")

						arg_167_1:RecordAudio("123112041", var_170_20)
						arg_167_1:RecordAudio("123112041", var_170_20)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_123112", "123112041", "story_v_out_123112.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_123112", "123112041", "story_v_out_123112.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_21 = math.max(var_170_12, arg_167_1.talkMaxDuration)

			if var_170_11 <= arg_167_1.time_ and arg_167_1.time_ < var_170_11 + var_170_21 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_11) / var_170_21

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_11 + var_170_21 and arg_167_1.time_ < var_170_11 + var_170_21 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play123112042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 123112042
		arg_171_1.duration_ = 11.83

		local var_171_0 = {
			zh = 11.833,
			ja = 9.5
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play123112043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1055ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1055ui_story == nil then
				arg_171_1.var_.characterEffect1055ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1055ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1055ui_story then
				arg_171_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_174_4 = 0

			if var_174_4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055actionlink/1055action425")
			end

			local var_174_5 = 0

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_174_6 = arg_171_1.actors_["1093ui_story"]
			local var_174_7 = 0

			if var_174_7 < arg_171_1.time_ and arg_171_1.time_ <= var_174_7 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect1093ui_story == nil then
				arg_171_1.var_.characterEffect1093ui_story = var_174_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_8 = 0.200000002980232

			if var_174_7 <= arg_171_1.time_ and arg_171_1.time_ < var_174_7 + var_174_8 and not isNil(var_174_6) then
				local var_174_9 = (arg_171_1.time_ - var_174_7) / var_174_8

				if arg_171_1.var_.characterEffect1093ui_story and not isNil(var_174_6) then
					local var_174_10 = Mathf.Lerp(0, 0.5, var_174_9)

					arg_171_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1093ui_story.fillRatio = var_174_10
				end
			end

			if arg_171_1.time_ >= var_174_7 + var_174_8 and arg_171_1.time_ < var_174_7 + var_174_8 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect1093ui_story then
				local var_174_11 = 0.5

				arg_171_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1093ui_story.fillRatio = var_174_11
			end

			local var_174_12 = 0
			local var_174_13 = 1.275

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_14 = arg_171_1:FormatText(StoryNameCfg[481].name)

				arg_171_1.leftNameTxt_.text = var_174_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_15 = arg_171_1:GetWordFromCfg(123112042)
				local var_174_16 = arg_171_1:FormatText(var_174_15.content)

				arg_171_1.text_.text = var_174_16

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_17 = 51
				local var_174_18 = utf8.len(var_174_16)
				local var_174_19 = var_174_17 <= 0 and var_174_13 or var_174_13 * (var_174_18 / var_174_17)

				if var_174_19 > 0 and var_174_13 < var_174_19 then
					arg_171_1.talkMaxDuration = var_174_19

					if var_174_19 + var_174_12 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_19 + var_174_12
					end
				end

				arg_171_1.text_.text = var_174_16
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112042", "story_v_out_123112.awb") ~= 0 then
					local var_174_20 = manager.audio:GetVoiceLength("story_v_out_123112", "123112042", "story_v_out_123112.awb") / 1000

					if var_174_20 + var_174_12 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_20 + var_174_12
					end

					if var_174_15.prefab_name ~= "" and arg_171_1.actors_[var_174_15.prefab_name] ~= nil then
						local var_174_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_15.prefab_name].transform, "story_v_out_123112", "123112042", "story_v_out_123112.awb")

						arg_171_1:RecordAudio("123112042", var_174_21)
						arg_171_1:RecordAudio("123112042", var_174_21)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_123112", "123112042", "story_v_out_123112.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_123112", "123112042", "story_v_out_123112.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_22 = math.max(var_174_13, arg_171_1.talkMaxDuration)

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_22 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_12) / var_174_22

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_12 + var_174_22 and arg_171_1.time_ < var_174_12 + var_174_22 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play123112043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 123112043
		arg_175_1.duration_ = 6.43

		local var_175_0 = {
			zh = 6.433,
			ja = 6.166
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play123112044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1055ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1055ui_story == nil then
				arg_175_1.var_.characterEffect1055ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1055ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1055ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1055ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1055ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_178_7 = arg_175_1.actors_["1093ui_story"]
			local var_178_8 = 0

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.characterEffect1093ui_story == nil then
				arg_175_1.var_.characterEffect1093ui_story = var_178_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_9 = 0.200000002980232

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_9 and not isNil(var_178_7) then
				local var_178_10 = (arg_175_1.time_ - var_178_8) / var_178_9

				if arg_175_1.var_.characterEffect1093ui_story and not isNil(var_178_7) then
					arg_175_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_8 + var_178_9 and arg_175_1.time_ < var_178_8 + var_178_9 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.characterEffect1093ui_story then
				arg_175_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_178_11 = 0
			local var_178_12 = 0.7

			if var_178_11 < arg_175_1.time_ and arg_175_1.time_ <= var_178_11 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_13 = arg_175_1:FormatText(StoryNameCfg[73].name)

				arg_175_1.leftNameTxt_.text = var_178_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_14 = arg_175_1:GetWordFromCfg(123112043)
				local var_178_15 = arg_175_1:FormatText(var_178_14.content)

				arg_175_1.text_.text = var_178_15

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_16 = 28
				local var_178_17 = utf8.len(var_178_15)
				local var_178_18 = var_178_16 <= 0 and var_178_12 or var_178_12 * (var_178_17 / var_178_16)

				if var_178_18 > 0 and var_178_12 < var_178_18 then
					arg_175_1.talkMaxDuration = var_178_18

					if var_178_18 + var_178_11 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_18 + var_178_11
					end
				end

				arg_175_1.text_.text = var_178_15
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112043", "story_v_out_123112.awb") ~= 0 then
					local var_178_19 = manager.audio:GetVoiceLength("story_v_out_123112", "123112043", "story_v_out_123112.awb") / 1000

					if var_178_19 + var_178_11 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_19 + var_178_11
					end

					if var_178_14.prefab_name ~= "" and arg_175_1.actors_[var_178_14.prefab_name] ~= nil then
						local var_178_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_14.prefab_name].transform, "story_v_out_123112", "123112043", "story_v_out_123112.awb")

						arg_175_1:RecordAudio("123112043", var_178_20)
						arg_175_1:RecordAudio("123112043", var_178_20)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_123112", "123112043", "story_v_out_123112.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_123112", "123112043", "story_v_out_123112.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_21 = math.max(var_178_12, arg_175_1.talkMaxDuration)

			if var_178_11 <= arg_175_1.time_ and arg_175_1.time_ < var_178_11 + var_178_21 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_11) / var_178_21

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_11 + var_178_21 and arg_175_1.time_ < var_178_11 + var_178_21 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play123112044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 123112044
		arg_179_1.duration_ = 3.1

		local var_179_0 = {
			zh = 3,
			ja = 3.1
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play123112045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action467")
			end

			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_182_2 = 0
			local var_182_3 = 0.275

			if var_182_2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_4 = arg_179_1:FormatText(StoryNameCfg[73].name)

				arg_179_1.leftNameTxt_.text = var_182_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_5 = arg_179_1:GetWordFromCfg(123112044)
				local var_182_6 = arg_179_1:FormatText(var_182_5.content)

				arg_179_1.text_.text = var_182_6

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 11
				local var_182_8 = utf8.len(var_182_6)
				local var_182_9 = var_182_7 <= 0 and var_182_3 or var_182_3 * (var_182_8 / var_182_7)

				if var_182_9 > 0 and var_182_3 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_6
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112044", "story_v_out_123112.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112044", "story_v_out_123112.awb") / 1000

					if var_182_10 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_2
					end

					if var_182_5.prefab_name ~= "" and arg_179_1.actors_[var_182_5.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_5.prefab_name].transform, "story_v_out_123112", "123112044", "story_v_out_123112.awb")

						arg_179_1:RecordAudio("123112044", var_182_11)
						arg_179_1:RecordAudio("123112044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_123112", "123112044", "story_v_out_123112.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_123112", "123112044", "story_v_out_123112.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_12 and arg_179_1.time_ < var_182_2 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play123112045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 123112045
		arg_183_1.duration_ = 2.7

		local var_183_0 = {
			zh = 2.7,
			ja = 2.466
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play123112046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1055ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1055ui_story == nil then
				arg_183_1.var_.characterEffect1055ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1055ui_story and not isNil(var_186_0) then
					arg_183_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1055ui_story then
				arg_183_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_186_4 = 0

			if var_186_4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_2")
			end

			local var_186_5 = 0

			if var_186_5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_186_6 = arg_183_1.actors_["1093ui_story"]
			local var_186_7 = 0

			if var_186_7 < arg_183_1.time_ and arg_183_1.time_ <= var_186_7 + arg_186_0 and not isNil(var_186_6) and arg_183_1.var_.characterEffect1093ui_story == nil then
				arg_183_1.var_.characterEffect1093ui_story = var_186_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_8 = 0.200000002980232

			if var_186_7 <= arg_183_1.time_ and arg_183_1.time_ < var_186_7 + var_186_8 and not isNil(var_186_6) then
				local var_186_9 = (arg_183_1.time_ - var_186_7) / var_186_8

				if arg_183_1.var_.characterEffect1093ui_story and not isNil(var_186_6) then
					local var_186_10 = Mathf.Lerp(0, 0.5, var_186_9)

					arg_183_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1093ui_story.fillRatio = var_186_10
				end
			end

			if arg_183_1.time_ >= var_186_7 + var_186_8 and arg_183_1.time_ < var_186_7 + var_186_8 + arg_186_0 and not isNil(var_186_6) and arg_183_1.var_.characterEffect1093ui_story then
				local var_186_11 = 0.5

				arg_183_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1093ui_story.fillRatio = var_186_11
			end

			local var_186_12 = 0
			local var_186_13 = 0.15

			if var_186_12 < arg_183_1.time_ and arg_183_1.time_ <= var_186_12 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_14 = arg_183_1:FormatText(StoryNameCfg[481].name)

				arg_183_1.leftNameTxt_.text = var_186_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_15 = arg_183_1:GetWordFromCfg(123112045)
				local var_186_16 = arg_183_1:FormatText(var_186_15.content)

				arg_183_1.text_.text = var_186_16

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_17 = 6
				local var_186_18 = utf8.len(var_186_16)
				local var_186_19 = var_186_17 <= 0 and var_186_13 or var_186_13 * (var_186_18 / var_186_17)

				if var_186_19 > 0 and var_186_13 < var_186_19 then
					arg_183_1.talkMaxDuration = var_186_19

					if var_186_19 + var_186_12 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_19 + var_186_12
					end
				end

				arg_183_1.text_.text = var_186_16
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112045", "story_v_out_123112.awb") ~= 0 then
					local var_186_20 = manager.audio:GetVoiceLength("story_v_out_123112", "123112045", "story_v_out_123112.awb") / 1000

					if var_186_20 + var_186_12 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_20 + var_186_12
					end

					if var_186_15.prefab_name ~= "" and arg_183_1.actors_[var_186_15.prefab_name] ~= nil then
						local var_186_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_15.prefab_name].transform, "story_v_out_123112", "123112045", "story_v_out_123112.awb")

						arg_183_1:RecordAudio("123112045", var_186_21)
						arg_183_1:RecordAudio("123112045", var_186_21)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_123112", "123112045", "story_v_out_123112.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_123112", "123112045", "story_v_out_123112.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_22 = math.max(var_186_13, arg_183_1.talkMaxDuration)

			if var_186_12 <= arg_183_1.time_ and arg_183_1.time_ < var_186_12 + var_186_22 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_12) / var_186_22

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_12 + var_186_22 and arg_183_1.time_ < var_186_12 + var_186_22 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play123112046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 123112046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play123112047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1093ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1093ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(0, 100, 0)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1093ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, 100, 0)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["1093ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1093ui_story == nil then
				arg_187_1.var_.characterEffect1093ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 and not isNil(var_190_9) then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect1093ui_story and not isNil(var_190_9) then
					local var_190_13 = Mathf.Lerp(0, 0.5, var_190_12)

					arg_187_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1093ui_story.fillRatio = var_190_13
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1093ui_story then
				local var_190_14 = 0.5

				arg_187_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1093ui_story.fillRatio = var_190_14
			end

			local var_190_15 = arg_187_1.actors_["1055ui_story"].transform
			local var_190_16 = 0

			if var_190_16 < arg_187_1.time_ and arg_187_1.time_ <= var_190_16 + arg_190_0 then
				arg_187_1.var_.moveOldPos1055ui_story = var_190_15.localPosition
			end

			local var_190_17 = 0.001

			if var_190_16 <= arg_187_1.time_ and arg_187_1.time_ < var_190_16 + var_190_17 then
				local var_190_18 = (arg_187_1.time_ - var_190_16) / var_190_17
				local var_190_19 = Vector3.New(0, 100, 0)

				var_190_15.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1055ui_story, var_190_19, var_190_18)

				local var_190_20 = manager.ui.mainCamera.transform.position - var_190_15.position

				var_190_15.forward = Vector3.New(var_190_20.x, var_190_20.y, var_190_20.z)

				local var_190_21 = var_190_15.localEulerAngles

				var_190_21.z = 0
				var_190_21.x = 0
				var_190_15.localEulerAngles = var_190_21
			end

			if arg_187_1.time_ >= var_190_16 + var_190_17 and arg_187_1.time_ < var_190_16 + var_190_17 + arg_190_0 then
				var_190_15.localPosition = Vector3.New(0, 100, 0)

				local var_190_22 = manager.ui.mainCamera.transform.position - var_190_15.position

				var_190_15.forward = Vector3.New(var_190_22.x, var_190_22.y, var_190_22.z)

				local var_190_23 = var_190_15.localEulerAngles

				var_190_23.z = 0
				var_190_23.x = 0
				var_190_15.localEulerAngles = var_190_23
			end

			local var_190_24 = arg_187_1.actors_["1055ui_story"]
			local var_190_25 = 0

			if var_190_25 < arg_187_1.time_ and arg_187_1.time_ <= var_190_25 + arg_190_0 and not isNil(var_190_24) and arg_187_1.var_.characterEffect1055ui_story == nil then
				arg_187_1.var_.characterEffect1055ui_story = var_190_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_26 = 0.200000002980232

			if var_190_25 <= arg_187_1.time_ and arg_187_1.time_ < var_190_25 + var_190_26 and not isNil(var_190_24) then
				local var_190_27 = (arg_187_1.time_ - var_190_25) / var_190_26

				if arg_187_1.var_.characterEffect1055ui_story and not isNil(var_190_24) then
					local var_190_28 = Mathf.Lerp(0, 0.5, var_190_27)

					arg_187_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1055ui_story.fillRatio = var_190_28
				end
			end

			if arg_187_1.time_ >= var_190_25 + var_190_26 and arg_187_1.time_ < var_190_25 + var_190_26 + arg_190_0 and not isNil(var_190_24) and arg_187_1.var_.characterEffect1055ui_story then
				local var_190_29 = 0.5

				arg_187_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1055ui_story.fillRatio = var_190_29
			end

			local var_190_30 = 0
			local var_190_31 = 0.775

			if var_190_30 < arg_187_1.time_ and arg_187_1.time_ <= var_190_30 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_32 = arg_187_1:GetWordFromCfg(123112046)
				local var_190_33 = arg_187_1:FormatText(var_190_32.content)

				arg_187_1.text_.text = var_190_33

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_34 = 31
				local var_190_35 = utf8.len(var_190_33)
				local var_190_36 = var_190_34 <= 0 and var_190_31 or var_190_31 * (var_190_35 / var_190_34)

				if var_190_36 > 0 and var_190_31 < var_190_36 then
					arg_187_1.talkMaxDuration = var_190_36

					if var_190_36 + var_190_30 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_36 + var_190_30
					end
				end

				arg_187_1.text_.text = var_190_33
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_37 = math.max(var_190_31, arg_187_1.talkMaxDuration)

			if var_190_30 <= arg_187_1.time_ and arg_187_1.time_ < var_190_30 + var_190_37 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_30) / var_190_37

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_30 + var_190_37 and arg_187_1.time_ < var_190_30 + var_190_37 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play123112047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 123112047
		arg_191_1.duration_ = 6.23

		local var_191_0 = {
			zh = 6.233,
			ja = 5.4
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play123112048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1055ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1055ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, -0.965, -6.2)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1055ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["1055ui_story"]
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1055ui_story == nil then
				arg_191_1.var_.characterEffect1055ui_story = var_194_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_11 = 0.200000002980232

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 and not isNil(var_194_9) then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11

				if arg_191_1.var_.characterEffect1055ui_story and not isNil(var_194_9) then
					arg_191_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1055ui_story then
				arg_191_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_194_13 = 0

			if var_194_13 < arg_191_1.time_ and arg_191_1.time_ <= var_194_13 + arg_194_0 then
				arg_191_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_194_14 = 0

			if var_194_14 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_194_15 = 0
			local var_194_16 = 0.725

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_17 = arg_191_1:FormatText(StoryNameCfg[481].name)

				arg_191_1.leftNameTxt_.text = var_194_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_18 = arg_191_1:GetWordFromCfg(123112047)
				local var_194_19 = arg_191_1:FormatText(var_194_18.content)

				arg_191_1.text_.text = var_194_19

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_20 = 29
				local var_194_21 = utf8.len(var_194_19)
				local var_194_22 = var_194_20 <= 0 and var_194_16 or var_194_16 * (var_194_21 / var_194_20)

				if var_194_22 > 0 and var_194_16 < var_194_22 then
					arg_191_1.talkMaxDuration = var_194_22

					if var_194_22 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_22 + var_194_15
					end
				end

				arg_191_1.text_.text = var_194_19
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112047", "story_v_out_123112.awb") ~= 0 then
					local var_194_23 = manager.audio:GetVoiceLength("story_v_out_123112", "123112047", "story_v_out_123112.awb") / 1000

					if var_194_23 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_15
					end

					if var_194_18.prefab_name ~= "" and arg_191_1.actors_[var_194_18.prefab_name] ~= nil then
						local var_194_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_18.prefab_name].transform, "story_v_out_123112", "123112047", "story_v_out_123112.awb")

						arg_191_1:RecordAudio("123112047", var_194_24)
						arg_191_1:RecordAudio("123112047", var_194_24)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_123112", "123112047", "story_v_out_123112.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_123112", "123112047", "story_v_out_123112.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_25 = math.max(var_194_16, arg_191_1.talkMaxDuration)

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_25 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_15) / var_194_25

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_15 + var_194_25 and arg_191_1.time_ < var_194_15 + var_194_25 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play123112048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 123112048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play123112049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1055ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1055ui_story == nil then
				arg_195_1.var_.characterEffect1055ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1055ui_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1055ui_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1055ui_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1055ui_story.fillRatio = var_198_5
			end

			local var_198_6 = 0
			local var_198_7 = 0.275

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_8 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_9 = arg_195_1:GetWordFromCfg(123112048)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 11
				local var_198_12 = utf8.len(var_198_10)
				local var_198_13 = var_198_11 <= 0 and var_198_7 or var_198_7 * (var_198_12 / var_198_11)

				if var_198_13 > 0 and var_198_7 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play123112049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 123112049
		arg_199_1.duration_ = 2.97

		local var_199_0 = {
			zh = 2.466,
			ja = 2.966
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play123112050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1093ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1093ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0.7, -1.11, -5.88)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1093ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["1093ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1093ui_story == nil then
				arg_199_1.var_.characterEffect1093ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect1093ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1093ui_story then
				arg_199_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_202_15 = arg_199_1.actors_["1055ui_story"].transform
			local var_202_16 = 0

			if var_202_16 < arg_199_1.time_ and arg_199_1.time_ <= var_202_16 + arg_202_0 then
				arg_199_1.var_.moveOldPos1055ui_story = var_202_15.localPosition
			end

			local var_202_17 = 0.001

			if var_202_16 <= arg_199_1.time_ and arg_199_1.time_ < var_202_16 + var_202_17 then
				local var_202_18 = (arg_199_1.time_ - var_202_16) / var_202_17
				local var_202_19 = Vector3.New(-0.7, -0.965, -6.2)

				var_202_15.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1055ui_story, var_202_19, var_202_18)

				local var_202_20 = manager.ui.mainCamera.transform.position - var_202_15.position

				var_202_15.forward = Vector3.New(var_202_20.x, var_202_20.y, var_202_20.z)

				local var_202_21 = var_202_15.localEulerAngles

				var_202_21.z = 0
				var_202_21.x = 0
				var_202_15.localEulerAngles = var_202_21
			end

			if arg_199_1.time_ >= var_202_16 + var_202_17 and arg_199_1.time_ < var_202_16 + var_202_17 + arg_202_0 then
				var_202_15.localPosition = Vector3.New(-0.7, -0.965, -6.2)

				local var_202_22 = manager.ui.mainCamera.transform.position - var_202_15.position

				var_202_15.forward = Vector3.New(var_202_22.x, var_202_22.y, var_202_22.z)

				local var_202_23 = var_202_15.localEulerAngles

				var_202_23.z = 0
				var_202_23.x = 0
				var_202_15.localEulerAngles = var_202_23
			end

			local var_202_24 = 0
			local var_202_25 = 0.275

			if var_202_24 < arg_199_1.time_ and arg_199_1.time_ <= var_202_24 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_26 = arg_199_1:FormatText(StoryNameCfg[73].name)

				arg_199_1.leftNameTxt_.text = var_202_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_27 = arg_199_1:GetWordFromCfg(123112049)
				local var_202_28 = arg_199_1:FormatText(var_202_27.content)

				arg_199_1.text_.text = var_202_28

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_29 = 11
				local var_202_30 = utf8.len(var_202_28)
				local var_202_31 = var_202_29 <= 0 and var_202_25 or var_202_25 * (var_202_30 / var_202_29)

				if var_202_31 > 0 and var_202_25 < var_202_31 then
					arg_199_1.talkMaxDuration = var_202_31

					if var_202_31 + var_202_24 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_31 + var_202_24
					end
				end

				arg_199_1.text_.text = var_202_28
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112049", "story_v_out_123112.awb") ~= 0 then
					local var_202_32 = manager.audio:GetVoiceLength("story_v_out_123112", "123112049", "story_v_out_123112.awb") / 1000

					if var_202_32 + var_202_24 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_32 + var_202_24
					end

					if var_202_27.prefab_name ~= "" and arg_199_1.actors_[var_202_27.prefab_name] ~= nil then
						local var_202_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_27.prefab_name].transform, "story_v_out_123112", "123112049", "story_v_out_123112.awb")

						arg_199_1:RecordAudio("123112049", var_202_33)
						arg_199_1:RecordAudio("123112049", var_202_33)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_123112", "123112049", "story_v_out_123112.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_123112", "123112049", "story_v_out_123112.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_34 = math.max(var_202_25, arg_199_1.talkMaxDuration)

			if var_202_24 <= arg_199_1.time_ and arg_199_1.time_ < var_202_24 + var_202_34 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_24) / var_202_34

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_24 + var_202_34 and arg_199_1.time_ < var_202_24 + var_202_34 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play123112050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 123112050
		arg_203_1.duration_ = 8.27

		local var_203_0 = {
			zh = 8.266,
			ja = 7
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play123112051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1055ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1055ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(-0.7, -0.965, -6.2)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1055ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(-0.7, -0.965, -6.2)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["1055ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1055ui_story == nil then
				arg_203_1.var_.characterEffect1055ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect1055ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1055ui_story then
				arg_203_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_206_15 = arg_203_1.actors_["1093ui_story"]
			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 and not isNil(var_206_15) and arg_203_1.var_.characterEffect1093ui_story == nil then
				arg_203_1.var_.characterEffect1093ui_story = var_206_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_17 = 0.200000002980232

			if var_206_16 <= arg_203_1.time_ and arg_203_1.time_ < var_206_16 + var_206_17 and not isNil(var_206_15) then
				local var_206_18 = (arg_203_1.time_ - var_206_16) / var_206_17

				if arg_203_1.var_.characterEffect1093ui_story and not isNil(var_206_15) then
					local var_206_19 = Mathf.Lerp(0, 0.5, var_206_18)

					arg_203_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1093ui_story.fillRatio = var_206_19
				end
			end

			if arg_203_1.time_ >= var_206_16 + var_206_17 and arg_203_1.time_ < var_206_16 + var_206_17 + arg_206_0 and not isNil(var_206_15) and arg_203_1.var_.characterEffect1093ui_story then
				local var_206_20 = 0.5

				arg_203_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1093ui_story.fillRatio = var_206_20
			end

			local var_206_21 = 0
			local var_206_22 = 0.975

			if var_206_21 < arg_203_1.time_ and arg_203_1.time_ <= var_206_21 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_23 = arg_203_1:FormatText(StoryNameCfg[481].name)

				arg_203_1.leftNameTxt_.text = var_206_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_24 = arg_203_1:GetWordFromCfg(123112050)
				local var_206_25 = arg_203_1:FormatText(var_206_24.content)

				arg_203_1.text_.text = var_206_25

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_26 = 39
				local var_206_27 = utf8.len(var_206_25)
				local var_206_28 = var_206_26 <= 0 and var_206_22 or var_206_22 * (var_206_27 / var_206_26)

				if var_206_28 > 0 and var_206_22 < var_206_28 then
					arg_203_1.talkMaxDuration = var_206_28

					if var_206_28 + var_206_21 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_28 + var_206_21
					end
				end

				arg_203_1.text_.text = var_206_25
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112050", "story_v_out_123112.awb") ~= 0 then
					local var_206_29 = manager.audio:GetVoiceLength("story_v_out_123112", "123112050", "story_v_out_123112.awb") / 1000

					if var_206_29 + var_206_21 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_29 + var_206_21
					end

					if var_206_24.prefab_name ~= "" and arg_203_1.actors_[var_206_24.prefab_name] ~= nil then
						local var_206_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_24.prefab_name].transform, "story_v_out_123112", "123112050", "story_v_out_123112.awb")

						arg_203_1:RecordAudio("123112050", var_206_30)
						arg_203_1:RecordAudio("123112050", var_206_30)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_123112", "123112050", "story_v_out_123112.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_123112", "123112050", "story_v_out_123112.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_31 = math.max(var_206_22, arg_203_1.talkMaxDuration)

			if var_206_21 <= arg_203_1.time_ and arg_203_1.time_ < var_206_21 + var_206_31 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_21) / var_206_31

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_21 + var_206_31 and arg_203_1.time_ < var_206_21 + var_206_31 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play123112051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 123112051
		arg_207_1.duration_ = 4

		local var_207_0 = {
			zh = 4,
			ja = 2.5
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play123112052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1093ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1093ui_story == nil then
				arg_207_1.var_.characterEffect1093ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect1093ui_story and not isNil(var_210_0) then
					arg_207_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1093ui_story then
				arg_207_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_210_4 = 0

			if var_210_4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_210_5 = 0

			if var_210_5 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 then
				arg_207_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_210_6 = arg_207_1.actors_["1055ui_story"]
			local var_210_7 = 0

			if var_210_7 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect1055ui_story == nil then
				arg_207_1.var_.characterEffect1055ui_story = var_210_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_8 = 0.200000002980232

			if var_210_7 <= arg_207_1.time_ and arg_207_1.time_ < var_210_7 + var_210_8 and not isNil(var_210_6) then
				local var_210_9 = (arg_207_1.time_ - var_210_7) / var_210_8

				if arg_207_1.var_.characterEffect1055ui_story and not isNil(var_210_6) then
					local var_210_10 = Mathf.Lerp(0, 0.5, var_210_9)

					arg_207_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1055ui_story.fillRatio = var_210_10
				end
			end

			if arg_207_1.time_ >= var_210_7 + var_210_8 and arg_207_1.time_ < var_210_7 + var_210_8 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect1055ui_story then
				local var_210_11 = 0.5

				arg_207_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1055ui_story.fillRatio = var_210_11
			end

			local var_210_12 = 0
			local var_210_13 = 0.3

			if var_210_12 < arg_207_1.time_ and arg_207_1.time_ <= var_210_12 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_14 = arg_207_1:FormatText(StoryNameCfg[73].name)

				arg_207_1.leftNameTxt_.text = var_210_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_15 = arg_207_1:GetWordFromCfg(123112051)
				local var_210_16 = arg_207_1:FormatText(var_210_15.content)

				arg_207_1.text_.text = var_210_16

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_17 = 12
				local var_210_18 = utf8.len(var_210_16)
				local var_210_19 = var_210_17 <= 0 and var_210_13 or var_210_13 * (var_210_18 / var_210_17)

				if var_210_19 > 0 and var_210_13 < var_210_19 then
					arg_207_1.talkMaxDuration = var_210_19

					if var_210_19 + var_210_12 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_19 + var_210_12
					end
				end

				arg_207_1.text_.text = var_210_16
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112051", "story_v_out_123112.awb") ~= 0 then
					local var_210_20 = manager.audio:GetVoiceLength("story_v_out_123112", "123112051", "story_v_out_123112.awb") / 1000

					if var_210_20 + var_210_12 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_20 + var_210_12
					end

					if var_210_15.prefab_name ~= "" and arg_207_1.actors_[var_210_15.prefab_name] ~= nil then
						local var_210_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_15.prefab_name].transform, "story_v_out_123112", "123112051", "story_v_out_123112.awb")

						arg_207_1:RecordAudio("123112051", var_210_21)
						arg_207_1:RecordAudio("123112051", var_210_21)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_123112", "123112051", "story_v_out_123112.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_123112", "123112051", "story_v_out_123112.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_22 = math.max(var_210_13, arg_207_1.talkMaxDuration)

			if var_210_12 <= arg_207_1.time_ and arg_207_1.time_ < var_210_12 + var_210_22 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_12) / var_210_22

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_12 + var_210_22 and arg_207_1.time_ < var_210_12 + var_210_22 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play123112052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 123112052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play123112053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1093ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1093ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1093ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["1093ui_story"]
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1093ui_story == nil then
				arg_211_1.var_.characterEffect1093ui_story = var_214_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_11 = 0.200000002980232

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 and not isNil(var_214_9) then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11

				if arg_211_1.var_.characterEffect1093ui_story and not isNil(var_214_9) then
					local var_214_13 = Mathf.Lerp(0, 0.5, var_214_12)

					arg_211_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1093ui_story.fillRatio = var_214_13
				end
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1093ui_story then
				local var_214_14 = 0.5

				arg_211_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1093ui_story.fillRatio = var_214_14
			end

			local var_214_15 = arg_211_1.actors_["1055ui_story"].transform
			local var_214_16 = 0

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 then
				arg_211_1.var_.moveOldPos1055ui_story = var_214_15.localPosition
			end

			local var_214_17 = 0.001

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_17 then
				local var_214_18 = (arg_211_1.time_ - var_214_16) / var_214_17
				local var_214_19 = Vector3.New(0, 100, 0)

				var_214_15.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1055ui_story, var_214_19, var_214_18)

				local var_214_20 = manager.ui.mainCamera.transform.position - var_214_15.position

				var_214_15.forward = Vector3.New(var_214_20.x, var_214_20.y, var_214_20.z)

				local var_214_21 = var_214_15.localEulerAngles

				var_214_21.z = 0
				var_214_21.x = 0
				var_214_15.localEulerAngles = var_214_21
			end

			if arg_211_1.time_ >= var_214_16 + var_214_17 and arg_211_1.time_ < var_214_16 + var_214_17 + arg_214_0 then
				var_214_15.localPosition = Vector3.New(0, 100, 0)

				local var_214_22 = manager.ui.mainCamera.transform.position - var_214_15.position

				var_214_15.forward = Vector3.New(var_214_22.x, var_214_22.y, var_214_22.z)

				local var_214_23 = var_214_15.localEulerAngles

				var_214_23.z = 0
				var_214_23.x = 0
				var_214_15.localEulerAngles = var_214_23
			end

			local var_214_24 = arg_211_1.actors_["1055ui_story"]
			local var_214_25 = 0

			if var_214_25 < arg_211_1.time_ and arg_211_1.time_ <= var_214_25 + arg_214_0 and not isNil(var_214_24) and arg_211_1.var_.characterEffect1055ui_story == nil then
				arg_211_1.var_.characterEffect1055ui_story = var_214_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_26 = 0.200000002980232

			if var_214_25 <= arg_211_1.time_ and arg_211_1.time_ < var_214_25 + var_214_26 and not isNil(var_214_24) then
				local var_214_27 = (arg_211_1.time_ - var_214_25) / var_214_26

				if arg_211_1.var_.characterEffect1055ui_story and not isNil(var_214_24) then
					local var_214_28 = Mathf.Lerp(0, 0.5, var_214_27)

					arg_211_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1055ui_story.fillRatio = var_214_28
				end
			end

			if arg_211_1.time_ >= var_214_25 + var_214_26 and arg_211_1.time_ < var_214_25 + var_214_26 + arg_214_0 and not isNil(var_214_24) and arg_211_1.var_.characterEffect1055ui_story then
				local var_214_29 = 0.5

				arg_211_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1055ui_story.fillRatio = var_214_29
			end

			local var_214_30 = 0
			local var_214_31 = 1.25

			if var_214_30 < arg_211_1.time_ and arg_211_1.time_ <= var_214_30 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_32 = arg_211_1:GetWordFromCfg(123112052)
				local var_214_33 = arg_211_1:FormatText(var_214_32.content)

				arg_211_1.text_.text = var_214_33

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_34 = 50
				local var_214_35 = utf8.len(var_214_33)
				local var_214_36 = var_214_34 <= 0 and var_214_31 or var_214_31 * (var_214_35 / var_214_34)

				if var_214_36 > 0 and var_214_31 < var_214_36 then
					arg_211_1.talkMaxDuration = var_214_36

					if var_214_36 + var_214_30 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_36 + var_214_30
					end
				end

				arg_211_1.text_.text = var_214_33
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_37 = math.max(var_214_31, arg_211_1.talkMaxDuration)

			if var_214_30 <= arg_211_1.time_ and arg_211_1.time_ < var_214_30 + var_214_37 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_30) / var_214_37

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_30 + var_214_37 and arg_211_1.time_ < var_214_30 + var_214_37 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play123112053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 123112053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play123112054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.475

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[7].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(123112053)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 19
				local var_218_6 = utf8.len(var_218_4)
				local var_218_7 = var_218_5 <= 0 and var_218_1 or var_218_1 * (var_218_6 / var_218_5)

				if var_218_7 > 0 and var_218_1 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_8 and arg_215_1.time_ < var_218_0 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play123112054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 123112054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play123112055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.325

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(123112054)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 13
				local var_222_5 = utf8.len(var_222_3)
				local var_222_6 = var_222_4 <= 0 and var_222_1 or var_222_1 * (var_222_5 / var_222_4)

				if var_222_6 > 0 and var_222_1 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_7 and arg_219_1.time_ < var_222_0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play123112055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 123112055
		arg_223_1.duration_ = 4.3

		local var_223_0 = {
			zh = 4.3,
			ja = 4.2
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play123112056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1093ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1093ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0.7, -1.11, -5.88)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1093ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = arg_223_1.actors_["1093ui_story"]
			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1093ui_story == nil then
				arg_223_1.var_.characterEffect1093ui_story = var_226_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_11 = 0.200000002980232

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_11 and not isNil(var_226_9) then
				local var_226_12 = (arg_223_1.time_ - var_226_10) / var_226_11

				if arg_223_1.var_.characterEffect1093ui_story and not isNil(var_226_9) then
					arg_223_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_10 + var_226_11 and arg_223_1.time_ < var_226_10 + var_226_11 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1093ui_story then
				arg_223_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_226_13 = 0

			if var_226_13 < arg_223_1.time_ and arg_223_1.time_ <= var_226_13 + arg_226_0 then
				arg_223_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_226_14 = 0

			if var_226_14 < arg_223_1.time_ and arg_223_1.time_ <= var_226_14 + arg_226_0 then
				arg_223_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_15 = 0
			local var_226_16 = 0.625

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[73].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:GetWordFromCfg(123112055)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 25
				local var_226_21 = utf8.len(var_226_19)
				local var_226_22 = var_226_20 <= 0 and var_226_16 or var_226_16 * (var_226_21 / var_226_20)

				if var_226_22 > 0 and var_226_16 < var_226_22 then
					arg_223_1.talkMaxDuration = var_226_22

					if var_226_22 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_22 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_19
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112055", "story_v_out_123112.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_123112", "123112055", "story_v_out_123112.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_123112", "123112055", "story_v_out_123112.awb")

						arg_223_1:RecordAudio("123112055", var_226_24)
						arg_223_1:RecordAudio("123112055", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_123112", "123112055", "story_v_out_123112.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_123112", "123112055", "story_v_out_123112.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_25 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_15) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_15 + var_226_25 and arg_223_1.time_ < var_226_15 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play123112056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 123112056
		arg_227_1.duration_ = 2

		local var_227_0 = {
			zh = 1.999999999999,
			ja = 2
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play123112057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1055ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1055ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(-0.7, -0.965, -6.2)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1055ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(-0.7, -0.965, -6.2)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = arg_227_1.actors_["1055ui_story"]
			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1055ui_story == nil then
				arg_227_1.var_.characterEffect1055ui_story = var_230_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_11 = 0.200000002980232

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_11 and not isNil(var_230_9) then
				local var_230_12 = (arg_227_1.time_ - var_230_10) / var_230_11

				if arg_227_1.var_.characterEffect1055ui_story and not isNil(var_230_9) then
					arg_227_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_10 + var_230_11 and arg_227_1.time_ < var_230_10 + var_230_11 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1055ui_story then
				arg_227_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_230_13 = 0

			if var_230_13 < arg_227_1.time_ and arg_227_1.time_ <= var_230_13 + arg_230_0 then
				arg_227_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_230_14 = 0

			if var_230_14 < arg_227_1.time_ and arg_227_1.time_ <= var_230_14 + arg_230_0 then
				arg_227_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_230_15 = arg_227_1.actors_["1093ui_story"]
			local var_230_16 = 0

			if var_230_16 < arg_227_1.time_ and arg_227_1.time_ <= var_230_16 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.characterEffect1093ui_story == nil then
				arg_227_1.var_.characterEffect1093ui_story = var_230_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_17 = 0.200000002980232

			if var_230_16 <= arg_227_1.time_ and arg_227_1.time_ < var_230_16 + var_230_17 and not isNil(var_230_15) then
				local var_230_18 = (arg_227_1.time_ - var_230_16) / var_230_17

				if arg_227_1.var_.characterEffect1093ui_story and not isNil(var_230_15) then
					local var_230_19 = Mathf.Lerp(0, 0.5, var_230_18)

					arg_227_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1093ui_story.fillRatio = var_230_19
				end
			end

			if arg_227_1.time_ >= var_230_16 + var_230_17 and arg_227_1.time_ < var_230_16 + var_230_17 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.characterEffect1093ui_story then
				local var_230_20 = 0.5

				arg_227_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1093ui_story.fillRatio = var_230_20
			end

			local var_230_21 = 0
			local var_230_22 = 0.125

			if var_230_21 < arg_227_1.time_ and arg_227_1.time_ <= var_230_21 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_23 = arg_227_1:FormatText(StoryNameCfg[481].name)

				arg_227_1.leftNameTxt_.text = var_230_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_24 = arg_227_1:GetWordFromCfg(123112056)
				local var_230_25 = arg_227_1:FormatText(var_230_24.content)

				arg_227_1.text_.text = var_230_25

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_26 = 5
				local var_230_27 = utf8.len(var_230_25)
				local var_230_28 = var_230_26 <= 0 and var_230_22 or var_230_22 * (var_230_27 / var_230_26)

				if var_230_28 > 0 and var_230_22 < var_230_28 then
					arg_227_1.talkMaxDuration = var_230_28

					if var_230_28 + var_230_21 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_28 + var_230_21
					end
				end

				arg_227_1.text_.text = var_230_25
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112056", "story_v_out_123112.awb") ~= 0 then
					local var_230_29 = manager.audio:GetVoiceLength("story_v_out_123112", "123112056", "story_v_out_123112.awb") / 1000

					if var_230_29 + var_230_21 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_29 + var_230_21
					end

					if var_230_24.prefab_name ~= "" and arg_227_1.actors_[var_230_24.prefab_name] ~= nil then
						local var_230_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_24.prefab_name].transform, "story_v_out_123112", "123112056", "story_v_out_123112.awb")

						arg_227_1:RecordAudio("123112056", var_230_30)
						arg_227_1:RecordAudio("123112056", var_230_30)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_123112", "123112056", "story_v_out_123112.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_123112", "123112056", "story_v_out_123112.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_31 = math.max(var_230_22, arg_227_1.talkMaxDuration)

			if var_230_21 <= arg_227_1.time_ and arg_227_1.time_ < var_230_21 + var_230_31 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_21) / var_230_31

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_21 + var_230_31 and arg_227_1.time_ < var_230_21 + var_230_31 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play123112057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 123112057
		arg_231_1.duration_ = 9

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play123112058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = "K05g"

			if arg_231_1.bgs_[var_234_0] == nil then
				local var_234_1 = Object.Instantiate(arg_231_1.paintGo_)

				var_234_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_234_0)
				var_234_1.name = var_234_0
				var_234_1.transform.parent = arg_231_1.stage_.transform
				var_234_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.bgs_[var_234_0] = var_234_1
			end

			local var_234_2 = 1.999999999999

			if var_234_2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				local var_234_3 = manager.ui.mainCamera.transform.localPosition
				local var_234_4 = Vector3.New(0, 0, 10) + Vector3.New(var_234_3.x, var_234_3.y, 0)
				local var_234_5 = arg_231_1.bgs_.K05g

				var_234_5.transform.localPosition = var_234_4
				var_234_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_6 = var_234_5:GetComponent("SpriteRenderer")

				if var_234_6 and var_234_6.sprite then
					local var_234_7 = (var_234_5.transform.localPosition - var_234_3).z
					local var_234_8 = manager.ui.mainCameraCom_
					local var_234_9 = 2 * var_234_7 * Mathf.Tan(var_234_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_234_10 = var_234_9 * var_234_8.aspect
					local var_234_11 = var_234_6.sprite.bounds.size.x
					local var_234_12 = var_234_6.sprite.bounds.size.y
					local var_234_13 = var_234_10 / var_234_11
					local var_234_14 = var_234_9 / var_234_12
					local var_234_15 = var_234_14 < var_234_13 and var_234_13 or var_234_14

					var_234_5.transform.localScale = Vector3.New(var_234_15, var_234_15, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "K05g" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_16 = 0

			if var_234_16 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_17 = 2

			if var_234_16 <= arg_231_1.time_ and arg_231_1.time_ < var_234_16 + var_234_17 then
				local var_234_18 = (arg_231_1.time_ - var_234_16) / var_234_17
				local var_234_19 = Color.New(0, 0, 0)

				var_234_19.a = Mathf.Lerp(0, 1, var_234_18)
				arg_231_1.mask_.color = var_234_19
			end

			if arg_231_1.time_ >= var_234_16 + var_234_17 and arg_231_1.time_ < var_234_16 + var_234_17 + arg_234_0 then
				local var_234_20 = Color.New(0, 0, 0)

				var_234_20.a = 1
				arg_231_1.mask_.color = var_234_20
			end

			local var_234_21 = 2

			if var_234_21 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_22 = 2

			if var_234_21 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_22 then
				local var_234_23 = (arg_231_1.time_ - var_234_21) / var_234_22
				local var_234_24 = Color.New(0, 0, 0)

				var_234_24.a = Mathf.Lerp(1, 0, var_234_23)
				arg_231_1.mask_.color = var_234_24
			end

			if arg_231_1.time_ >= var_234_21 + var_234_22 and arg_231_1.time_ < var_234_21 + var_234_22 + arg_234_0 then
				local var_234_25 = Color.New(0, 0, 0)
				local var_234_26 = 0

				arg_231_1.mask_.enabled = false
				var_234_25.a = var_234_26
				arg_231_1.mask_.color = var_234_25
			end

			local var_234_27 = arg_231_1.actors_["1093ui_story"].transform
			local var_234_28 = 1.96599999815226

			if var_234_28 < arg_231_1.time_ and arg_231_1.time_ <= var_234_28 + arg_234_0 then
				arg_231_1.var_.moveOldPos1093ui_story = var_234_27.localPosition
			end

			local var_234_29 = 0.001

			if var_234_28 <= arg_231_1.time_ and arg_231_1.time_ < var_234_28 + var_234_29 then
				local var_234_30 = (arg_231_1.time_ - var_234_28) / var_234_29
				local var_234_31 = Vector3.New(0, 100, 0)

				var_234_27.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1093ui_story, var_234_31, var_234_30)

				local var_234_32 = manager.ui.mainCamera.transform.position - var_234_27.position

				var_234_27.forward = Vector3.New(var_234_32.x, var_234_32.y, var_234_32.z)

				local var_234_33 = var_234_27.localEulerAngles

				var_234_33.z = 0
				var_234_33.x = 0
				var_234_27.localEulerAngles = var_234_33
			end

			if arg_231_1.time_ >= var_234_28 + var_234_29 and arg_231_1.time_ < var_234_28 + var_234_29 + arg_234_0 then
				var_234_27.localPosition = Vector3.New(0, 100, 0)

				local var_234_34 = manager.ui.mainCamera.transform.position - var_234_27.position

				var_234_27.forward = Vector3.New(var_234_34.x, var_234_34.y, var_234_34.z)

				local var_234_35 = var_234_27.localEulerAngles

				var_234_35.z = 0
				var_234_35.x = 0
				var_234_27.localEulerAngles = var_234_35
			end

			local var_234_36 = arg_231_1.actors_["1093ui_story"]
			local var_234_37 = 1.96599999815226

			if var_234_37 < arg_231_1.time_ and arg_231_1.time_ <= var_234_37 + arg_234_0 and not isNil(var_234_36) and arg_231_1.var_.characterEffect1093ui_story == nil then
				arg_231_1.var_.characterEffect1093ui_story = var_234_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_38 = 0.034000001847744

			if var_234_37 <= arg_231_1.time_ and arg_231_1.time_ < var_234_37 + var_234_38 and not isNil(var_234_36) then
				local var_234_39 = (arg_231_1.time_ - var_234_37) / var_234_38

				if arg_231_1.var_.characterEffect1093ui_story and not isNil(var_234_36) then
					local var_234_40 = Mathf.Lerp(0, 0.5, var_234_39)

					arg_231_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1093ui_story.fillRatio = var_234_40
				end
			end

			if arg_231_1.time_ >= var_234_37 + var_234_38 and arg_231_1.time_ < var_234_37 + var_234_38 + arg_234_0 and not isNil(var_234_36) and arg_231_1.var_.characterEffect1093ui_story then
				local var_234_41 = 0.5

				arg_231_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1093ui_story.fillRatio = var_234_41
			end

			local var_234_42 = arg_231_1.actors_["1055ui_story"].transform
			local var_234_43 = 1.96599999815226

			if var_234_43 < arg_231_1.time_ and arg_231_1.time_ <= var_234_43 + arg_234_0 then
				arg_231_1.var_.moveOldPos1055ui_story = var_234_42.localPosition
			end

			local var_234_44 = 0.001

			if var_234_43 <= arg_231_1.time_ and arg_231_1.time_ < var_234_43 + var_234_44 then
				local var_234_45 = (arg_231_1.time_ - var_234_43) / var_234_44
				local var_234_46 = Vector3.New(0, 100, 0)

				var_234_42.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1055ui_story, var_234_46, var_234_45)

				local var_234_47 = manager.ui.mainCamera.transform.position - var_234_42.position

				var_234_42.forward = Vector3.New(var_234_47.x, var_234_47.y, var_234_47.z)

				local var_234_48 = var_234_42.localEulerAngles

				var_234_48.z = 0
				var_234_48.x = 0
				var_234_42.localEulerAngles = var_234_48
			end

			if arg_231_1.time_ >= var_234_43 + var_234_44 and arg_231_1.time_ < var_234_43 + var_234_44 + arg_234_0 then
				var_234_42.localPosition = Vector3.New(0, 100, 0)

				local var_234_49 = manager.ui.mainCamera.transform.position - var_234_42.position

				var_234_42.forward = Vector3.New(var_234_49.x, var_234_49.y, var_234_49.z)

				local var_234_50 = var_234_42.localEulerAngles

				var_234_50.z = 0
				var_234_50.x = 0
				var_234_42.localEulerAngles = var_234_50
			end

			local var_234_51 = arg_231_1.actors_["1055ui_story"]
			local var_234_52 = 1.96599999815226

			if var_234_52 < arg_231_1.time_ and arg_231_1.time_ <= var_234_52 + arg_234_0 and not isNil(var_234_51) and arg_231_1.var_.characterEffect1055ui_story == nil then
				arg_231_1.var_.characterEffect1055ui_story = var_234_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_53 = 0.034000001847744

			if var_234_52 <= arg_231_1.time_ and arg_231_1.time_ < var_234_52 + var_234_53 and not isNil(var_234_51) then
				local var_234_54 = (arg_231_1.time_ - var_234_52) / var_234_53

				if arg_231_1.var_.characterEffect1055ui_story and not isNil(var_234_51) then
					local var_234_55 = Mathf.Lerp(0, 0.5, var_234_54)

					arg_231_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1055ui_story.fillRatio = var_234_55
				end
			end

			if arg_231_1.time_ >= var_234_52 + var_234_53 and arg_231_1.time_ < var_234_52 + var_234_53 + arg_234_0 and not isNil(var_234_51) and arg_231_1.var_.characterEffect1055ui_story then
				local var_234_56 = 0.5

				arg_231_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1055ui_story.fillRatio = var_234_56
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_57 = 4
			local var_234_58 = 1.125

			if var_234_57 < arg_231_1.time_ and arg_231_1.time_ <= var_234_57 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_59 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_59:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_60 = arg_231_1:GetWordFromCfg(123112057)
				local var_234_61 = arg_231_1:FormatText(var_234_60.content)

				arg_231_1.text_.text = var_234_61

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_62 = 45
				local var_234_63 = utf8.len(var_234_61)
				local var_234_64 = var_234_62 <= 0 and var_234_58 or var_234_58 * (var_234_63 / var_234_62)

				if var_234_64 > 0 and var_234_58 < var_234_64 then
					arg_231_1.talkMaxDuration = var_234_64
					var_234_57 = var_234_57 + 0.3

					if var_234_64 + var_234_57 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_64 + var_234_57
					end
				end

				arg_231_1.text_.text = var_234_61
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_65 = var_234_57 + 0.3
			local var_234_66 = math.max(var_234_58, arg_231_1.talkMaxDuration)

			if var_234_65 <= arg_231_1.time_ and arg_231_1.time_ < var_234_65 + var_234_66 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_65) / var_234_66

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_65 + var_234_66 and arg_231_1.time_ < var_234_65 + var_234_66 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play123112058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 123112058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play123112059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 1.425

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_2 = arg_237_1:GetWordFromCfg(123112058)
				local var_240_3 = arg_237_1:FormatText(var_240_2.content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 57
				local var_240_5 = utf8.len(var_240_3)
				local var_240_6 = var_240_4 <= 0 and var_240_1 or var_240_1 * (var_240_5 / var_240_4)

				if var_240_6 > 0 and var_240_1 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_7 and arg_237_1.time_ < var_240_0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play123112059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 123112059
		arg_241_1.duration_ = 5.13

		local var_241_0 = {
			zh = 5.133,
			ja = 4.533
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play123112060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1055ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1055ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, -0.965, -6.2)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1055ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["1055ui_story"]
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1055ui_story == nil then
				arg_241_1.var_.characterEffect1055ui_story = var_244_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_11 = 0.200000002980232

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 and not isNil(var_244_9) then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11

				if arg_241_1.var_.characterEffect1055ui_story and not isNil(var_244_9) then
					arg_241_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1055ui_story then
				arg_241_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_244_13 = 0

			if var_244_13 < arg_241_1.time_ and arg_241_1.time_ <= var_244_13 + arg_244_0 then
				arg_241_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			local var_244_14 = 0

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_244_15 = 0
			local var_244_16 = 0.725

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_17 = arg_241_1:FormatText(StoryNameCfg[481].name)

				arg_241_1.leftNameTxt_.text = var_244_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_18 = arg_241_1:GetWordFromCfg(123112059)
				local var_244_19 = arg_241_1:FormatText(var_244_18.content)

				arg_241_1.text_.text = var_244_19

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_20 = 29
				local var_244_21 = utf8.len(var_244_19)
				local var_244_22 = var_244_20 <= 0 and var_244_16 or var_244_16 * (var_244_21 / var_244_20)

				if var_244_22 > 0 and var_244_16 < var_244_22 then
					arg_241_1.talkMaxDuration = var_244_22

					if var_244_22 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_22 + var_244_15
					end
				end

				arg_241_1.text_.text = var_244_19
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112059", "story_v_out_123112.awb") ~= 0 then
					local var_244_23 = manager.audio:GetVoiceLength("story_v_out_123112", "123112059", "story_v_out_123112.awb") / 1000

					if var_244_23 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_15
					end

					if var_244_18.prefab_name ~= "" and arg_241_1.actors_[var_244_18.prefab_name] ~= nil then
						local var_244_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_18.prefab_name].transform, "story_v_out_123112", "123112059", "story_v_out_123112.awb")

						arg_241_1:RecordAudio("123112059", var_244_24)
						arg_241_1:RecordAudio("123112059", var_244_24)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_123112", "123112059", "story_v_out_123112.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_123112", "123112059", "story_v_out_123112.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_25 = math.max(var_244_16, arg_241_1.talkMaxDuration)

			if var_244_15 <= arg_241_1.time_ and arg_241_1.time_ < var_244_15 + var_244_25 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_15) / var_244_25

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_15 + var_244_25 and arg_241_1.time_ < var_244_15 + var_244_25 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play123112060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 123112060
		arg_245_1.duration_ = 3.53

		local var_245_0 = {
			zh = 3.533,
			ja = 3.166
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play123112061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1055ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1055ui_story == nil then
				arg_245_1.var_.characterEffect1055ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1055ui_story and not isNil(var_248_0) then
					local var_248_4 = Mathf.Lerp(0, 0.5, var_248_3)

					arg_245_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1055ui_story.fillRatio = var_248_4
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1055ui_story then
				local var_248_5 = 0.5

				arg_245_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1055ui_story.fillRatio = var_248_5
			end

			local var_248_6 = 0
			local var_248_7 = 0.175

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_8 = arg_245_1:FormatText(StoryNameCfg[499].name)

				arg_245_1.leftNameTxt_.text = var_248_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_9 = arg_245_1:GetWordFromCfg(123112060)
				local var_248_10 = arg_245_1:FormatText(var_248_9.content)

				arg_245_1.text_.text = var_248_10

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 7
				local var_248_12 = utf8.len(var_248_10)
				local var_248_13 = var_248_11 <= 0 and var_248_7 or var_248_7 * (var_248_12 / var_248_11)

				if var_248_13 > 0 and var_248_7 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_10
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112060", "story_v_out_123112.awb") ~= 0 then
					local var_248_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112060", "story_v_out_123112.awb") / 1000

					if var_248_14 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_14 + var_248_6
					end

					if var_248_9.prefab_name ~= "" and arg_245_1.actors_[var_248_9.prefab_name] ~= nil then
						local var_248_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_9.prefab_name].transform, "story_v_out_123112", "123112060", "story_v_out_123112.awb")

						arg_245_1:RecordAudio("123112060", var_248_15)
						arg_245_1:RecordAudio("123112060", var_248_15)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_123112", "123112060", "story_v_out_123112.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_123112", "123112060", "story_v_out_123112.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_16 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_16 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_16

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_16 and arg_245_1.time_ < var_248_6 + var_248_16 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play123112061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 123112061
		arg_249_1.duration_ = 2

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play123112062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1055ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1055ui_story = var_252_0.localPosition
			end

			local var_252_2 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2
				local var_252_4 = Vector3.New(0, -0.965, -6.2)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1055ui_story, var_252_4, var_252_3)

				local var_252_5 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_5.x, var_252_5.y, var_252_5.z)

				local var_252_6 = var_252_0.localEulerAngles

				var_252_6.z = 0
				var_252_6.x = 0
				var_252_0.localEulerAngles = var_252_6
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_252_7 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_7.x, var_252_7.y, var_252_7.z)

				local var_252_8 = var_252_0.localEulerAngles

				var_252_8.z = 0
				var_252_8.x = 0
				var_252_0.localEulerAngles = var_252_8
			end

			local var_252_9 = arg_249_1.actors_["1055ui_story"]
			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect1055ui_story == nil then
				arg_249_1.var_.characterEffect1055ui_story = var_252_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_11 = 0.200000002980232

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_11 and not isNil(var_252_9) then
				local var_252_12 = (arg_249_1.time_ - var_252_10) / var_252_11

				if arg_249_1.var_.characterEffect1055ui_story and not isNil(var_252_9) then
					arg_249_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_10 + var_252_11 and arg_249_1.time_ < var_252_10 + var_252_11 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect1055ui_story then
				arg_249_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_252_13 = 0

			if var_252_13 < arg_249_1.time_ and arg_249_1.time_ <= var_252_13 + arg_252_0 then
				arg_249_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_2")
			end

			local var_252_14 = 0

			if var_252_14 < arg_249_1.time_ and arg_249_1.time_ <= var_252_14 + arg_252_0 then
				arg_249_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_252_15 = 0
			local var_252_16 = 0.075

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_17 = arg_249_1:FormatText(StoryNameCfg[481].name)

				arg_249_1.leftNameTxt_.text = var_252_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_18 = arg_249_1:GetWordFromCfg(123112061)
				local var_252_19 = arg_249_1:FormatText(var_252_18.content)

				arg_249_1.text_.text = var_252_19

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_20 = 3
				local var_252_21 = utf8.len(var_252_19)
				local var_252_22 = var_252_20 <= 0 and var_252_16 or var_252_16 * (var_252_21 / var_252_20)

				if var_252_22 > 0 and var_252_16 < var_252_22 then
					arg_249_1.talkMaxDuration = var_252_22

					if var_252_22 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_22 + var_252_15
					end
				end

				arg_249_1.text_.text = var_252_19
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112061", "story_v_out_123112.awb") ~= 0 then
					local var_252_23 = manager.audio:GetVoiceLength("story_v_out_123112", "123112061", "story_v_out_123112.awb") / 1000

					if var_252_23 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_23 + var_252_15
					end

					if var_252_18.prefab_name ~= "" and arg_249_1.actors_[var_252_18.prefab_name] ~= nil then
						local var_252_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_18.prefab_name].transform, "story_v_out_123112", "123112061", "story_v_out_123112.awb")

						arg_249_1:RecordAudio("123112061", var_252_24)
						arg_249_1:RecordAudio("123112061", var_252_24)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_123112", "123112061", "story_v_out_123112.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_123112", "123112061", "story_v_out_123112.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_25 = math.max(var_252_16, arg_249_1.talkMaxDuration)

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_25 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_15) / var_252_25

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_15 + var_252_25 and arg_249_1.time_ < var_252_15 + var_252_25 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play123112062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 123112062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play123112063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1055ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1055ui_story == nil then
				arg_253_1.var_.characterEffect1055ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1055ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1055ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1055ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1055ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.575

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_8 = arg_253_1:GetWordFromCfg(123112062)
				local var_256_9 = arg_253_1:FormatText(var_256_8.content)

				arg_253_1.text_.text = var_256_9

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_10 = 23
				local var_256_11 = utf8.len(var_256_9)
				local var_256_12 = var_256_10 <= 0 and var_256_7 or var_256_7 * (var_256_11 / var_256_10)

				if var_256_12 > 0 and var_256_7 < var_256_12 then
					arg_253_1.talkMaxDuration = var_256_12

					if var_256_12 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_9
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_13 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_13 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_13

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_13 and arg_253_1.time_ < var_256_6 + var_256_13 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play123112063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 123112063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play123112064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.5

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(123112063)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 20
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_8 and arg_257_1.time_ < var_260_0 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play123112064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 123112064
		arg_261_1.duration_ = 6.23

		local var_261_0 = {
			zh = 6.233,
			ja = 4.966
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play123112065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1055ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1055ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0, -0.965, -6.2)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1055ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, -0.965, -6.2)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = arg_261_1.actors_["1055ui_story"]
			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1055ui_story == nil then
				arg_261_1.var_.characterEffect1055ui_story = var_264_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_11 = 0.200000002980232

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_11 and not isNil(var_264_9) then
				local var_264_12 = (arg_261_1.time_ - var_264_10) / var_264_11

				if arg_261_1.var_.characterEffect1055ui_story and not isNil(var_264_9) then
					arg_261_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_10 + var_264_11 and arg_261_1.time_ < var_264_10 + var_264_11 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1055ui_story then
				arg_261_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_264_13 = 0

			if var_264_13 < arg_261_1.time_ and arg_261_1.time_ <= var_264_13 + arg_264_0 then
				arg_261_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_264_14 = 0

			if var_264_14 < arg_261_1.time_ and arg_261_1.time_ <= var_264_14 + arg_264_0 then
				arg_261_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_264_15 = 0
			local var_264_16 = 0.875

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_17 = arg_261_1:FormatText(StoryNameCfg[481].name)

				arg_261_1.leftNameTxt_.text = var_264_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_18 = arg_261_1:GetWordFromCfg(123112064)
				local var_264_19 = arg_261_1:FormatText(var_264_18.content)

				arg_261_1.text_.text = var_264_19

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_20 = 35
				local var_264_21 = utf8.len(var_264_19)
				local var_264_22 = var_264_20 <= 0 and var_264_16 or var_264_16 * (var_264_21 / var_264_20)

				if var_264_22 > 0 and var_264_16 < var_264_22 then
					arg_261_1.talkMaxDuration = var_264_22

					if var_264_22 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_22 + var_264_15
					end
				end

				arg_261_1.text_.text = var_264_19
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112064", "story_v_out_123112.awb") ~= 0 then
					local var_264_23 = manager.audio:GetVoiceLength("story_v_out_123112", "123112064", "story_v_out_123112.awb") / 1000

					if var_264_23 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_15
					end

					if var_264_18.prefab_name ~= "" and arg_261_1.actors_[var_264_18.prefab_name] ~= nil then
						local var_264_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_18.prefab_name].transform, "story_v_out_123112", "123112064", "story_v_out_123112.awb")

						arg_261_1:RecordAudio("123112064", var_264_24)
						arg_261_1:RecordAudio("123112064", var_264_24)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_123112", "123112064", "story_v_out_123112.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_123112", "123112064", "story_v_out_123112.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_25 = math.max(var_264_16, arg_261_1.talkMaxDuration)

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_25 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_15) / var_264_25

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_15 + var_264_25 and arg_261_1.time_ < var_264_15 + var_264_25 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play123112065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 123112065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play123112066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1055ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1055ui_story == nil then
				arg_265_1.var_.characterEffect1055ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1055ui_story and not isNil(var_268_0) then
					local var_268_4 = Mathf.Lerp(0, 0.5, var_268_3)

					arg_265_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1055ui_story.fillRatio = var_268_4
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1055ui_story then
				local var_268_5 = 0.5

				arg_265_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1055ui_story.fillRatio = var_268_5
			end

			local var_268_6 = 0
			local var_268_7 = 0.05

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_8 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_9 = arg_265_1:GetWordFromCfg(123112065)
				local var_268_10 = arg_265_1:FormatText(var_268_9.content)

				arg_265_1.text_.text = var_268_10

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 2
				local var_268_12 = utf8.len(var_268_10)
				local var_268_13 = var_268_11 <= 0 and var_268_7 or var_268_7 * (var_268_12 / var_268_11)

				if var_268_13 > 0 and var_268_7 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_6
					end
				end

				arg_265_1.text_.text = var_268_10
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_14 = math.max(var_268_7, arg_265_1.talkMaxDuration)

			if var_268_6 <= arg_265_1.time_ and arg_265_1.time_ < var_268_6 + var_268_14 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_6) / var_268_14

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_6 + var_268_14 and arg_265_1.time_ < var_268_6 + var_268_14 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play123112066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 123112066
		arg_269_1.duration_ = 14.4

		local var_269_0 = {
			zh = 12.866,
			ja = 14.4
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play123112067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1055ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1055ui_story == nil then
				arg_269_1.var_.characterEffect1055ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1055ui_story and not isNil(var_272_0) then
					arg_269_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1055ui_story then
				arg_269_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_272_4 = 0

			if var_272_4 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action6_1")
			end

			local var_272_5 = 0

			if var_272_5 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_272_6 = 0
			local var_272_7 = 1.4

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_8 = arg_269_1:FormatText(StoryNameCfg[481].name)

				arg_269_1.leftNameTxt_.text = var_272_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_9 = arg_269_1:GetWordFromCfg(123112066)
				local var_272_10 = arg_269_1:FormatText(var_272_9.content)

				arg_269_1.text_.text = var_272_10

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_11 = 56
				local var_272_12 = utf8.len(var_272_10)
				local var_272_13 = var_272_11 <= 0 and var_272_7 or var_272_7 * (var_272_12 / var_272_11)

				if var_272_13 > 0 and var_272_7 < var_272_13 then
					arg_269_1.talkMaxDuration = var_272_13

					if var_272_13 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_13 + var_272_6
					end
				end

				arg_269_1.text_.text = var_272_10
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112066", "story_v_out_123112.awb") ~= 0 then
					local var_272_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112066", "story_v_out_123112.awb") / 1000

					if var_272_14 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_14 + var_272_6
					end

					if var_272_9.prefab_name ~= "" and arg_269_1.actors_[var_272_9.prefab_name] ~= nil then
						local var_272_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_9.prefab_name].transform, "story_v_out_123112", "123112066", "story_v_out_123112.awb")

						arg_269_1:RecordAudio("123112066", var_272_15)
						arg_269_1:RecordAudio("123112066", var_272_15)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_123112", "123112066", "story_v_out_123112.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_123112", "123112066", "story_v_out_123112.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_16 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_16 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_16

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_16 and arg_269_1.time_ < var_272_6 + var_272_16 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play123112067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 123112067
		arg_273_1.duration_ = 10.97

		local var_273_0 = {
			zh = 6.233,
			ja = 10.966
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play123112068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_276_1 = 0
			local var_276_2 = 0.875

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_3 = arg_273_1:FormatText(StoryNameCfg[481].name)

				arg_273_1.leftNameTxt_.text = var_276_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_4 = arg_273_1:GetWordFromCfg(123112067)
				local var_276_5 = arg_273_1:FormatText(var_276_4.content)

				arg_273_1.text_.text = var_276_5

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_6 = 35
				local var_276_7 = utf8.len(var_276_5)
				local var_276_8 = var_276_6 <= 0 and var_276_2 or var_276_2 * (var_276_7 / var_276_6)

				if var_276_8 > 0 and var_276_2 < var_276_8 then
					arg_273_1.talkMaxDuration = var_276_8

					if var_276_8 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_5
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112067", "story_v_out_123112.awb") ~= 0 then
					local var_276_9 = manager.audio:GetVoiceLength("story_v_out_123112", "123112067", "story_v_out_123112.awb") / 1000

					if var_276_9 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_1
					end

					if var_276_4.prefab_name ~= "" and arg_273_1.actors_[var_276_4.prefab_name] ~= nil then
						local var_276_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_4.prefab_name].transform, "story_v_out_123112", "123112067", "story_v_out_123112.awb")

						arg_273_1:RecordAudio("123112067", var_276_10)
						arg_273_1:RecordAudio("123112067", var_276_10)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_123112", "123112067", "story_v_out_123112.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_123112", "123112067", "story_v_out_123112.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_11 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_11 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_11

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_11 and arg_273_1.time_ < var_276_1 + var_276_11 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play123112068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 123112068
		arg_277_1.duration_ = 8.43

		local var_277_0 = {
			zh = 6.8,
			ja = 8.433
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play123112069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action6_2")
			end

			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_2 = 0
			local var_280_3 = 0.825

			if var_280_2 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_4 = arg_277_1:FormatText(StoryNameCfg[481].name)

				arg_277_1.leftNameTxt_.text = var_280_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_5 = arg_277_1:GetWordFromCfg(123112068)
				local var_280_6 = arg_277_1:FormatText(var_280_5.content)

				arg_277_1.text_.text = var_280_6

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_7 = 33
				local var_280_8 = utf8.len(var_280_6)
				local var_280_9 = var_280_7 <= 0 and var_280_3 or var_280_3 * (var_280_8 / var_280_7)

				if var_280_9 > 0 and var_280_3 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_2
					end
				end

				arg_277_1.text_.text = var_280_6
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112068", "story_v_out_123112.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112068", "story_v_out_123112.awb") / 1000

					if var_280_10 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_2
					end

					if var_280_5.prefab_name ~= "" and arg_277_1.actors_[var_280_5.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_5.prefab_name].transform, "story_v_out_123112", "123112068", "story_v_out_123112.awb")

						arg_277_1:RecordAudio("123112068", var_280_11)
						arg_277_1:RecordAudio("123112068", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_123112", "123112068", "story_v_out_123112.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_123112", "123112068", "story_v_out_123112.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_3, arg_277_1.talkMaxDuration)

			if var_280_2 <= arg_277_1.time_ and arg_277_1.time_ < var_280_2 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_2) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_2 + var_280_12 and arg_277_1.time_ < var_280_2 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play123112069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 123112069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play123112070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1055ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1055ui_story == nil then
				arg_281_1.var_.characterEffect1055ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1055ui_story and not isNil(var_284_0) then
					local var_284_4 = Mathf.Lerp(0, 0.5, var_284_3)

					arg_281_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1055ui_story.fillRatio = var_284_4
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1055ui_story then
				local var_284_5 = 0.5

				arg_281_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1055ui_story.fillRatio = var_284_5
			end

			local var_284_6 = 0
			local var_284_7 = 0.625

			if var_284_6 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_8 = arg_281_1:GetWordFromCfg(123112069)
				local var_284_9 = arg_281_1:FormatText(var_284_8.content)

				arg_281_1.text_.text = var_284_9

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 25
				local var_284_11 = utf8.len(var_284_9)
				local var_284_12 = var_284_10 <= 0 and var_284_7 or var_284_7 * (var_284_11 / var_284_10)

				if var_284_12 > 0 and var_284_7 < var_284_12 then
					arg_281_1.talkMaxDuration = var_284_12

					if var_284_12 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_12 + var_284_6
					end
				end

				arg_281_1.text_.text = var_284_9
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_13 = math.max(var_284_7, arg_281_1.talkMaxDuration)

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_13 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_6) / var_284_13

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_6 + var_284_13 and arg_281_1.time_ < var_284_6 + var_284_13 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play123112070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 123112070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play123112071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.575

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(123112070)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 23
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_8 and arg_285_1.time_ < var_288_0 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play123112071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 123112071
		arg_289_1.duration_ = 8.1

		local var_289_0 = {
			zh = 6.2,
			ja = 8.1
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play123112072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1055ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1055ui_story == nil then
				arg_289_1.var_.characterEffect1055ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1055ui_story and not isNil(var_292_0) then
					arg_289_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1055ui_story then
				arg_289_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_292_4 = 0

			if var_292_4 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_292_5 = 0

			if var_292_5 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_292_6 = 0
			local var_292_7 = 0.775

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_8 = arg_289_1:FormatText(StoryNameCfg[481].name)

				arg_289_1.leftNameTxt_.text = var_292_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_9 = arg_289_1:GetWordFromCfg(123112071)
				local var_292_10 = arg_289_1:FormatText(var_292_9.content)

				arg_289_1.text_.text = var_292_10

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 31
				local var_292_12 = utf8.len(var_292_10)
				local var_292_13 = var_292_11 <= 0 and var_292_7 or var_292_7 * (var_292_12 / var_292_11)

				if var_292_13 > 0 and var_292_7 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_6
					end
				end

				arg_289_1.text_.text = var_292_10
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112071", "story_v_out_123112.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112071", "story_v_out_123112.awb") / 1000

					if var_292_14 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_6
					end

					if var_292_9.prefab_name ~= "" and arg_289_1.actors_[var_292_9.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_9.prefab_name].transform, "story_v_out_123112", "123112071", "story_v_out_123112.awb")

						arg_289_1:RecordAudio("123112071", var_292_15)
						arg_289_1:RecordAudio("123112071", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_123112", "123112071", "story_v_out_123112.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_123112", "123112071", "story_v_out_123112.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_16 = math.max(var_292_7, arg_289_1.talkMaxDuration)

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_16 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_6) / var_292_16

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_6 + var_292_16 and arg_289_1.time_ < var_292_6 + var_292_16 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play123112072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 123112072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play123112073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1055ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1055ui_story == nil then
				arg_293_1.var_.characterEffect1055ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1055ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1055ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1055ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1055ui_story.fillRatio = var_296_5
			end

			local var_296_6 = 0
			local var_296_7 = 0.825

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_8 = arg_293_1:FormatText(StoryNameCfg[7].name)

				arg_293_1.leftNameTxt_.text = var_296_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_9 = arg_293_1:GetWordFromCfg(123112072)
				local var_296_10 = arg_293_1:FormatText(var_296_9.content)

				arg_293_1.text_.text = var_296_10

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 33
				local var_296_12 = utf8.len(var_296_10)
				local var_296_13 = var_296_11 <= 0 and var_296_7 or var_296_7 * (var_296_12 / var_296_11)

				if var_296_13 > 0 and var_296_7 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_10
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_14 and arg_293_1.time_ < var_296_6 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play123112073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 123112073
		arg_297_1.duration_ = 7.9

		local var_297_0 = {
			zh = 7.9,
			ja = 6.5
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play123112074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_300_1 = arg_297_1.actors_["1055ui_story"]
			local var_300_2 = 0

			if var_300_2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1055ui_story == nil then
				arg_297_1.var_.characterEffect1055ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_3 = 0.2

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_3 and not isNil(var_300_1) then
				local var_300_4 = (arg_297_1.time_ - var_300_2) / var_300_3

				if arg_297_1.var_.characterEffect1055ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_2 + var_300_3 and arg_297_1.time_ < var_300_2 + var_300_3 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1055ui_story then
				arg_297_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_300_5 = 0
			local var_300_6 = 0.675

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_7 = arg_297_1:FormatText(StoryNameCfg[481].name)

				arg_297_1.leftNameTxt_.text = var_300_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_8 = arg_297_1:GetWordFromCfg(123112073)
				local var_300_9 = arg_297_1:FormatText(var_300_8.content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_10 = 26
				local var_300_11 = utf8.len(var_300_9)
				local var_300_12 = var_300_10 <= 0 and var_300_6 or var_300_6 * (var_300_11 / var_300_10)

				if var_300_12 > 0 and var_300_6 < var_300_12 then
					arg_297_1.talkMaxDuration = var_300_12

					if var_300_12 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_12 + var_300_5
					end
				end

				arg_297_1.text_.text = var_300_9
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112073", "story_v_out_123112.awb") ~= 0 then
					local var_300_13 = manager.audio:GetVoiceLength("story_v_out_123112", "123112073", "story_v_out_123112.awb") / 1000

					if var_300_13 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_5
					end

					if var_300_8.prefab_name ~= "" and arg_297_1.actors_[var_300_8.prefab_name] ~= nil then
						local var_300_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_8.prefab_name].transform, "story_v_out_123112", "123112073", "story_v_out_123112.awb")

						arg_297_1:RecordAudio("123112073", var_300_14)
						arg_297_1:RecordAudio("123112073", var_300_14)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_123112", "123112073", "story_v_out_123112.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_123112", "123112073", "story_v_out_123112.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_15 = math.max(var_300_6, arg_297_1.talkMaxDuration)

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_15 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_5) / var_300_15

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_5 + var_300_15 and arg_297_1.time_ < var_300_5 + var_300_15 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play123112074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 123112074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play123112075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1055ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1055ui_story == nil then
				arg_301_1.var_.characterEffect1055ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.2

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1055ui_story and not isNil(var_304_0) then
					local var_304_4 = Mathf.Lerp(0, 0.5, var_304_3)

					arg_301_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1055ui_story.fillRatio = var_304_4
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1055ui_story then
				local var_304_5 = 0.5

				arg_301_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1055ui_story.fillRatio = var_304_5
			end

			local var_304_6 = 0
			local var_304_7 = 0.925

			if var_304_6 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_8 = arg_301_1:FormatText(StoryNameCfg[7].name)

				arg_301_1.leftNameTxt_.text = var_304_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_9 = arg_301_1:GetWordFromCfg(123112074)
				local var_304_10 = arg_301_1:FormatText(var_304_9.content)

				arg_301_1.text_.text = var_304_10

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_11 = 37
				local var_304_12 = utf8.len(var_304_10)
				local var_304_13 = var_304_11 <= 0 and var_304_7 or var_304_7 * (var_304_12 / var_304_11)

				if var_304_13 > 0 and var_304_7 < var_304_13 then
					arg_301_1.talkMaxDuration = var_304_13

					if var_304_13 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_13 + var_304_6
					end
				end

				arg_301_1.text_.text = var_304_10
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_14 = math.max(var_304_7, arg_301_1.talkMaxDuration)

			if var_304_6 <= arg_301_1.time_ and arg_301_1.time_ < var_304_6 + var_304_14 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_6) / var_304_14

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_6 + var_304_14 and arg_301_1.time_ < var_304_6 + var_304_14 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play123112075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 123112075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play123112076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.5

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_2 = arg_305_1:GetWordFromCfg(123112075)
				local var_308_3 = arg_305_1:FormatText(var_308_2.content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 20
				local var_308_5 = utf8.len(var_308_3)
				local var_308_6 = var_308_4 <= 0 and var_308_1 or var_308_1 * (var_308_5 / var_308_4)

				if var_308_6 > 0 and var_308_1 < var_308_6 then
					arg_305_1.talkMaxDuration = var_308_6

					if var_308_6 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_7 and arg_305_1.time_ < var_308_0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play123112076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 123112076
		arg_309_1.duration_ = 9.43

		local var_309_0 = {
			zh = 9.433,
			ja = 4.366
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play123112077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1055ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1055ui_story == nil then
				arg_309_1.var_.characterEffect1055ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1055ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1055ui_story then
				arg_309_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_312_4 = 0

			if var_312_4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action4_1")
			end

			local var_312_5 = 0

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_312_6 = 0
			local var_312_7 = 0.75

			if var_312_6 < arg_309_1.time_ and arg_309_1.time_ <= var_312_6 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_8 = arg_309_1:FormatText(StoryNameCfg[481].name)

				arg_309_1.leftNameTxt_.text = var_312_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_9 = arg_309_1:GetWordFromCfg(123112076)
				local var_312_10 = arg_309_1:FormatText(var_312_9.content)

				arg_309_1.text_.text = var_312_10

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_11 = 30
				local var_312_12 = utf8.len(var_312_10)
				local var_312_13 = var_312_11 <= 0 and var_312_7 or var_312_7 * (var_312_12 / var_312_11)

				if var_312_13 > 0 and var_312_7 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_6
					end
				end

				arg_309_1.text_.text = var_312_10
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112076", "story_v_out_123112.awb") ~= 0 then
					local var_312_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112076", "story_v_out_123112.awb") / 1000

					if var_312_14 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_14 + var_312_6
					end

					if var_312_9.prefab_name ~= "" and arg_309_1.actors_[var_312_9.prefab_name] ~= nil then
						local var_312_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_9.prefab_name].transform, "story_v_out_123112", "123112076", "story_v_out_123112.awb")

						arg_309_1:RecordAudio("123112076", var_312_15)
						arg_309_1:RecordAudio("123112076", var_312_15)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_123112", "123112076", "story_v_out_123112.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_123112", "123112076", "story_v_out_123112.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_16 = math.max(var_312_7, arg_309_1.talkMaxDuration)

			if var_312_6 <= arg_309_1.time_ and arg_309_1.time_ < var_312_6 + var_312_16 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_6) / var_312_16

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_6 + var_312_16 and arg_309_1.time_ < var_312_6 + var_312_16 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play123112077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 123112077
		arg_313_1.duration_ = 18.07

		local var_313_0 = {
			zh = 12.733,
			ja = 18.066
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play123112078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_316_1 = 0
			local var_316_2 = 1.475

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_3 = arg_313_1:FormatText(StoryNameCfg[481].name)

				arg_313_1.leftNameTxt_.text = var_316_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_4 = arg_313_1:GetWordFromCfg(123112077)
				local var_316_5 = arg_313_1:FormatText(var_316_4.content)

				arg_313_1.text_.text = var_316_5

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_6 = 59
				local var_316_7 = utf8.len(var_316_5)
				local var_316_8 = var_316_6 <= 0 and var_316_2 or var_316_2 * (var_316_7 / var_316_6)

				if var_316_8 > 0 and var_316_2 < var_316_8 then
					arg_313_1.talkMaxDuration = var_316_8

					if var_316_8 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_5
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112077", "story_v_out_123112.awb") ~= 0 then
					local var_316_9 = manager.audio:GetVoiceLength("story_v_out_123112", "123112077", "story_v_out_123112.awb") / 1000

					if var_316_9 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_1
					end

					if var_316_4.prefab_name ~= "" and arg_313_1.actors_[var_316_4.prefab_name] ~= nil then
						local var_316_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_4.prefab_name].transform, "story_v_out_123112", "123112077", "story_v_out_123112.awb")

						arg_313_1:RecordAudio("123112077", var_316_10)
						arg_313_1:RecordAudio("123112077", var_316_10)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_123112", "123112077", "story_v_out_123112.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_123112", "123112077", "story_v_out_123112.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_11 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_11 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_11

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_11 and arg_313_1.time_ < var_316_1 + var_316_11 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play123112078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 123112078
		arg_317_1.duration_ = 7.57

		local var_317_0 = {
			zh = 3.866,
			ja = 7.566
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play123112079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055actionlink/1055action445")
			end

			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_320_2 = 0
			local var_320_3 = 0.45

			if var_320_2 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_4 = arg_317_1:FormatText(StoryNameCfg[481].name)

				arg_317_1.leftNameTxt_.text = var_320_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_5 = arg_317_1:GetWordFromCfg(123112078)
				local var_320_6 = arg_317_1:FormatText(var_320_5.content)

				arg_317_1.text_.text = var_320_6

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 18
				local var_320_8 = utf8.len(var_320_6)
				local var_320_9 = var_320_7 <= 0 and var_320_3 or var_320_3 * (var_320_8 / var_320_7)

				if var_320_9 > 0 and var_320_3 < var_320_9 then
					arg_317_1.talkMaxDuration = var_320_9

					if var_320_9 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_2
					end
				end

				arg_317_1.text_.text = var_320_6
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112078", "story_v_out_123112.awb") ~= 0 then
					local var_320_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112078", "story_v_out_123112.awb") / 1000

					if var_320_10 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_2
					end

					if var_320_5.prefab_name ~= "" and arg_317_1.actors_[var_320_5.prefab_name] ~= nil then
						local var_320_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_5.prefab_name].transform, "story_v_out_123112", "123112078", "story_v_out_123112.awb")

						arg_317_1:RecordAudio("123112078", var_320_11)
						arg_317_1:RecordAudio("123112078", var_320_11)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_123112", "123112078", "story_v_out_123112.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_123112", "123112078", "story_v_out_123112.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_12 = math.max(var_320_3, arg_317_1.talkMaxDuration)

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_12 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_2) / var_320_12

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_2 + var_320_12 and arg_317_1.time_ < var_320_2 + var_320_12 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play123112079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 123112079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play123112080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1055ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1055ui_story == nil then
				arg_321_1.var_.characterEffect1055ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect1055ui_story and not isNil(var_324_0) then
					local var_324_4 = Mathf.Lerp(0, 0.5, var_324_3)

					arg_321_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1055ui_story.fillRatio = var_324_4
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1055ui_story then
				local var_324_5 = 0.5

				arg_321_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1055ui_story.fillRatio = var_324_5
			end

			local var_324_6 = 0
			local var_324_7 = 0.25

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_8 = arg_321_1:FormatText(StoryNameCfg[7].name)

				arg_321_1.leftNameTxt_.text = var_324_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_9 = arg_321_1:GetWordFromCfg(123112079)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 10
				local var_324_12 = utf8.len(var_324_10)
				local var_324_13 = var_324_11 <= 0 and var_324_7 or var_324_7 * (var_324_12 / var_324_11)

				if var_324_13 > 0 and var_324_7 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_10
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_14 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_14 and arg_321_1.time_ < var_324_6 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play123112080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 123112080
		arg_325_1.duration_ = 17.1

		local var_325_0 = {
			zh = 9.833,
			ja = 17.1
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play123112081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1055ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1055ui_story == nil then
				arg_325_1.var_.characterEffect1055ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect1055ui_story and not isNil(var_328_0) then
					arg_325_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1055ui_story then
				arg_325_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_328_4 = 0

			if var_328_4 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_328_5 = 0
			local var_328_6 = 1.25

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_7 = arg_325_1:FormatText(StoryNameCfg[481].name)

				arg_325_1.leftNameTxt_.text = var_328_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_8 = arg_325_1:GetWordFromCfg(123112080)
				local var_328_9 = arg_325_1:FormatText(var_328_8.content)

				arg_325_1.text_.text = var_328_9

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_10 = 50
				local var_328_11 = utf8.len(var_328_9)
				local var_328_12 = var_328_10 <= 0 and var_328_6 or var_328_6 * (var_328_11 / var_328_10)

				if var_328_12 > 0 and var_328_6 < var_328_12 then
					arg_325_1.talkMaxDuration = var_328_12

					if var_328_12 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_12 + var_328_5
					end
				end

				arg_325_1.text_.text = var_328_9
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112080", "story_v_out_123112.awb") ~= 0 then
					local var_328_13 = manager.audio:GetVoiceLength("story_v_out_123112", "123112080", "story_v_out_123112.awb") / 1000

					if var_328_13 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_13 + var_328_5
					end

					if var_328_8.prefab_name ~= "" and arg_325_1.actors_[var_328_8.prefab_name] ~= nil then
						local var_328_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_8.prefab_name].transform, "story_v_out_123112", "123112080", "story_v_out_123112.awb")

						arg_325_1:RecordAudio("123112080", var_328_14)
						arg_325_1:RecordAudio("123112080", var_328_14)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_123112", "123112080", "story_v_out_123112.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_123112", "123112080", "story_v_out_123112.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_15 = math.max(var_328_6, arg_325_1.talkMaxDuration)

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_15 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_5) / var_328_15

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_5 + var_328_15 and arg_325_1.time_ < var_328_5 + var_328_15 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play123112081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 123112081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play123112082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1055ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1055ui_story == nil then
				arg_329_1.var_.characterEffect1055ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1055ui_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1055ui_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1055ui_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1055ui_story.fillRatio = var_332_5
			end

			local var_332_6 = 0
			local var_332_7 = 0.2

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_8 = arg_329_1:FormatText(StoryNameCfg[7].name)

				arg_329_1.leftNameTxt_.text = var_332_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_9 = arg_329_1:GetWordFromCfg(123112081)
				local var_332_10 = arg_329_1:FormatText(var_332_9.content)

				arg_329_1.text_.text = var_332_10

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_11 = 8
				local var_332_12 = utf8.len(var_332_10)
				local var_332_13 = var_332_11 <= 0 and var_332_7 or var_332_7 * (var_332_12 / var_332_11)

				if var_332_13 > 0 and var_332_7 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_6
					end
				end

				arg_329_1.text_.text = var_332_10
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_14 = math.max(var_332_7, arg_329_1.talkMaxDuration)

			if var_332_6 <= arg_329_1.time_ and arg_329_1.time_ < var_332_6 + var_332_14 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_6) / var_332_14

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_6 + var_332_14 and arg_329_1.time_ < var_332_6 + var_332_14 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play123112082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 123112082
		arg_333_1.duration_ = 2.27

		local var_333_0 = {
			zh = 2.266,
			ja = 1.999999999999
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play123112083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1055ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1055ui_story == nil then
				arg_333_1.var_.characterEffect1055ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1055ui_story and not isNil(var_336_0) then
					arg_333_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1055ui_story then
				arg_333_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_336_4 = 0

			if var_336_4 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_336_5 = 0
			local var_336_6 = 0.2

			if var_336_5 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_7 = arg_333_1:FormatText(StoryNameCfg[481].name)

				arg_333_1.leftNameTxt_.text = var_336_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_8 = arg_333_1:GetWordFromCfg(123112082)
				local var_336_9 = arg_333_1:FormatText(var_336_8.content)

				arg_333_1.text_.text = var_336_9

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_10 = 8
				local var_336_11 = utf8.len(var_336_9)
				local var_336_12 = var_336_10 <= 0 and var_336_6 or var_336_6 * (var_336_11 / var_336_10)

				if var_336_12 > 0 and var_336_6 < var_336_12 then
					arg_333_1.talkMaxDuration = var_336_12

					if var_336_12 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_12 + var_336_5
					end
				end

				arg_333_1.text_.text = var_336_9
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112082", "story_v_out_123112.awb") ~= 0 then
					local var_336_13 = manager.audio:GetVoiceLength("story_v_out_123112", "123112082", "story_v_out_123112.awb") / 1000

					if var_336_13 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_5
					end

					if var_336_8.prefab_name ~= "" and arg_333_1.actors_[var_336_8.prefab_name] ~= nil then
						local var_336_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_8.prefab_name].transform, "story_v_out_123112", "123112082", "story_v_out_123112.awb")

						arg_333_1:RecordAudio("123112082", var_336_14)
						arg_333_1:RecordAudio("123112082", var_336_14)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_123112", "123112082", "story_v_out_123112.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_123112", "123112082", "story_v_out_123112.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_15 = math.max(var_336_6, arg_333_1.talkMaxDuration)

			if var_336_5 <= arg_333_1.time_ and arg_333_1.time_ < var_336_5 + var_336_15 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_5) / var_336_15

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_5 + var_336_15 and arg_333_1.time_ < var_336_5 + var_336_15 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play123112083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 123112083
		arg_337_1.duration_ = 5.6

		local var_337_0 = {
			zh = 4.366,
			ja = 5.6
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play123112084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055actionlink/1055action452")
			end

			local var_340_1 = arg_337_1.actors_["1055ui_story"]
			local var_340_2 = 0

			if var_340_2 < arg_337_1.time_ and arg_337_1.time_ <= var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1055ui_story == nil then
				arg_337_1.var_.characterEffect1055ui_story = var_340_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_3 = 0.200000002980232

			if var_340_2 <= arg_337_1.time_ and arg_337_1.time_ < var_340_2 + var_340_3 and not isNil(var_340_1) then
				local var_340_4 = (arg_337_1.time_ - var_340_2) / var_340_3

				if arg_337_1.var_.characterEffect1055ui_story and not isNil(var_340_1) then
					arg_337_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_2 + var_340_3 and arg_337_1.time_ < var_340_2 + var_340_3 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1055ui_story then
				arg_337_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_340_5 = 0
			local var_340_6 = 0.575

			if var_340_5 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_7 = arg_337_1:FormatText(StoryNameCfg[481].name)

				arg_337_1.leftNameTxt_.text = var_340_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_8 = arg_337_1:GetWordFromCfg(123112083)
				local var_340_9 = arg_337_1:FormatText(var_340_8.content)

				arg_337_1.text_.text = var_340_9

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_10 = 23
				local var_340_11 = utf8.len(var_340_9)
				local var_340_12 = var_340_10 <= 0 and var_340_6 or var_340_6 * (var_340_11 / var_340_10)

				if var_340_12 > 0 and var_340_6 < var_340_12 then
					arg_337_1.talkMaxDuration = var_340_12

					if var_340_12 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_12 + var_340_5
					end
				end

				arg_337_1.text_.text = var_340_9
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112083", "story_v_out_123112.awb") ~= 0 then
					local var_340_13 = manager.audio:GetVoiceLength("story_v_out_123112", "123112083", "story_v_out_123112.awb") / 1000

					if var_340_13 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_5
					end

					if var_340_8.prefab_name ~= "" and arg_337_1.actors_[var_340_8.prefab_name] ~= nil then
						local var_340_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_8.prefab_name].transform, "story_v_out_123112", "123112083", "story_v_out_123112.awb")

						arg_337_1:RecordAudio("123112083", var_340_14)
						arg_337_1:RecordAudio("123112083", var_340_14)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_123112", "123112083", "story_v_out_123112.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_123112", "123112083", "story_v_out_123112.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_15 = math.max(var_340_6, arg_337_1.talkMaxDuration)

			if var_340_5 <= arg_337_1.time_ and arg_337_1.time_ < var_340_5 + var_340_15 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_5) / var_340_15

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_5 + var_340_15 and arg_337_1.time_ < var_340_5 + var_340_15 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play123112084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 123112084
		arg_341_1.duration_ = 13.93

		local var_341_0 = {
			zh = 10.566,
			ja = 13.933
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play123112085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 1.55

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[481].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_3 = arg_341_1:GetWordFromCfg(123112084)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 62
				local var_344_6 = utf8.len(var_344_4)
				local var_344_7 = var_344_5 <= 0 and var_344_1 or var_344_1 * (var_344_6 / var_344_5)

				if var_344_7 > 0 and var_344_1 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112084", "story_v_out_123112.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112084", "story_v_out_123112.awb") / 1000

					if var_344_8 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_0
					end

					if var_344_3.prefab_name ~= "" and arg_341_1.actors_[var_344_3.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_3.prefab_name].transform, "story_v_out_123112", "123112084", "story_v_out_123112.awb")

						arg_341_1:RecordAudio("123112084", var_344_9)
						arg_341_1:RecordAudio("123112084", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_123112", "123112084", "story_v_out_123112.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_123112", "123112084", "story_v_out_123112.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_10 and arg_341_1.time_ < var_344_0 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play123112085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 123112085
		arg_345_1.duration_ = 14.6

		local var_345_0 = {
			zh = 11.033,
			ja = 14.6
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play123112086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0
			local var_348_1 = 1.45

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_2 = arg_345_1:FormatText(StoryNameCfg[481].name)

				arg_345_1.leftNameTxt_.text = var_348_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_3 = arg_345_1:GetWordFromCfg(123112085)
				local var_348_4 = arg_345_1:FormatText(var_348_3.content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 58
				local var_348_6 = utf8.len(var_348_4)
				local var_348_7 = var_348_5 <= 0 and var_348_1 or var_348_1 * (var_348_6 / var_348_5)

				if var_348_7 > 0 and var_348_1 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_0
					end
				end

				arg_345_1.text_.text = var_348_4
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112085", "story_v_out_123112.awb") ~= 0 then
					local var_348_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112085", "story_v_out_123112.awb") / 1000

					if var_348_8 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_8 + var_348_0
					end

					if var_348_3.prefab_name ~= "" and arg_345_1.actors_[var_348_3.prefab_name] ~= nil then
						local var_348_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_3.prefab_name].transform, "story_v_out_123112", "123112085", "story_v_out_123112.awb")

						arg_345_1:RecordAudio("123112085", var_348_9)
						arg_345_1:RecordAudio("123112085", var_348_9)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_123112", "123112085", "story_v_out_123112.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_123112", "123112085", "story_v_out_123112.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_10 = math.max(var_348_1, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_10 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_0) / var_348_10

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_10 and arg_345_1.time_ < var_348_0 + var_348_10 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play123112086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 123112086
		arg_349_1.duration_ = 6.9

		local var_349_0 = {
			zh = 6.9,
			ja = 4.933
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play123112087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_2")
			end

			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_352_2 = 0
			local var_352_3 = 0.575

			if var_352_2 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_4 = arg_349_1:FormatText(StoryNameCfg[481].name)

				arg_349_1.leftNameTxt_.text = var_352_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_5 = arg_349_1:GetWordFromCfg(123112086)
				local var_352_6 = arg_349_1:FormatText(var_352_5.content)

				arg_349_1.text_.text = var_352_6

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 23
				local var_352_8 = utf8.len(var_352_6)
				local var_352_9 = var_352_7 <= 0 and var_352_3 or var_352_3 * (var_352_8 / var_352_7)

				if var_352_9 > 0 and var_352_3 < var_352_9 then
					arg_349_1.talkMaxDuration = var_352_9

					if var_352_9 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_2
					end
				end

				arg_349_1.text_.text = var_352_6
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112086", "story_v_out_123112.awb") ~= 0 then
					local var_352_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112086", "story_v_out_123112.awb") / 1000

					if var_352_10 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_2
					end

					if var_352_5.prefab_name ~= "" and arg_349_1.actors_[var_352_5.prefab_name] ~= nil then
						local var_352_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_5.prefab_name].transform, "story_v_out_123112", "123112086", "story_v_out_123112.awb")

						arg_349_1:RecordAudio("123112086", var_352_11)
						arg_349_1:RecordAudio("123112086", var_352_11)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_123112", "123112086", "story_v_out_123112.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_123112", "123112086", "story_v_out_123112.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_12 = math.max(var_352_3, arg_349_1.talkMaxDuration)

			if var_352_2 <= arg_349_1.time_ and arg_349_1.time_ < var_352_2 + var_352_12 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_2) / var_352_12

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_2 + var_352_12 and arg_349_1.time_ < var_352_2 + var_352_12 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play123112087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 123112087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play123112088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1055ui_story"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1055ui_story == nil then
				arg_353_1.var_.characterEffect1055ui_story = var_356_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.characterEffect1055ui_story and not isNil(var_356_0) then
					local var_356_4 = Mathf.Lerp(0, 0.5, var_356_3)

					arg_353_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1055ui_story.fillRatio = var_356_4
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1055ui_story then
				local var_356_5 = 0.5

				arg_353_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1055ui_story.fillRatio = var_356_5
			end

			local var_356_6 = 0
			local var_356_7 = 1.3

			if var_356_6 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_8 = arg_353_1:GetWordFromCfg(123112087)
				local var_356_9 = arg_353_1:FormatText(var_356_8.content)

				arg_353_1.text_.text = var_356_9

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_10 = 52
				local var_356_11 = utf8.len(var_356_9)
				local var_356_12 = var_356_10 <= 0 and var_356_7 or var_356_7 * (var_356_11 / var_356_10)

				if var_356_12 > 0 and var_356_7 < var_356_12 then
					arg_353_1.talkMaxDuration = var_356_12

					if var_356_12 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_12 + var_356_6
					end
				end

				arg_353_1.text_.text = var_356_9
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_13 = math.max(var_356_7, arg_353_1.talkMaxDuration)

			if var_356_6 <= arg_353_1.time_ and arg_353_1.time_ < var_356_6 + var_356_13 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_6) / var_356_13

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_6 + var_356_13 and arg_353_1.time_ < var_356_6 + var_356_13 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play123112088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 123112088
		arg_357_1.duration_ = 9.73

		local var_357_0 = {
			zh = 6.7,
			ja = 9.733
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play123112089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1055ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1055ui_story == nil then
				arg_357_1.var_.characterEffect1055ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect1055ui_story and not isNil(var_360_0) then
					arg_357_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1055ui_story then
				arg_357_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_360_4 = 0

			if var_360_4 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_360_5 = 0

			if var_360_5 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_360_6 = 0
			local var_360_7 = 0.75

			if var_360_6 < arg_357_1.time_ and arg_357_1.time_ <= var_360_6 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_8 = arg_357_1:FormatText(StoryNameCfg[481].name)

				arg_357_1.leftNameTxt_.text = var_360_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_9 = arg_357_1:GetWordFromCfg(123112088)
				local var_360_10 = arg_357_1:FormatText(var_360_9.content)

				arg_357_1.text_.text = var_360_10

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_11 = 30
				local var_360_12 = utf8.len(var_360_10)
				local var_360_13 = var_360_11 <= 0 and var_360_7 or var_360_7 * (var_360_12 / var_360_11)

				if var_360_13 > 0 and var_360_7 < var_360_13 then
					arg_357_1.talkMaxDuration = var_360_13

					if var_360_13 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_13 + var_360_6
					end
				end

				arg_357_1.text_.text = var_360_10
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112088", "story_v_out_123112.awb") ~= 0 then
					local var_360_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112088", "story_v_out_123112.awb") / 1000

					if var_360_14 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_14 + var_360_6
					end

					if var_360_9.prefab_name ~= "" and arg_357_1.actors_[var_360_9.prefab_name] ~= nil then
						local var_360_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_9.prefab_name].transform, "story_v_out_123112", "123112088", "story_v_out_123112.awb")

						arg_357_1:RecordAudio("123112088", var_360_15)
						arg_357_1:RecordAudio("123112088", var_360_15)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_123112", "123112088", "story_v_out_123112.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_123112", "123112088", "story_v_out_123112.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_16 = math.max(var_360_7, arg_357_1.talkMaxDuration)

			if var_360_6 <= arg_357_1.time_ and arg_357_1.time_ < var_360_6 + var_360_16 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_6) / var_360_16

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_6 + var_360_16 and arg_357_1.time_ < var_360_6 + var_360_16 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play123112089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 123112089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play123112090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1055ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1055ui_story == nil then
				arg_361_1.var_.characterEffect1055ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect1055ui_story and not isNil(var_364_0) then
					local var_364_4 = Mathf.Lerp(0, 0.5, var_364_3)

					arg_361_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1055ui_story.fillRatio = var_364_4
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1055ui_story then
				local var_364_5 = 0.5

				arg_361_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1055ui_story.fillRatio = var_364_5
			end

			local var_364_6 = 0
			local var_364_7 = 0.5

			if var_364_6 < arg_361_1.time_ and arg_361_1.time_ <= var_364_6 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_8 = arg_361_1:FormatText(StoryNameCfg[7].name)

				arg_361_1.leftNameTxt_.text = var_364_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_9 = arg_361_1:GetWordFromCfg(123112089)
				local var_364_10 = arg_361_1:FormatText(var_364_9.content)

				arg_361_1.text_.text = var_364_10

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_11 = 20
				local var_364_12 = utf8.len(var_364_10)
				local var_364_13 = var_364_11 <= 0 and var_364_7 or var_364_7 * (var_364_12 / var_364_11)

				if var_364_13 > 0 and var_364_7 < var_364_13 then
					arg_361_1.talkMaxDuration = var_364_13

					if var_364_13 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_13 + var_364_6
					end
				end

				arg_361_1.text_.text = var_364_10
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_14 = math.max(var_364_7, arg_361_1.talkMaxDuration)

			if var_364_6 <= arg_361_1.time_ and arg_361_1.time_ < var_364_6 + var_364_14 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_6) / var_364_14

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_6 + var_364_14 and arg_361_1.time_ < var_364_6 + var_364_14 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play123112090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 123112090
		arg_365_1.duration_ = 4.07

		local var_365_0 = {
			zh = 2.566,
			ja = 4.066
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play123112091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1055ui_story"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1055ui_story == nil then
				arg_365_1.var_.characterEffect1055ui_story = var_368_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.characterEffect1055ui_story and not isNil(var_368_0) then
					arg_365_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1055ui_story then
				arg_365_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_368_4 = 0

			if var_368_4 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_368_5 = 0

			if var_368_5 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 then
				arg_365_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_368_6 = 0
			local var_368_7 = 0.35

			if var_368_6 < arg_365_1.time_ and arg_365_1.time_ <= var_368_6 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_8 = arg_365_1:FormatText(StoryNameCfg[481].name)

				arg_365_1.leftNameTxt_.text = var_368_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_9 = arg_365_1:GetWordFromCfg(123112090)
				local var_368_10 = arg_365_1:FormatText(var_368_9.content)

				arg_365_1.text_.text = var_368_10

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_11 = 14
				local var_368_12 = utf8.len(var_368_10)
				local var_368_13 = var_368_11 <= 0 and var_368_7 or var_368_7 * (var_368_12 / var_368_11)

				if var_368_13 > 0 and var_368_7 < var_368_13 then
					arg_365_1.talkMaxDuration = var_368_13

					if var_368_13 + var_368_6 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_13 + var_368_6
					end
				end

				arg_365_1.text_.text = var_368_10
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112090", "story_v_out_123112.awb") ~= 0 then
					local var_368_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112090", "story_v_out_123112.awb") / 1000

					if var_368_14 + var_368_6 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_14 + var_368_6
					end

					if var_368_9.prefab_name ~= "" and arg_365_1.actors_[var_368_9.prefab_name] ~= nil then
						local var_368_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_9.prefab_name].transform, "story_v_out_123112", "123112090", "story_v_out_123112.awb")

						arg_365_1:RecordAudio("123112090", var_368_15)
						arg_365_1:RecordAudio("123112090", var_368_15)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_123112", "123112090", "story_v_out_123112.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_123112", "123112090", "story_v_out_123112.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_16 = math.max(var_368_7, arg_365_1.talkMaxDuration)

			if var_368_6 <= arg_365_1.time_ and arg_365_1.time_ < var_368_6 + var_368_16 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_6) / var_368_16

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_6 + var_368_16 and arg_365_1.time_ < var_368_6 + var_368_16 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play123112091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 123112091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play123112092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1055ui_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1055ui_story == nil then
				arg_369_1.var_.characterEffect1055ui_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect1055ui_story and not isNil(var_372_0) then
					local var_372_4 = Mathf.Lerp(0, 0.5, var_372_3)

					arg_369_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1055ui_story.fillRatio = var_372_4
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1055ui_story then
				local var_372_5 = 0.5

				arg_369_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1055ui_story.fillRatio = var_372_5
			end

			local var_372_6 = 0
			local var_372_7 = 0.45

			if var_372_6 < arg_369_1.time_ and arg_369_1.time_ <= var_372_6 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_8 = arg_369_1:FormatText(StoryNameCfg[7].name)

				arg_369_1.leftNameTxt_.text = var_372_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_9 = arg_369_1:GetWordFromCfg(123112091)
				local var_372_10 = arg_369_1:FormatText(var_372_9.content)

				arg_369_1.text_.text = var_372_10

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_11 = 18
				local var_372_12 = utf8.len(var_372_10)
				local var_372_13 = var_372_11 <= 0 and var_372_7 or var_372_7 * (var_372_12 / var_372_11)

				if var_372_13 > 0 and var_372_7 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_6 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_6
					end
				end

				arg_369_1.text_.text = var_372_10
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_14 = math.max(var_372_7, arg_369_1.talkMaxDuration)

			if var_372_6 <= arg_369_1.time_ and arg_369_1.time_ < var_372_6 + var_372_14 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_6) / var_372_14

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_6 + var_372_14 and arg_369_1.time_ < var_372_6 + var_372_14 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play123112092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 123112092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play123112093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_376_1 = 0
			local var_376_2 = 0.75

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_3 = arg_373_1:GetWordFromCfg(123112092)
				local var_376_4 = arg_373_1:FormatText(var_376_3.content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 30
				local var_376_6 = utf8.len(var_376_4)
				local var_376_7 = var_376_5 <= 0 and var_376_2 or var_376_2 * (var_376_6 / var_376_5)

				if var_376_7 > 0 and var_376_2 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_1 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_1
					end
				end

				arg_373_1.text_.text = var_376_4
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_8 = math.max(var_376_2, arg_373_1.talkMaxDuration)

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_8 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_1) / var_376_8

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_1 + var_376_8 and arg_373_1.time_ < var_376_1 + var_376_8 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play123112093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 123112093
		arg_377_1.duration_ = 11.73

		local var_377_0 = {
			zh = 11,
			ja = 11.733
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play123112094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1055ui_story"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1055ui_story == nil then
				arg_377_1.var_.characterEffect1055ui_story = var_380_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.characterEffect1055ui_story and not isNil(var_380_0) then
					arg_377_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1055ui_story then
				arg_377_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_380_4 = 0

			if var_380_4 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_380_5 = 0

			if var_380_5 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_6 = 0
			local var_380_7 = 1.375

			if var_380_6 < arg_377_1.time_ and arg_377_1.time_ <= var_380_6 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_8 = arg_377_1:FormatText(StoryNameCfg[481].name)

				arg_377_1.leftNameTxt_.text = var_380_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_9 = arg_377_1:GetWordFromCfg(123112093)
				local var_380_10 = arg_377_1:FormatText(var_380_9.content)

				arg_377_1.text_.text = var_380_10

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_11 = 55
				local var_380_12 = utf8.len(var_380_10)
				local var_380_13 = var_380_11 <= 0 and var_380_7 or var_380_7 * (var_380_12 / var_380_11)

				if var_380_13 > 0 and var_380_7 < var_380_13 then
					arg_377_1.talkMaxDuration = var_380_13

					if var_380_13 + var_380_6 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_13 + var_380_6
					end
				end

				arg_377_1.text_.text = var_380_10
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112093", "story_v_out_123112.awb") ~= 0 then
					local var_380_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112093", "story_v_out_123112.awb") / 1000

					if var_380_14 + var_380_6 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_14 + var_380_6
					end

					if var_380_9.prefab_name ~= "" and arg_377_1.actors_[var_380_9.prefab_name] ~= nil then
						local var_380_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_9.prefab_name].transform, "story_v_out_123112", "123112093", "story_v_out_123112.awb")

						arg_377_1:RecordAudio("123112093", var_380_15)
						arg_377_1:RecordAudio("123112093", var_380_15)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_123112", "123112093", "story_v_out_123112.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_123112", "123112093", "story_v_out_123112.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_16 = math.max(var_380_7, arg_377_1.talkMaxDuration)

			if var_380_6 <= arg_377_1.time_ and arg_377_1.time_ < var_380_6 + var_380_16 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_6) / var_380_16

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_6 + var_380_16 and arg_377_1.time_ < var_380_6 + var_380_16 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play123112094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 123112094
		arg_381_1.duration_ = 11.9

		local var_381_0 = {
			zh = 5.566,
			ja = 11.9
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play123112095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_384_1 = 0
			local var_384_2 = 0.625

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_3 = arg_381_1:FormatText(StoryNameCfg[481].name)

				arg_381_1.leftNameTxt_.text = var_384_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_4 = arg_381_1:GetWordFromCfg(123112094)
				local var_384_5 = arg_381_1:FormatText(var_384_4.content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_6 = 25
				local var_384_7 = utf8.len(var_384_5)
				local var_384_8 = var_384_6 <= 0 and var_384_2 or var_384_2 * (var_384_7 / var_384_6)

				if var_384_8 > 0 and var_384_2 < var_384_8 then
					arg_381_1.talkMaxDuration = var_384_8

					if var_384_8 + var_384_1 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_1
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112094", "story_v_out_123112.awb") ~= 0 then
					local var_384_9 = manager.audio:GetVoiceLength("story_v_out_123112", "123112094", "story_v_out_123112.awb") / 1000

					if var_384_9 + var_384_1 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_9 + var_384_1
					end

					if var_384_4.prefab_name ~= "" and arg_381_1.actors_[var_384_4.prefab_name] ~= nil then
						local var_384_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_4.prefab_name].transform, "story_v_out_123112", "123112094", "story_v_out_123112.awb")

						arg_381_1:RecordAudio("123112094", var_384_10)
						arg_381_1:RecordAudio("123112094", var_384_10)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_123112", "123112094", "story_v_out_123112.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_123112", "123112094", "story_v_out_123112.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_11 = math.max(var_384_2, arg_381_1.talkMaxDuration)

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_11 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_1) / var_384_11

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_1 + var_384_11 and arg_381_1.time_ < var_384_1 + var_384_11 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play123112095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 123112095
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play123112096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1055ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1055ui_story == nil then
				arg_385_1.var_.characterEffect1055ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect1055ui_story and not isNil(var_388_0) then
					local var_388_4 = Mathf.Lerp(0, 0.5, var_388_3)

					arg_385_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1055ui_story.fillRatio = var_388_4
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1055ui_story then
				local var_388_5 = 0.5

				arg_385_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1055ui_story.fillRatio = var_388_5
			end

			local var_388_6 = 0
			local var_388_7 = 1.2

			if var_388_6 < arg_385_1.time_ and arg_385_1.time_ <= var_388_6 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_8 = arg_385_1:GetWordFromCfg(123112095)
				local var_388_9 = arg_385_1:FormatText(var_388_8.content)

				arg_385_1.text_.text = var_388_9

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_10 = 48
				local var_388_11 = utf8.len(var_388_9)
				local var_388_12 = var_388_10 <= 0 and var_388_7 or var_388_7 * (var_388_11 / var_388_10)

				if var_388_12 > 0 and var_388_7 < var_388_12 then
					arg_385_1.talkMaxDuration = var_388_12

					if var_388_12 + var_388_6 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_12 + var_388_6
					end
				end

				arg_385_1.text_.text = var_388_9
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_13 = math.max(var_388_7, arg_385_1.talkMaxDuration)

			if var_388_6 <= arg_385_1.time_ and arg_385_1.time_ < var_388_6 + var_388_13 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_6) / var_388_13

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_6 + var_388_13 and arg_385_1.time_ < var_388_6 + var_388_13 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play123112096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 123112096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play123112097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 0.85

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_2 = arg_389_1:FormatText(StoryNameCfg[7].name)

				arg_389_1.leftNameTxt_.text = var_392_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_3 = arg_389_1:GetWordFromCfg(123112096)
				local var_392_4 = arg_389_1:FormatText(var_392_3.content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 34
				local var_392_6 = utf8.len(var_392_4)
				local var_392_7 = var_392_5 <= 0 and var_392_1 or var_392_1 * (var_392_6 / var_392_5)

				if var_392_7 > 0 and var_392_1 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_8 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_8 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_8

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_8 and arg_389_1.time_ < var_392_0 + var_392_8 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play123112097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 123112097
		arg_393_1.duration_ = 11.5

		local var_393_0 = {
			zh = 10.1,
			ja = 11.5
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play123112098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1055ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1055ui_story == nil then
				arg_393_1.var_.characterEffect1055ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect1055ui_story and not isNil(var_396_0) then
					arg_393_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1055ui_story then
				arg_393_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_396_4 = 0

			if var_396_4 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			local var_396_5 = 0

			if var_396_5 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 then
				arg_393_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_396_6 = 0
			local var_396_7 = 1.15

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_8 = arg_393_1:FormatText(StoryNameCfg[481].name)

				arg_393_1.leftNameTxt_.text = var_396_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_9 = arg_393_1:GetWordFromCfg(123112097)
				local var_396_10 = arg_393_1:FormatText(var_396_9.content)

				arg_393_1.text_.text = var_396_10

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 46
				local var_396_12 = utf8.len(var_396_10)
				local var_396_13 = var_396_11 <= 0 and var_396_7 or var_396_7 * (var_396_12 / var_396_11)

				if var_396_13 > 0 and var_396_7 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_10
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112097", "story_v_out_123112.awb") ~= 0 then
					local var_396_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112097", "story_v_out_123112.awb") / 1000

					if var_396_14 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_14 + var_396_6
					end

					if var_396_9.prefab_name ~= "" and arg_393_1.actors_[var_396_9.prefab_name] ~= nil then
						local var_396_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_9.prefab_name].transform, "story_v_out_123112", "123112097", "story_v_out_123112.awb")

						arg_393_1:RecordAudio("123112097", var_396_15)
						arg_393_1:RecordAudio("123112097", var_396_15)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_123112", "123112097", "story_v_out_123112.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_123112", "123112097", "story_v_out_123112.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_16 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_16 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_16

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_16 and arg_393_1.time_ < var_396_6 + var_396_16 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play123112098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 123112098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play123112099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1055ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1055ui_story == nil then
				arg_397_1.var_.characterEffect1055ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1055ui_story and not isNil(var_400_0) then
					local var_400_4 = Mathf.Lerp(0, 0.5, var_400_3)

					arg_397_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1055ui_story.fillRatio = var_400_4
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1055ui_story then
				local var_400_5 = 0.5

				arg_397_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1055ui_story.fillRatio = var_400_5
			end

			local var_400_6 = 0
			local var_400_7 = 0.2

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_8 = arg_397_1:FormatText(StoryNameCfg[7].name)

				arg_397_1.leftNameTxt_.text = var_400_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_9 = arg_397_1:GetWordFromCfg(123112098)
				local var_400_10 = arg_397_1:FormatText(var_400_9.content)

				arg_397_1.text_.text = var_400_10

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_11 = 8
				local var_400_12 = utf8.len(var_400_10)
				local var_400_13 = var_400_11 <= 0 and var_400_7 or var_400_7 * (var_400_12 / var_400_11)

				if var_400_13 > 0 and var_400_7 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13

					if var_400_13 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_6
					end
				end

				arg_397_1.text_.text = var_400_10
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_14 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_14 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_14

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_14 and arg_397_1.time_ < var_400_6 + var_400_14 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play123112099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 123112099
		arg_401_1.duration_ = 4.7

		local var_401_0 = {
			zh = 4.7,
			ja = 3.133
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play123112100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1055ui_story"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect1055ui_story == nil then
				arg_401_1.var_.characterEffect1055ui_story = var_404_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.characterEffect1055ui_story and not isNil(var_404_0) then
					arg_401_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect1055ui_story then
				arg_401_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_404_4 = 0

			if var_404_4 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_404_5 = 0
			local var_404_6 = 0.575

			if var_404_5 < arg_401_1.time_ and arg_401_1.time_ <= var_404_5 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_7 = arg_401_1:FormatText(StoryNameCfg[481].name)

				arg_401_1.leftNameTxt_.text = var_404_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_8 = arg_401_1:GetWordFromCfg(123112099)
				local var_404_9 = arg_401_1:FormatText(var_404_8.content)

				arg_401_1.text_.text = var_404_9

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_10 = 23
				local var_404_11 = utf8.len(var_404_9)
				local var_404_12 = var_404_10 <= 0 and var_404_6 or var_404_6 * (var_404_11 / var_404_10)

				if var_404_12 > 0 and var_404_6 < var_404_12 then
					arg_401_1.talkMaxDuration = var_404_12

					if var_404_12 + var_404_5 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_12 + var_404_5
					end
				end

				arg_401_1.text_.text = var_404_9
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112099", "story_v_out_123112.awb") ~= 0 then
					local var_404_13 = manager.audio:GetVoiceLength("story_v_out_123112", "123112099", "story_v_out_123112.awb") / 1000

					if var_404_13 + var_404_5 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_13 + var_404_5
					end

					if var_404_8.prefab_name ~= "" and arg_401_1.actors_[var_404_8.prefab_name] ~= nil then
						local var_404_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_8.prefab_name].transform, "story_v_out_123112", "123112099", "story_v_out_123112.awb")

						arg_401_1:RecordAudio("123112099", var_404_14)
						arg_401_1:RecordAudio("123112099", var_404_14)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_123112", "123112099", "story_v_out_123112.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_123112", "123112099", "story_v_out_123112.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_15 = math.max(var_404_6, arg_401_1.talkMaxDuration)

			if var_404_5 <= arg_401_1.time_ and arg_401_1.time_ < var_404_5 + var_404_15 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_5) / var_404_15

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_5 + var_404_15 and arg_401_1.time_ < var_404_5 + var_404_15 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play123112100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 123112100
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play123112101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1055ui_story"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1055ui_story == nil then
				arg_405_1.var_.characterEffect1055ui_story = var_408_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.characterEffect1055ui_story and not isNil(var_408_0) then
					local var_408_4 = Mathf.Lerp(0, 0.5, var_408_3)

					arg_405_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1055ui_story.fillRatio = var_408_4
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1055ui_story then
				local var_408_5 = 0.5

				arg_405_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1055ui_story.fillRatio = var_408_5
			end

			local var_408_6 = 0
			local var_408_7 = 0.475

			if var_408_6 < arg_405_1.time_ and arg_405_1.time_ <= var_408_6 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_8 = arg_405_1:FormatText(StoryNameCfg[7].name)

				arg_405_1.leftNameTxt_.text = var_408_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_9 = arg_405_1:GetWordFromCfg(123112100)
				local var_408_10 = arg_405_1:FormatText(var_408_9.content)

				arg_405_1.text_.text = var_408_10

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 19
				local var_408_12 = utf8.len(var_408_10)
				local var_408_13 = var_408_11 <= 0 and var_408_7 or var_408_7 * (var_408_12 / var_408_11)

				if var_408_13 > 0 and var_408_7 < var_408_13 then
					arg_405_1.talkMaxDuration = var_408_13

					if var_408_13 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_13 + var_408_6
					end
				end

				arg_405_1.text_.text = var_408_10
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_14 = math.max(var_408_7, arg_405_1.talkMaxDuration)

			if var_408_6 <= arg_405_1.time_ and arg_405_1.time_ < var_408_6 + var_408_14 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_6) / var_408_14

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_6 + var_408_14 and arg_405_1.time_ < var_408_6 + var_408_14 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play123112101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 123112101
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play123112102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1055ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos1055ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, 100, 0)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1055ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, 100, 0)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["1055ui_story"]
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1055ui_story == nil then
				arg_409_1.var_.characterEffect1055ui_story = var_412_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 and not isNil(var_412_9) then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11

				if arg_409_1.var_.characterEffect1055ui_story and not isNil(var_412_9) then
					local var_412_13 = Mathf.Lerp(0, 0.5, var_412_12)

					arg_409_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1055ui_story.fillRatio = var_412_13
				end
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1055ui_story then
				local var_412_14 = 0.5

				arg_409_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1055ui_story.fillRatio = var_412_14
			end

			local var_412_15 = 0
			local var_412_16 = 0.7

			if var_412_15 < arg_409_1.time_ and arg_409_1.time_ <= var_412_15 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_17 = arg_409_1:GetWordFromCfg(123112101)
				local var_412_18 = arg_409_1:FormatText(var_412_17.content)

				arg_409_1.text_.text = var_412_18

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_19 = 28
				local var_412_20 = utf8.len(var_412_18)
				local var_412_21 = var_412_19 <= 0 and var_412_16 or var_412_16 * (var_412_20 / var_412_19)

				if var_412_21 > 0 and var_412_16 < var_412_21 then
					arg_409_1.talkMaxDuration = var_412_21

					if var_412_21 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_21 + var_412_15
					end
				end

				arg_409_1.text_.text = var_412_18
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_22 = math.max(var_412_16, arg_409_1.talkMaxDuration)

			if var_412_15 <= arg_409_1.time_ and arg_409_1.time_ < var_412_15 + var_412_22 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_15) / var_412_22

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_15 + var_412_22 and arg_409_1.time_ < var_412_15 + var_412_22 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
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

		arg_409_1:InitPlayNodeList()
	end,
	Play123112102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 123112102
		arg_413_1.duration_ = 6.27

		local var_413_0 = {
			zh = 3.666,
			ja = 6.266
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play123112103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1093ui_story"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos1093ui_story = var_416_0.localPosition
			end

			local var_416_2 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2
				local var_416_4 = Vector3.New(0, -1.11, -5.88)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1093ui_story, var_416_4, var_416_3)

				local var_416_5 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_5.x, var_416_5.y, var_416_5.z)

				local var_416_6 = var_416_0.localEulerAngles

				var_416_6.z = 0
				var_416_6.x = 0
				var_416_0.localEulerAngles = var_416_6
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_416_7 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_7.x, var_416_7.y, var_416_7.z)

				local var_416_8 = var_416_0.localEulerAngles

				var_416_8.z = 0
				var_416_8.x = 0
				var_416_0.localEulerAngles = var_416_8
			end

			local var_416_9 = arg_413_1.actors_["1093ui_story"]
			local var_416_10 = 0

			if var_416_10 < arg_413_1.time_ and arg_413_1.time_ <= var_416_10 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect1093ui_story == nil then
				arg_413_1.var_.characterEffect1093ui_story = var_416_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_11 = 0.200000002980232

			if var_416_10 <= arg_413_1.time_ and arg_413_1.time_ < var_416_10 + var_416_11 and not isNil(var_416_9) then
				local var_416_12 = (arg_413_1.time_ - var_416_10) / var_416_11

				if arg_413_1.var_.characterEffect1093ui_story and not isNil(var_416_9) then
					arg_413_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_10 + var_416_11 and arg_413_1.time_ < var_416_10 + var_416_11 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect1093ui_story then
				arg_413_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_416_13 = 0

			if var_416_13 < arg_413_1.time_ and arg_413_1.time_ <= var_416_13 + arg_416_0 then
				arg_413_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			local var_416_14 = 0

			if var_416_14 < arg_413_1.time_ and arg_413_1.time_ <= var_416_14 + arg_416_0 then
				arg_413_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_416_15 = 0
			local var_416_16 = 0.375

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_17 = arg_413_1:FormatText(StoryNameCfg[73].name)

				arg_413_1.leftNameTxt_.text = var_416_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_18 = arg_413_1:GetWordFromCfg(123112102)
				local var_416_19 = arg_413_1:FormatText(var_416_18.content)

				arg_413_1.text_.text = var_416_19

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_20 = 15
				local var_416_21 = utf8.len(var_416_19)
				local var_416_22 = var_416_20 <= 0 and var_416_16 or var_416_16 * (var_416_21 / var_416_20)

				if var_416_22 > 0 and var_416_16 < var_416_22 then
					arg_413_1.talkMaxDuration = var_416_22

					if var_416_22 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_22 + var_416_15
					end
				end

				arg_413_1.text_.text = var_416_19
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112102", "story_v_out_123112.awb") ~= 0 then
					local var_416_23 = manager.audio:GetVoiceLength("story_v_out_123112", "123112102", "story_v_out_123112.awb") / 1000

					if var_416_23 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_23 + var_416_15
					end

					if var_416_18.prefab_name ~= "" and arg_413_1.actors_[var_416_18.prefab_name] ~= nil then
						local var_416_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_18.prefab_name].transform, "story_v_out_123112", "123112102", "story_v_out_123112.awb")

						arg_413_1:RecordAudio("123112102", var_416_24)
						arg_413_1:RecordAudio("123112102", var_416_24)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_123112", "123112102", "story_v_out_123112.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_123112", "123112102", "story_v_out_123112.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_25 = math.max(var_416_16, arg_413_1.talkMaxDuration)

			if var_416_15 <= arg_413_1.time_ and arg_413_1.time_ < var_416_15 + var_416_25 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_15) / var_416_25

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_15 + var_416_25 and arg_413_1.time_ < var_416_15 + var_416_25 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
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

		arg_413_1:InitPlayNodeList()
	end,
	Play123112103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 123112103
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play123112104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1093ui_story"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1093ui_story == nil then
				arg_417_1.var_.characterEffect1093ui_story = var_420_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.characterEffect1093ui_story and not isNil(var_420_0) then
					local var_420_4 = Mathf.Lerp(0, 0.5, var_420_3)

					arg_417_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1093ui_story.fillRatio = var_420_4
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1093ui_story then
				local var_420_5 = 0.5

				arg_417_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1093ui_story.fillRatio = var_420_5
			end

			local var_420_6 = 0
			local var_420_7 = 0.875

			if var_420_6 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_8 = arg_417_1:GetWordFromCfg(123112103)
				local var_420_9 = arg_417_1:FormatText(var_420_8.content)

				arg_417_1.text_.text = var_420_9

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_10 = 35
				local var_420_11 = utf8.len(var_420_9)
				local var_420_12 = var_420_10 <= 0 and var_420_7 or var_420_7 * (var_420_11 / var_420_10)

				if var_420_12 > 0 and var_420_7 < var_420_12 then
					arg_417_1.talkMaxDuration = var_420_12

					if var_420_12 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_12 + var_420_6
					end
				end

				arg_417_1.text_.text = var_420_9
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_13 = math.max(var_420_7, arg_417_1.talkMaxDuration)

			if var_420_6 <= arg_417_1.time_ and arg_417_1.time_ < var_420_6 + var_420_13 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_6) / var_420_13

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_6 + var_420_13 and arg_417_1.time_ < var_420_6 + var_420_13 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play123112104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 123112104
		arg_421_1.duration_ = 6.6

		local var_421_0 = {
			zh = 4.633,
			ja = 6.6
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
			arg_421_1.auto_ = false
		end

		function arg_421_1.playNext_(arg_423_0)
			arg_421_1.onStoryFinished_()
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1093ui_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos1093ui_story = var_424_0.localPosition
			end

			local var_424_2 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2
				local var_424_4 = Vector3.New(0, 100, 0)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1093ui_story, var_424_4, var_424_3)

				local var_424_5 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_5.x, var_424_5.y, var_424_5.z)

				local var_424_6 = var_424_0.localEulerAngles

				var_424_6.z = 0
				var_424_6.x = 0
				var_424_0.localEulerAngles = var_424_6
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0, 100, 0)

				local var_424_7 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_7.x, var_424_7.y, var_424_7.z)

				local var_424_8 = var_424_0.localEulerAngles

				var_424_8.z = 0
				var_424_8.x = 0
				var_424_0.localEulerAngles = var_424_8
			end

			local var_424_9 = 0
			local var_424_10 = 0.45

			if var_424_9 < arg_421_1.time_ and arg_421_1.time_ <= var_424_9 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_11 = arg_421_1:FormatText(StoryNameCfg[485].name)

				arg_421_1.leftNameTxt_.text = var_424_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_12 = arg_421_1:GetWordFromCfg(123112104)
				local var_424_13 = arg_421_1:FormatText(var_424_12.content)

				arg_421_1.text_.text = var_424_13

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_14 = 18
				local var_424_15 = utf8.len(var_424_13)
				local var_424_16 = var_424_14 <= 0 and var_424_10 or var_424_10 * (var_424_15 / var_424_14)

				if var_424_16 > 0 and var_424_10 < var_424_16 then
					arg_421_1.talkMaxDuration = var_424_16

					if var_424_16 + var_424_9 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_16 + var_424_9
					end
				end

				arg_421_1.text_.text = var_424_13
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112104", "story_v_out_123112.awb") ~= 0 then
					local var_424_17 = manager.audio:GetVoiceLength("story_v_out_123112", "123112104", "story_v_out_123112.awb") / 1000

					if var_424_17 + var_424_9 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_17 + var_424_9
					end

					if var_424_12.prefab_name ~= "" and arg_421_1.actors_[var_424_12.prefab_name] ~= nil then
						local var_424_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_12.prefab_name].transform, "story_v_out_123112", "123112104", "story_v_out_123112.awb")

						arg_421_1:RecordAudio("123112104", var_424_18)
						arg_421_1:RecordAudio("123112104", var_424_18)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_123112", "123112104", "story_v_out_123112.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_123112", "123112104", "story_v_out_123112.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_19 = math.max(var_424_10, arg_421_1.talkMaxDuration)

			if var_424_9 <= arg_421_1.time_ and arg_421_1.time_ < var_424_9 + var_424_19 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_9) / var_424_19

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_9 + var_424_19 and arg_421_1.time_ < var_424_9 + var_424_19 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
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

		arg_421_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K06g",
		"TextureConfig/Background/K05g"
	},
	voices = {
		"story_v_out_123112.awb"
	}
}
