return {
	Play106601001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106601001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play106601002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B10d"

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
				local var_4_5 = arg_1_1.bgs_.B10d

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
					if iter_4_0 ~= "B10d" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0
			local var_4_17 = 0.366666666666667

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				local var_4_18 = "play"
				local var_4_19 = "music"

				arg_1_1:AudioAction(var_4_18, var_4_19, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = ""
				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_21 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			local var_4_22 = 0.533333333333333
			local var_4_23 = 0.466666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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

			local var_4_28 = 0
			local var_4_29 = 0.225

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_31 = arg_1_1:GetWordFromCfg(106601001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 9
				local var_4_34 = utf8.len(var_4_32)
				local var_4_35 = var_4_33 <= 0 and var_4_29 or var_4_29 * (var_4_34 / var_4_33)

				if var_4_35 > 0 and var_4_29 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_28 = var_4_28 + 0.3

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_28 + 0.3
			local var_4_37 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play106601002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 106601002
		arg_9_1.duration_ = 3.7

		local var_9_0 = {
			ja = 3.7,
			ko = 2.2,
			en = 1.999999999999
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
				arg_9_0:Play106601003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1066ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1066ui_story"]
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1066ui_story == nil then
				arg_9_1.var_.characterEffect1066ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_7 = 0.1

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 and not isNil(var_12_5) then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7

				if arg_9_1.var_.characterEffect1066ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1066ui_story then
				arg_9_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_12_9 = arg_9_1.actors_["1066ui_story"].transform
			local var_12_10 = 0

			if var_12_10 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.var_.moveOldPos1066ui_story = var_12_9.localPosition
			end

			local var_12_11 = 0.001

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_11 then
				local var_12_12 = (arg_9_1.time_ - var_12_10) / var_12_11
				local var_12_13 = Vector3.New(0, -0.82, -5.5)

				var_12_9.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1066ui_story, var_12_13, var_12_12)

				local var_12_14 = manager.ui.mainCamera.transform.position - var_12_9.position

				var_12_9.forward = Vector3.New(var_12_14.x, var_12_14.y, var_12_14.z)

				local var_12_15 = var_12_9.localEulerAngles

				var_12_15.z = 0
				var_12_15.x = 0
				var_12_9.localEulerAngles = var_12_15
			end

			if arg_9_1.time_ >= var_12_10 + var_12_11 and arg_9_1.time_ < var_12_10 + var_12_11 + arg_12_0 then
				var_12_9.localPosition = Vector3.New(0, -0.82, -5.5)

				local var_12_16 = manager.ui.mainCamera.transform.position - var_12_9.position

				var_12_9.forward = Vector3.New(var_12_16.x, var_12_16.y, var_12_16.z)

				local var_12_17 = var_12_9.localEulerAngles

				var_12_17.z = 0
				var_12_17.x = 0
				var_12_9.localEulerAngles = var_12_17
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.225

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[32].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(106601002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 9
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

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601002", "story_v_side_old_106601.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601002", "story_v_side_old_106601.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_side_old_106601", "106601002", "story_v_side_old_106601.awb")

						arg_9_1:RecordAudio("106601002", var_12_29)
						arg_9_1:RecordAudio("106601002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601002", "story_v_side_old_106601.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601002", "story_v_side_old_106601.awb")
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
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play106601003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 106601003
		arg_13_1.duration_ = 4.67

		local var_13_0 = {
			ja = 4.666,
			ko = 1.8,
			en = 2.933
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
				arg_13_0:Play106601004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1066ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1066ui_story == nil then
				arg_13_1.var_.characterEffect1066ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.1

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1066ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1066ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1066ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1066ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.175

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_8 = arg_13_1:FormatText(StoryNameCfg[137].name)

				arg_13_1.leftNameTxt_.text = var_16_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_9 = arg_13_1:GetWordFromCfg(106601003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 7
				local var_16_12 = utf8.len(var_16_10)
				local var_16_13 = var_16_11 <= 0 and var_16_7 or var_16_7 * (var_16_12 / var_16_11)

				if var_16_13 > 0 and var_16_7 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601003", "story_v_side_old_106601.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601003", "story_v_side_old_106601.awb") / 1000

					if var_16_14 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_6
					end

					if var_16_9.prefab_name ~= "" and arg_13_1.actors_[var_16_9.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_9.prefab_name].transform, "story_v_side_old_106601", "106601003", "story_v_side_old_106601.awb")

						arg_13_1:RecordAudio("106601003", var_16_15)
						arg_13_1:RecordAudio("106601003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601003", "story_v_side_old_106601.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601003", "story_v_side_old_106601.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_16 and arg_13_1.time_ < var_16_6 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play106601004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 106601004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play106601005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				local var_20_2 = "play"
				local var_20_3 = "effect"

				arg_17_1:AudioAction(var_20_2, var_20_3, "se_story_side_1066", "se_story_1066_Metal", "")
			end

			local var_20_4 = 0
			local var_20_5 = 0.175

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(106601004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_8 = 7
				local var_20_9 = utf8.len(var_20_7)
				local var_20_10 = var_20_8 <= 0 and var_20_5 or var_20_5 * (var_20_9 / var_20_8)

				if var_20_10 > 0 and var_20_5 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_11 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_11 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_11

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_11 and arg_17_1.time_ < var_20_4 + var_20_11 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play106601005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 106601005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play106601006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.675

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(106601005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 27
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play106601006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 106601006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play106601007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.3

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(106601006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 12
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play106601007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 106601007
		arg_29_1.duration_ = 5.7

		local var_29_0 = {
			ja = 2.733,
			ko = 5.7,
			en = 5.7
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
				arg_29_0:Play106601008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1066ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1066ui_story == nil then
				arg_29_1.var_.characterEffect1066ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.1

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1066ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1066ui_story then
				arg_29_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action443")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_32_6 = 0
			local var_32_7 = 0.55

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[32].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(106601007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 22
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601007", "story_v_side_old_106601.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601007", "story_v_side_old_106601.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_side_old_106601", "106601007", "story_v_side_old_106601.awb")

						arg_29_1:RecordAudio("106601007", var_32_15)
						arg_29_1:RecordAudio("106601007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601007", "story_v_side_old_106601.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601007", "story_v_side_old_106601.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_16 and arg_29_1.time_ < var_32_6 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play106601008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 106601008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play106601009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.825

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

				local var_36_2 = arg_33_1:GetWordFromCfg(106601008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 33
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
	Play106601009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 106601009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play106601010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1066ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1066ui_story == nil then
				arg_37_1.var_.characterEffect1066ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.1

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1066ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1066ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1066ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1066ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.675

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

				local var_40_9 = arg_37_1:GetWordFromCfg(106601009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 27
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
	Play106601010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 106601010
		arg_41_1.duration_ = 5.1

		local var_41_0 = {
			ja = 4.2,
			ko = 4.4,
			en = 5.1
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
				arg_41_0:Play106601011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1066ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1066ui_story == nil then
				arg_41_1.var_.characterEffect1066ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.1

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1066ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1066ui_story then
				arg_41_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_44_6 = 0
			local var_44_7 = 0.35

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[32].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(106601010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601010", "story_v_side_old_106601.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601010", "story_v_side_old_106601.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_side_old_106601", "106601010", "story_v_side_old_106601.awb")

						arg_41_1:RecordAudio("106601010", var_44_15)
						arg_41_1:RecordAudio("106601010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601010", "story_v_side_old_106601.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601010", "story_v_side_old_106601.awb")
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
	Play106601011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 106601011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play106601012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.725

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(106601011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 29
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play106601012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 106601012
		arg_49_1.duration_ = 0.1

		SetActive(arg_49_1.tipsGo_, true)

		arg_49_1.tipsText_.text = StoryTipsCfg[106601].name

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"

			SetActive(arg_49_1.choicesGo_, true)

			for iter_50_0, iter_50_1 in ipairs(arg_49_1.choices_) do
				local var_50_0 = iter_50_0 <= 2

				SetActive(iter_50_1.go, var_50_0)
			end

			arg_49_1.choices_[1].txt.text = arg_49_1:FormatText(StoryChoiceCfg[78].name)
			arg_49_1.choices_[2].txt.text = arg_49_1:FormatText(StoryChoiceCfg[79].name)
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				PlayerAction.UseStoryTrigger(1066011, 210660101, 106601012, 1)
				arg_49_0:Play106601013(arg_49_1)
			end

			if arg_51_0 == 2 then
				arg_49_0:Play106601015(arg_49_1)
			end

			arg_49_1:RecordChoiceLog(106601012, 78, 79)
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1066ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1066ui_story == nil then
				arg_49_1.var_.characterEffect1066ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.1

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1066ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1066ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1066ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1066ui_story.fillRatio = var_52_5
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play106601013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 106601013
		arg_53_1.duration_ = 2

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play106601014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1066ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1066ui_story == nil then
				arg_53_1.var_.characterEffect1066ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.1

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1066ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1066ui_story then
				arg_53_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_56_4 = 0

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action424")
			end

			local var_56_5 = 0
			local var_56_6 = 0.05

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_7 = arg_53_1:FormatText(StoryNameCfg[32].name)

				arg_53_1.leftNameTxt_.text = var_56_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(106601013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 2
				local var_56_11 = utf8.len(var_56_9)
				local var_56_12 = var_56_10 <= 0 and var_56_6 or var_56_6 * (var_56_11 / var_56_10)

				if var_56_12 > 0 and var_56_6 < var_56_12 then
					arg_53_1.talkMaxDuration = var_56_12

					if var_56_12 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601013", "story_v_side_old_106601.awb") ~= 0 then
					local var_56_13 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601013", "story_v_side_old_106601.awb") / 1000

					if var_56_13 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_5
					end

					if var_56_8.prefab_name ~= "" and arg_53_1.actors_[var_56_8.prefab_name] ~= nil then
						local var_56_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_8.prefab_name].transform, "story_v_side_old_106601", "106601013", "story_v_side_old_106601.awb")

						arg_53_1:RecordAudio("106601013", var_56_14)
						arg_53_1:RecordAudio("106601013", var_56_14)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601013", "story_v_side_old_106601.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601013", "story_v_side_old_106601.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_15 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_15 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_15

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_15 and arg_53_1.time_ < var_56_5 + var_56_15 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play106601014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 106601014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play106601016(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1066ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1066ui_story == nil then
				arg_57_1.var_.characterEffect1066ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.1

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1066ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1066ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1066ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1066ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.35

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_9 = arg_57_1:GetWordFromCfg(106601014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 14
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
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play106601016 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 106601016
		arg_61_1.duration_ = 5.23

		local var_61_0 = {
			ja = 4.433,
			ko = 5.233,
			en = 3.933
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
				arg_61_0:Play106601017(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_64_1 = 0
			local var_64_2 = 0.65

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_3 = arg_61_1:FormatText(StoryNameCfg[32].name)

				arg_61_1.leftNameTxt_.text = var_64_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(106601016)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 26
				local var_64_7 = utf8.len(var_64_5)
				local var_64_8 = var_64_6 <= 0 and var_64_2 or var_64_2 * (var_64_7 / var_64_6)

				if var_64_8 > 0 and var_64_2 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8

					if var_64_8 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601016", "story_v_side_old_106601.awb") ~= 0 then
					local var_64_9 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601016", "story_v_side_old_106601.awb") / 1000

					if var_64_9 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_1
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_side_old_106601", "106601016", "story_v_side_old_106601.awb")

						arg_61_1:RecordAudio("106601016", var_64_10)
						arg_61_1:RecordAudio("106601016", var_64_10)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601016", "story_v_side_old_106601.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601016", "story_v_side_old_106601.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_11 and arg_61_1.time_ < var_64_1 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play106601017 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 106601017
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play106601018(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1066ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1066ui_story == nil then
				arg_65_1.var_.characterEffect1066ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.1

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1066ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1066ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1066ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1066ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 0.125

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(106601017)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 5
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play106601018 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 106601018
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play106601019(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1066ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1066ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(30, -0.82, -5.5)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1066ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(30, -0.82, -5.5)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = 0
			local var_72_10 = 1.7

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_11 = arg_69_1:GetWordFromCfg(106601018)
				local var_72_12 = arg_69_1:FormatText(var_72_11.content)

				arg_69_1.text_.text = var_72_12

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 69
				local var_72_14 = utf8.len(var_72_12)
				local var_72_15 = var_72_13 <= 0 and var_72_10 or var_72_10 * (var_72_14 / var_72_13)

				if var_72_15 > 0 and var_72_10 < var_72_15 then
					arg_69_1.talkMaxDuration = var_72_15

					if var_72_15 + var_72_9 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_15 + var_72_9
					end
				end

				arg_69_1.text_.text = var_72_12
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_10, arg_69_1.talkMaxDuration)

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_9) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_9 + var_72_16 and arg_69_1.time_ < var_72_9 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play106601019 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 106601019
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play106601020(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.8

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(106601019)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 32
				local var_76_5 = utf8.len(var_76_3)
				local var_76_6 = var_76_4 <= 0 and var_76_1 or var_76_1 * (var_76_5 / var_76_4)

				if var_76_6 > 0 and var_76_1 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_7 and arg_73_1.time_ < var_76_0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play106601020 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 106601020
		arg_77_1.duration_ = 10.7

		local var_77_0 = {
			ja = 10.333,
			ko = 10.7,
			en = 9.033
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
				arg_77_0:Play106601021(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1066ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1066ui_story == nil then
				arg_77_1.var_.characterEffect1066ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.1

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1066ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1066ui_story then
				arg_77_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_80_4 = arg_77_1.bgs_.B10d.transform
			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.var_.moveOldPosB10d = var_80_4.localPosition
			end

			local var_80_6 = 0.001

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 then
				local var_80_7 = (arg_77_1.time_ - var_80_5) / var_80_6
				local var_80_8 = Vector3.New(0, -100, 10)

				var_80_4.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPosB10d, var_80_8, var_80_7)
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 then
				var_80_4.localPosition = Vector3.New(0, -100, 10)
			end

			local var_80_9 = "A00"

			if arg_77_1.bgs_[var_80_9] == nil then
				local var_80_10 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_80_9)
				var_80_10.name = var_80_9
				var_80_10.transform.parent = arg_77_1.stage_.transform
				var_80_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_[var_80_9] = var_80_10
			end

			local var_80_11 = 0

			if var_80_11 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				local var_80_12 = manager.ui.mainCamera.transform.localPosition
				local var_80_13 = Vector3.New(0, 0, 10) + Vector3.New(var_80_12.x, var_80_12.y, 0)
				local var_80_14 = arg_77_1.bgs_.A00

				var_80_14.transform.localPosition = var_80_13
				var_80_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_15 = var_80_14:GetComponent("SpriteRenderer")

				if var_80_15 and var_80_15.sprite then
					local var_80_16 = (var_80_14.transform.localPosition - var_80_12).z
					local var_80_17 = manager.ui.mainCameraCom_
					local var_80_18 = 2 * var_80_16 * Mathf.Tan(var_80_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_19 = var_80_18 * var_80_17.aspect
					local var_80_20 = var_80_15.sprite.bounds.size.x
					local var_80_21 = var_80_15.sprite.bounds.size.y
					local var_80_22 = var_80_19 / var_80_20
					local var_80_23 = var_80_18 / var_80_21
					local var_80_24 = var_80_23 < var_80_22 and var_80_22 or var_80_23

					var_80_14.transform.localScale = Vector3.New(var_80_24, var_80_24, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "A00" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_25 = arg_77_1.actors_["1066ui_story"].transform
			local var_80_26 = 0

			if var_80_26 < arg_77_1.time_ and arg_77_1.time_ <= var_80_26 + arg_80_0 then
				arg_77_1.var_.moveOldPos1066ui_story = var_80_25.localPosition
			end

			local var_80_27 = 0.001

			if var_80_26 <= arg_77_1.time_ and arg_77_1.time_ < var_80_26 + var_80_27 then
				local var_80_28 = (arg_77_1.time_ - var_80_26) / var_80_27
				local var_80_29 = Vector3.New(0, -0.82, -5.5)

				var_80_25.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1066ui_story, var_80_29, var_80_28)

				local var_80_30 = manager.ui.mainCamera.transform.position - var_80_25.position

				var_80_25.forward = Vector3.New(var_80_30.x, var_80_30.y, var_80_30.z)

				local var_80_31 = var_80_25.localEulerAngles

				var_80_31.z = 0
				var_80_31.x = 0
				var_80_25.localEulerAngles = var_80_31
			end

			if arg_77_1.time_ >= var_80_26 + var_80_27 and arg_77_1.time_ < var_80_26 + var_80_27 + arg_80_0 then
				var_80_25.localPosition = Vector3.New(0, -0.82, -5.5)

				local var_80_32 = manager.ui.mainCamera.transform.position - var_80_25.position

				var_80_25.forward = Vector3.New(var_80_32.x, var_80_32.y, var_80_32.z)

				local var_80_33 = var_80_25.localEulerAngles

				var_80_33.z = 0
				var_80_33.x = 0
				var_80_25.localEulerAngles = var_80_33
			end

			local var_80_34 = 0

			if var_80_34 < arg_77_1.time_ and arg_77_1.time_ <= var_80_34 + arg_80_0 then
				arg_77_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_80_35 = 0

			if var_80_35 < arg_77_1.time_ and arg_77_1.time_ <= var_80_35 + arg_80_0 then
				arg_77_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_80_36 = 0
			local var_80_37 = 1.1

			if var_80_36 < arg_77_1.time_ and arg_77_1.time_ <= var_80_36 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_38 = arg_77_1:FormatText(StoryNameCfg[32].name)

				arg_77_1.leftNameTxt_.text = var_80_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_39 = arg_77_1:GetWordFromCfg(106601020)
				local var_80_40 = arg_77_1:FormatText(var_80_39.content)

				arg_77_1.text_.text = var_80_40

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_41 = 44
				local var_80_42 = utf8.len(var_80_40)
				local var_80_43 = var_80_41 <= 0 and var_80_37 or var_80_37 * (var_80_42 / var_80_41)

				if var_80_43 > 0 and var_80_37 < var_80_43 then
					arg_77_1.talkMaxDuration = var_80_43

					if var_80_43 + var_80_36 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_43 + var_80_36
					end
				end

				arg_77_1.text_.text = var_80_40
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601020", "story_v_side_old_106601.awb") ~= 0 then
					local var_80_44 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601020", "story_v_side_old_106601.awb") / 1000

					if var_80_44 + var_80_36 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_44 + var_80_36
					end

					if var_80_39.prefab_name ~= "" and arg_77_1.actors_[var_80_39.prefab_name] ~= nil then
						local var_80_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_39.prefab_name].transform, "story_v_side_old_106601", "106601020", "story_v_side_old_106601.awb")

						arg_77_1:RecordAudio("106601020", var_80_45)
						arg_77_1:RecordAudio("106601020", var_80_45)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601020", "story_v_side_old_106601.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601020", "story_v_side_old_106601.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_46 = math.max(var_80_37, arg_77_1.talkMaxDuration)

			if var_80_36 <= arg_77_1.time_ and arg_77_1.time_ < var_80_36 + var_80_46 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_36) / var_80_46

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_36 + var_80_46 and arg_77_1.time_ < var_80_36 + var_80_46 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B10d",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play106601021 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 106601021
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play106601022(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1066ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1066ui_story == nil then
				arg_81_1.var_.characterEffect1066ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.1

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1066ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1066ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1066ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1066ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.45

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_9 = arg_81_1:GetWordFromCfg(106601021)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 18
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play106601022 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 106601022
		arg_85_1.duration_ = 6.67

		local var_85_0 = {
			ja = 6.166,
			ko = 6.666,
			en = 4.733
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
				arg_85_0:Play106601023(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1066ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1066ui_story == nil then
				arg_85_1.var_.characterEffect1066ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.1

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1066ui_story and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1066ui_story then
				arg_85_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_88_4 = 0

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_88_5 = 0
			local var_88_6 = 0.825

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_7 = arg_85_1:FormatText(StoryNameCfg[32].name)

				arg_85_1.leftNameTxt_.text = var_88_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(106601022)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 33
				local var_88_11 = utf8.len(var_88_9)
				local var_88_12 = var_88_10 <= 0 and var_88_6 or var_88_6 * (var_88_11 / var_88_10)

				if var_88_12 > 0 and var_88_6 < var_88_12 then
					arg_85_1.talkMaxDuration = var_88_12

					if var_88_12 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601022", "story_v_side_old_106601.awb") ~= 0 then
					local var_88_13 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601022", "story_v_side_old_106601.awb") / 1000

					if var_88_13 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_5
					end

					if var_88_8.prefab_name ~= "" and arg_85_1.actors_[var_88_8.prefab_name] ~= nil then
						local var_88_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_8.prefab_name].transform, "story_v_side_old_106601", "106601022", "story_v_side_old_106601.awb")

						arg_85_1:RecordAudio("106601022", var_88_14)
						arg_85_1:RecordAudio("106601022", var_88_14)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601022", "story_v_side_old_106601.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601022", "story_v_side_old_106601.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_15 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_15 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_15

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_15 and arg_85_1.time_ < var_88_5 + var_88_15 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play106601023 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 106601023
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play106601024(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1066ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1066ui_story == nil then
				arg_89_1.var_.characterEffect1066ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.1

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1066ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1066ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1066ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1066ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.375

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_8 = arg_89_1:FormatText(StoryNameCfg[7].name)

				arg_89_1.leftNameTxt_.text = var_92_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_9 = arg_89_1:GetWordFromCfg(106601023)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 15
				local var_92_12 = utf8.len(var_92_10)
				local var_92_13 = var_92_11 <= 0 and var_92_7 or var_92_7 * (var_92_12 / var_92_11)

				if var_92_13 > 0 and var_92_7 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_10
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play106601024 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 106601024
		arg_93_1.duration_ = 10.17

		local var_93_0 = {
			ja = 5.566,
			ko = 10.166,
			en = 7.9
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
				arg_93_0:Play106601025(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1066ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1066ui_story == nil then
				arg_93_1.var_.characterEffect1066ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.1

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1066ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1066ui_story then
				arg_93_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_96_4 = 0

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action426")
			end

			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_96_6 = 0
			local var_96_7 = 0.975

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[32].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_9 = arg_93_1:GetWordFromCfg(106601024)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 39
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601024", "story_v_side_old_106601.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601024", "story_v_side_old_106601.awb") / 1000

					if var_96_14 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_6
					end

					if var_96_9.prefab_name ~= "" and arg_93_1.actors_[var_96_9.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_9.prefab_name].transform, "story_v_side_old_106601", "106601024", "story_v_side_old_106601.awb")

						arg_93_1:RecordAudio("106601024", var_96_15)
						arg_93_1:RecordAudio("106601024", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601024", "story_v_side_old_106601.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601024", "story_v_side_old_106601.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_16 and arg_93_1.time_ < var_96_6 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play106601025 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 106601025
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play106601026(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1066ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1066ui_story == nil then
				arg_97_1.var_.characterEffect1066ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.1

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1066ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1066ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1066ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1066ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.8

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_9 = arg_97_1:GetWordFromCfg(106601025)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 32
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play106601026 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 106601026
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play106601027(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.1

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(106601026)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 44
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play106601027 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 106601027
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play106601028(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.675

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(106601027)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 27
				local var_108_5 = utf8.len(var_108_3)
				local var_108_6 = var_108_4 <= 0 and var_108_1 or var_108_1 * (var_108_5 / var_108_4)

				if var_108_6 > 0 and var_108_1 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_7 and arg_105_1.time_ < var_108_0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play106601028 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 106601028
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play106601029(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.525

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(106601028)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 21
				local var_112_5 = utf8.len(var_112_3)
				local var_112_6 = var_112_4 <= 0 and var_112_1 or var_112_1 * (var_112_5 / var_112_4)

				if var_112_6 > 0 and var_112_1 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_7 and arg_109_1.time_ < var_112_0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play106601029 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 106601029
		arg_113_1.duration_ = 5.9

		local var_113_0 = {
			ja = 5.9,
			ko = 4.366,
			en = 4.566
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
				arg_113_0:Play106601030(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1066ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1066ui_story == nil then
				arg_113_1.var_.characterEffect1066ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.1

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1066ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1066ui_story then
				arg_113_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_116_4 = 0

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action463")
			end

			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_116_6 = 0
			local var_116_7 = 0.55

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[32].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_9 = arg_113_1:GetWordFromCfg(106601029)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 22
				local var_116_12 = utf8.len(var_116_10)
				local var_116_13 = var_116_11 <= 0 and var_116_7 or var_116_7 * (var_116_12 / var_116_11)

				if var_116_13 > 0 and var_116_7 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601029", "story_v_side_old_106601.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601029", "story_v_side_old_106601.awb") / 1000

					if var_116_14 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_6
					end

					if var_116_9.prefab_name ~= "" and arg_113_1.actors_[var_116_9.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_9.prefab_name].transform, "story_v_side_old_106601", "106601029", "story_v_side_old_106601.awb")

						arg_113_1:RecordAudio("106601029", var_116_15)
						arg_113_1:RecordAudio("106601029", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601029", "story_v_side_old_106601.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601029", "story_v_side_old_106601.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_16 and arg_113_1.time_ < var_116_6 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play106601030 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 106601030
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play106601031(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1066ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1066ui_story == nil then
				arg_117_1.var_.characterEffect1066ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.1

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1066ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1066ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1066ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1066ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.55

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_8 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_9 = arg_117_1:GetWordFromCfg(106601030)
				local var_120_10 = arg_117_1:FormatText(var_120_9.content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 22
				local var_120_12 = utf8.len(var_120_10)
				local var_120_13 = var_120_11 <= 0 and var_120_7 or var_120_7 * (var_120_12 / var_120_11)

				if var_120_13 > 0 and var_120_7 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play106601031 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 106601031
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play106601032(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.675

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:GetWordFromCfg(106601031)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 27
				local var_124_5 = utf8.len(var_124_3)
				local var_124_6 = var_124_4 <= 0 and var_124_1 or var_124_1 * (var_124_5 / var_124_4)

				if var_124_6 > 0 and var_124_1 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_7 and arg_121_1.time_ < var_124_0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play106601032 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 106601032
		arg_125_1.duration_ = 4.27

		local var_125_0 = {
			ja = 4.1,
			ko = 4.266,
			en = 2.8
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
				arg_125_0:Play106601033(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1066ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1066ui_story == nil then
				arg_125_1.var_.characterEffect1066ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.1

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1066ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1066ui_story then
				arg_125_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_128_4 = 0

			if var_128_4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_128_6 = 0
			local var_128_7 = 0.4

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_8 = arg_125_1:FormatText(StoryNameCfg[32].name)

				arg_125_1.leftNameTxt_.text = var_128_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_9 = arg_125_1:GetWordFromCfg(106601032)
				local var_128_10 = arg_125_1:FormatText(var_128_9.content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 16
				local var_128_12 = utf8.len(var_128_10)
				local var_128_13 = var_128_11 <= 0 and var_128_7 or var_128_7 * (var_128_12 / var_128_11)

				if var_128_13 > 0 and var_128_7 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601032", "story_v_side_old_106601.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601032", "story_v_side_old_106601.awb") / 1000

					if var_128_14 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_6
					end

					if var_128_9.prefab_name ~= "" and arg_125_1.actors_[var_128_9.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_9.prefab_name].transform, "story_v_side_old_106601", "106601032", "story_v_side_old_106601.awb")

						arg_125_1:RecordAudio("106601032", var_128_15)
						arg_125_1:RecordAudio("106601032", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601032", "story_v_side_old_106601.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601032", "story_v_side_old_106601.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_16 and arg_125_1.time_ < var_128_6 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play106601033 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 106601033
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play106601034(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1066ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1066ui_story == nil then
				arg_129_1.var_.characterEffect1066ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.1

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1066ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1066ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1066ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1066ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.175

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_8 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_9 = arg_129_1:GetWordFromCfg(106601033)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 7
				local var_132_12 = utf8.len(var_132_10)
				local var_132_13 = var_132_11 <= 0 and var_132_7 or var_132_7 * (var_132_12 / var_132_11)

				if var_132_13 > 0 and var_132_7 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play106601034 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 106601034
		arg_133_1.duration_ = 5.17

		local var_133_0 = {
			ja = 4.533,
			ko = 3.3,
			en = 5.166
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
				arg_133_0:Play106601035(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.45

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[44].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(106601034)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 18
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601034", "story_v_side_old_106601.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601034", "story_v_side_old_106601.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_side_old_106601", "106601034", "story_v_side_old_106601.awb")

						arg_133_1:RecordAudio("106601034", var_136_9)
						arg_133_1:RecordAudio("106601034", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601034", "story_v_side_old_106601.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601034", "story_v_side_old_106601.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play106601035 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 106601035
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play106601036(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.225

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(106601035)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 9
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play106601036 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 106601036
		arg_141_1.duration_ = 3.7

		local var_141_0 = {
			ja = 3.7,
			ko = 2.2,
			en = 2.433
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play106601037(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1066ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1066ui_story == nil then
				arg_141_1.var_.characterEffect1066ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.1

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1066ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1066ui_story then
				arg_141_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action424")
			end

			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_144_6 = 0
			local var_144_7 = 0.15

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_8 = arg_141_1:FormatText(StoryNameCfg[32].name)

				arg_141_1.leftNameTxt_.text = var_144_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:GetWordFromCfg(106601036)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 6
				local var_144_12 = utf8.len(var_144_10)
				local var_144_13 = var_144_11 <= 0 and var_144_7 or var_144_7 * (var_144_12 / var_144_11)

				if var_144_13 > 0 and var_144_7 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601036", "story_v_side_old_106601.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601036", "story_v_side_old_106601.awb") / 1000

					if var_144_14 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_6
					end

					if var_144_9.prefab_name ~= "" and arg_141_1.actors_[var_144_9.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_9.prefab_name].transform, "story_v_side_old_106601", "106601036", "story_v_side_old_106601.awb")

						arg_141_1:RecordAudio("106601036", var_144_15)
						arg_141_1:RecordAudio("106601036", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601036", "story_v_side_old_106601.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601036", "story_v_side_old_106601.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_16 and arg_141_1.time_ < var_144_6 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play106601037 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 106601037
		arg_145_1.duration_ = 5.43

		local var_145_0 = {
			ja = 4.266,
			ko = 4.866,
			en = 5.433
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play106601038(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action445")
			end

			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_148_2 = 0
			local var_148_3 = 0.575

			if var_148_2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_4 = arg_145_1:FormatText(StoryNameCfg[32].name)

				arg_145_1.leftNameTxt_.text = var_148_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_5 = arg_145_1:GetWordFromCfg(106601037)
				local var_148_6 = arg_145_1:FormatText(var_148_5.content)

				arg_145_1.text_.text = var_148_6

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 23
				local var_148_8 = utf8.len(var_148_6)
				local var_148_9 = var_148_7 <= 0 and var_148_3 or var_148_3 * (var_148_8 / var_148_7)

				if var_148_9 > 0 and var_148_3 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_6
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601037", "story_v_side_old_106601.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601037", "story_v_side_old_106601.awb") / 1000

					if var_148_10 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_2
					end

					if var_148_5.prefab_name ~= "" and arg_145_1.actors_[var_148_5.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_5.prefab_name].transform, "story_v_side_old_106601", "106601037", "story_v_side_old_106601.awb")

						arg_145_1:RecordAudio("106601037", var_148_11)
						arg_145_1:RecordAudio("106601037", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601037", "story_v_side_old_106601.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601037", "story_v_side_old_106601.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_12 and arg_145_1.time_ < var_148_2 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play106601038 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 106601038
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play106601039(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1066ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1066ui_story == nil then
				arg_149_1.var_.characterEffect1066ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.1

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1066ui_story and not isNil(var_152_0) then
					local var_152_4 = Mathf.Lerp(0, 0.5, var_152_3)

					arg_149_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1066ui_story.fillRatio = var_152_4
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1066ui_story then
				local var_152_5 = 0.5

				arg_149_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1066ui_story.fillRatio = var_152_5
			end

			local var_152_6 = 0
			local var_152_7 = 0.35

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_8 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_9 = arg_149_1:GetWordFromCfg(106601038)
				local var_152_10 = arg_149_1:FormatText(var_152_9.content)

				arg_149_1.text_.text = var_152_10

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 14
				local var_152_12 = utf8.len(var_152_10)
				local var_152_13 = var_152_11 <= 0 and var_152_7 or var_152_7 * (var_152_12 / var_152_11)

				if var_152_13 > 0 and var_152_7 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_10
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play106601039 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 106601039
		arg_153_1.duration_ = 2

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play106601040(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1066ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1066ui_story == nil then
				arg_153_1.var_.characterEffect1066ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.1

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1066ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1066ui_story then
				arg_153_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_156_4 = 0

			if var_156_4 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action454")
			end

			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_156_6 = 0
			local var_156_7 = 0.1

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_8 = arg_153_1:FormatText(StoryNameCfg[32].name)

				arg_153_1.leftNameTxt_.text = var_156_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_9 = arg_153_1:GetWordFromCfg(106601039)
				local var_156_10 = arg_153_1:FormatText(var_156_9.content)

				arg_153_1.text_.text = var_156_10

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 4
				local var_156_12 = utf8.len(var_156_10)
				local var_156_13 = var_156_11 <= 0 and var_156_7 or var_156_7 * (var_156_12 / var_156_11)

				if var_156_13 > 0 and var_156_7 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_10
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601039", "story_v_side_old_106601.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601039", "story_v_side_old_106601.awb") / 1000

					if var_156_14 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_6
					end

					if var_156_9.prefab_name ~= "" and arg_153_1.actors_[var_156_9.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_9.prefab_name].transform, "story_v_side_old_106601", "106601039", "story_v_side_old_106601.awb")

						arg_153_1:RecordAudio("106601039", var_156_15)
						arg_153_1:RecordAudio("106601039", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601039", "story_v_side_old_106601.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601039", "story_v_side_old_106601.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_16 and arg_153_1.time_ < var_156_6 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play106601040 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 106601040
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play106601041(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.9

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(106601040)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 36
				local var_160_5 = utf8.len(var_160_3)
				local var_160_6 = var_160_4 <= 0 and var_160_1 or var_160_1 * (var_160_5 / var_160_4)

				if var_160_6 > 0 and var_160_1 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_7 and arg_157_1.time_ < var_160_0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play106601041 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 106601041
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play106601042(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1066ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1066ui_story == nil then
				arg_161_1.var_.characterEffect1066ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.1

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1066ui_story and not isNil(var_164_0) then
					local var_164_4 = Mathf.Lerp(0, 0.5, var_164_3)

					arg_161_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1066ui_story.fillRatio = var_164_4
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1066ui_story then
				local var_164_5 = 0.5

				arg_161_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1066ui_story.fillRatio = var_164_5
			end

			local var_164_6 = 0
			local var_164_7 = 0.15

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_8 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_9 = arg_161_1:GetWordFromCfg(106601041)
				local var_164_10 = arg_161_1:FormatText(var_164_9.content)

				arg_161_1.text_.text = var_164_10

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 6
				local var_164_12 = utf8.len(var_164_10)
				local var_164_13 = var_164_11 <= 0 and var_164_7 or var_164_7 * (var_164_12 / var_164_11)

				if var_164_13 > 0 and var_164_7 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_10
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_14 and arg_161_1.time_ < var_164_6 + var_164_14 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play106601042 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 106601042
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play106601043(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.575

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[7].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(106601042)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 23
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_8 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_8 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_8

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_8 and arg_165_1.time_ < var_168_0 + var_168_8 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play106601043 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 106601043
		arg_169_1.duration_ = 2

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play106601044(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1066ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1066ui_story == nil then
				arg_169_1.var_.characterEffect1066ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.1

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1066ui_story and not isNil(var_172_0) then
					arg_169_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1066ui_story then
				arg_169_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_172_4 = 0

			if var_172_4 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action443")
			end

			local var_172_5 = 0

			if var_172_5 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_172_6 = 0
			local var_172_7 = 0.1

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_8 = arg_169_1:FormatText(StoryNameCfg[32].name)

				arg_169_1.leftNameTxt_.text = var_172_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_9 = arg_169_1:GetWordFromCfg(106601043)
				local var_172_10 = arg_169_1:FormatText(var_172_9.content)

				arg_169_1.text_.text = var_172_10

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 4
				local var_172_12 = utf8.len(var_172_10)
				local var_172_13 = var_172_11 <= 0 and var_172_7 or var_172_7 * (var_172_12 / var_172_11)

				if var_172_13 > 0 and var_172_7 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_10
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601043", "story_v_side_old_106601.awb") ~= 0 then
					local var_172_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601043", "story_v_side_old_106601.awb") / 1000

					if var_172_14 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_6
					end

					if var_172_9.prefab_name ~= "" and arg_169_1.actors_[var_172_9.prefab_name] ~= nil then
						local var_172_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_9.prefab_name].transform, "story_v_side_old_106601", "106601043", "story_v_side_old_106601.awb")

						arg_169_1:RecordAudio("106601043", var_172_15)
						arg_169_1:RecordAudio("106601043", var_172_15)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601043", "story_v_side_old_106601.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601043", "story_v_side_old_106601.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_16 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_16

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_16 and arg_169_1.time_ < var_172_6 + var_172_16 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play106601044 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 106601044
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play106601045(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1066ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1066ui_story == nil then
				arg_173_1.var_.characterEffect1066ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.1

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1066ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1066ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1066ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1066ui_story.fillRatio = var_176_5
			end

			local var_176_6 = 0
			local var_176_7 = 0.975

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_8 = arg_173_1:FormatText(StoryNameCfg[7].name)

				arg_173_1.leftNameTxt_.text = var_176_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_9 = arg_173_1:GetWordFromCfg(106601044)
				local var_176_10 = arg_173_1:FormatText(var_176_9.content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 39
				local var_176_12 = utf8.len(var_176_10)
				local var_176_13 = var_176_11 <= 0 and var_176_7 or var_176_7 * (var_176_12 / var_176_11)

				if var_176_13 > 0 and var_176_7 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play106601045 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 106601045
		arg_177_1.duration_ = 8.9

		local var_177_0 = {
			ja = 3.766,
			ko = 5.3,
			en = 8.9
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play106601046(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1066ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1066ui_story == nil then
				arg_177_1.var_.characterEffect1066ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.1

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1066ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1066ui_story then
				arg_177_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_180_4 = 0

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_180_6 = 0
			local var_180_7 = 0.525

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_8 = arg_177_1:FormatText(StoryNameCfg[32].name)

				arg_177_1.leftNameTxt_.text = var_180_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_9 = arg_177_1:GetWordFromCfg(106601045)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 21
				local var_180_12 = utf8.len(var_180_10)
				local var_180_13 = var_180_11 <= 0 and var_180_7 or var_180_7 * (var_180_12 / var_180_11)

				if var_180_13 > 0 and var_180_7 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601045", "story_v_side_old_106601.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601045", "story_v_side_old_106601.awb") / 1000

					if var_180_14 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_6
					end

					if var_180_9.prefab_name ~= "" and arg_177_1.actors_[var_180_9.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_9.prefab_name].transform, "story_v_side_old_106601", "106601045", "story_v_side_old_106601.awb")

						arg_177_1:RecordAudio("106601045", var_180_15)
						arg_177_1:RecordAudio("106601045", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601045", "story_v_side_old_106601.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601045", "story_v_side_old_106601.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_16 and arg_177_1.time_ < var_180_6 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play106601046 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 106601046
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play106601047(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1066ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1066ui_story == nil then
				arg_181_1.var_.characterEffect1066ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.1

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1066ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1066ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1066ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1066ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.25

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_9 = arg_181_1:GetWordFromCfg(106601046)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 10
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play106601047 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 106601047
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play106601048(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(106601047)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 40
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play106601048 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 106601048
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play106601049(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 1.05

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(106601048)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 42
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_8 and arg_189_1.time_ < var_192_0 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play106601049 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 106601049
		arg_193_1.duration_ = 3.27

		local var_193_0 = {
			ja = 3.266,
			ko = 2.3,
			en = 3.1
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play106601050(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1066ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1066ui_story == nil then
				arg_193_1.var_.characterEffect1066ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.1

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1066ui_story and not isNil(var_196_0) then
					arg_193_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1066ui_story then
				arg_193_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_196_4 = 0

			if var_196_4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action424")
			end

			local var_196_5 = 0

			if var_196_5 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_196_6 = 0
			local var_196_7 = 0.275

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_8 = arg_193_1:FormatText(StoryNameCfg[32].name)

				arg_193_1.leftNameTxt_.text = var_196_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_9 = arg_193_1:GetWordFromCfg(106601049)
				local var_196_10 = arg_193_1:FormatText(var_196_9.content)

				arg_193_1.text_.text = var_196_10

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 11
				local var_196_12 = utf8.len(var_196_10)
				local var_196_13 = var_196_11 <= 0 and var_196_7 or var_196_7 * (var_196_12 / var_196_11)

				if var_196_13 > 0 and var_196_7 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_10
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601049", "story_v_side_old_106601.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601049", "story_v_side_old_106601.awb") / 1000

					if var_196_14 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_6
					end

					if var_196_9.prefab_name ~= "" and arg_193_1.actors_[var_196_9.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_9.prefab_name].transform, "story_v_side_old_106601", "106601049", "story_v_side_old_106601.awb")

						arg_193_1:RecordAudio("106601049", var_196_15)
						arg_193_1:RecordAudio("106601049", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601049", "story_v_side_old_106601.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601049", "story_v_side_old_106601.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_16 and arg_193_1.time_ < var_196_6 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play106601050 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 106601050
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play106601051(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1066ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1066ui_story == nil then
				arg_197_1.var_.characterEffect1066ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.1

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1066ui_story and not isNil(var_200_0) then
					local var_200_4 = Mathf.Lerp(0, 0.5, var_200_3)

					arg_197_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1066ui_story.fillRatio = var_200_4
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1066ui_story then
				local var_200_5 = 0.5

				arg_197_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1066ui_story.fillRatio = var_200_5
			end

			local var_200_6 = 0
			local var_200_7 = 0.05

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_8 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_9 = arg_197_1:GetWordFromCfg(106601050)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 2
				local var_200_12 = utf8.len(var_200_10)
				local var_200_13 = var_200_11 <= 0 and var_200_7 or var_200_7 * (var_200_12 / var_200_11)

				if var_200_13 > 0 and var_200_7 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play106601051 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 106601051
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play106601052(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.bgs_.A00.transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPosA00 = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(0, -100, 10)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPosA00, var_204_4, var_204_3)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				local var_204_6 = manager.ui.mainCamera.transform.localPosition
				local var_204_7 = Vector3.New(0, 0, 10) + Vector3.New(var_204_6.x, var_204_6.y, 0)
				local var_204_8 = arg_201_1.bgs_.B10d

				var_204_8.transform.localPosition = var_204_7
				var_204_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_9 = var_204_8:GetComponent("SpriteRenderer")

				if var_204_9 and var_204_9.sprite then
					local var_204_10 = (var_204_8.transform.localPosition - var_204_6).z
					local var_204_11 = manager.ui.mainCameraCom_
					local var_204_12 = 2 * var_204_10 * Mathf.Tan(var_204_11.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_204_13 = var_204_12 * var_204_11.aspect
					local var_204_14 = var_204_9.sprite.bounds.size.x
					local var_204_15 = var_204_9.sprite.bounds.size.y
					local var_204_16 = var_204_13 / var_204_14
					local var_204_17 = var_204_12 / var_204_15
					local var_204_18 = var_204_17 < var_204_16 and var_204_16 or var_204_17

					var_204_8.transform.localScale = Vector3.New(var_204_18, var_204_18, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "B10d" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_19 = arg_201_1.actors_["1066ui_story"].transform
			local var_204_20 = 0

			if var_204_20 < arg_201_1.time_ and arg_201_1.time_ <= var_204_20 + arg_204_0 then
				arg_201_1.var_.moveOldPos1066ui_story = var_204_19.localPosition
			end

			local var_204_21 = 0.001

			if var_204_20 <= arg_201_1.time_ and arg_201_1.time_ < var_204_20 + var_204_21 then
				local var_204_22 = (arg_201_1.time_ - var_204_20) / var_204_21
				local var_204_23 = Vector3.New(30, -0.82, -5.5)

				var_204_19.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1066ui_story, var_204_23, var_204_22)

				local var_204_24 = manager.ui.mainCamera.transform.position - var_204_19.position

				var_204_19.forward = Vector3.New(var_204_24.x, var_204_24.y, var_204_24.z)

				local var_204_25 = var_204_19.localEulerAngles

				var_204_25.z = 0
				var_204_25.x = 0
				var_204_19.localEulerAngles = var_204_25
			end

			if arg_201_1.time_ >= var_204_20 + var_204_21 and arg_201_1.time_ < var_204_20 + var_204_21 + arg_204_0 then
				var_204_19.localPosition = Vector3.New(30, -0.82, -5.5)

				local var_204_26 = manager.ui.mainCamera.transform.position - var_204_19.position

				var_204_19.forward = Vector3.New(var_204_26.x, var_204_26.y, var_204_26.z)

				local var_204_27 = var_204_19.localEulerAngles

				var_204_27.z = 0
				var_204_27.x = 0
				var_204_19.localEulerAngles = var_204_27
			end

			local var_204_28 = 0
			local var_204_29 = 0.175

			if var_204_28 < arg_201_1.time_ and arg_201_1.time_ <= var_204_28 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_30 = arg_201_1:GetWordFromCfg(106601051)
				local var_204_31 = arg_201_1:FormatText(var_204_30.content)

				arg_201_1.text_.text = var_204_31

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_32 = 7
				local var_204_33 = utf8.len(var_204_31)
				local var_204_34 = var_204_32 <= 0 and var_204_29 or var_204_29 * (var_204_33 / var_204_32)

				if var_204_34 > 0 and var_204_29 < var_204_34 then
					arg_201_1.talkMaxDuration = var_204_34

					if var_204_34 + var_204_28 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_34 + var_204_28
					end
				end

				arg_201_1.text_.text = var_204_31
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_35 = math.max(var_204_29, arg_201_1.talkMaxDuration)

			if var_204_28 <= arg_201_1.time_ and arg_201_1.time_ < var_204_28 + var_204_35 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_28) / var_204_35

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_28 + var_204_35 and arg_201_1.time_ < var_204_28 + var_204_35 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "A00",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play106601052 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 106601052
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play106601053(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.775

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_2 = arg_205_1:GetWordFromCfg(106601052)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 31
				local var_208_5 = utf8.len(var_208_3)
				local var_208_6 = var_208_4 <= 0 and var_208_1 or var_208_1 * (var_208_5 / var_208_4)

				if var_208_6 > 0 and var_208_1 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_7 and arg_205_1.time_ < var_208_0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play106601053 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 106601053
		arg_209_1.duration_ = 5

		local var_209_0 = {
			ja = 5,
			ko = 3.666,
			en = 3.366
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play106601054(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1066ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1066ui_story == nil then
				arg_209_1.var_.characterEffect1066ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.1

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1066ui_story and not isNil(var_212_0) then
					arg_209_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1066ui_story then
				arg_209_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_212_4 = arg_209_1.actors_["1066ui_story"].transform
			local var_212_5 = 0

			if var_212_5 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.var_.moveOldPos1066ui_story = var_212_4.localPosition
			end

			local var_212_6 = 0.001

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_6 then
				local var_212_7 = (arg_209_1.time_ - var_212_5) / var_212_6
				local var_212_8 = Vector3.New(0, -0.82, -5.5)

				var_212_4.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1066ui_story, var_212_8, var_212_7)

				local var_212_9 = manager.ui.mainCamera.transform.position - var_212_4.position

				var_212_4.forward = Vector3.New(var_212_9.x, var_212_9.y, var_212_9.z)

				local var_212_10 = var_212_4.localEulerAngles

				var_212_10.z = 0
				var_212_10.x = 0
				var_212_4.localEulerAngles = var_212_10
			end

			if arg_209_1.time_ >= var_212_5 + var_212_6 and arg_209_1.time_ < var_212_5 + var_212_6 + arg_212_0 then
				var_212_4.localPosition = Vector3.New(0, -0.82, -5.5)

				local var_212_11 = manager.ui.mainCamera.transform.position - var_212_4.position

				var_212_4.forward = Vector3.New(var_212_11.x, var_212_11.y, var_212_11.z)

				local var_212_12 = var_212_4.localEulerAngles

				var_212_12.z = 0
				var_212_12.x = 0
				var_212_4.localEulerAngles = var_212_12
			end

			local var_212_13 = 0

			if var_212_13 < arg_209_1.time_ and arg_209_1.time_ <= var_212_13 + arg_212_0 then
				arg_209_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_212_14 = 0

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_212_15 = 0
			local var_212_16 = 0.525

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_17 = arg_209_1:FormatText(StoryNameCfg[32].name)

				arg_209_1.leftNameTxt_.text = var_212_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_18 = arg_209_1:GetWordFromCfg(106601053)
				local var_212_19 = arg_209_1:FormatText(var_212_18.content)

				arg_209_1.text_.text = var_212_19

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_20 = 21
				local var_212_21 = utf8.len(var_212_19)
				local var_212_22 = var_212_20 <= 0 and var_212_16 or var_212_16 * (var_212_21 / var_212_20)

				if var_212_22 > 0 and var_212_16 < var_212_22 then
					arg_209_1.talkMaxDuration = var_212_22

					if var_212_22 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_22 + var_212_15
					end
				end

				arg_209_1.text_.text = var_212_19
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601053", "story_v_side_old_106601.awb") ~= 0 then
					local var_212_23 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601053", "story_v_side_old_106601.awb") / 1000

					if var_212_23 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_23 + var_212_15
					end

					if var_212_18.prefab_name ~= "" and arg_209_1.actors_[var_212_18.prefab_name] ~= nil then
						local var_212_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_18.prefab_name].transform, "story_v_side_old_106601", "106601053", "story_v_side_old_106601.awb")

						arg_209_1:RecordAudio("106601053", var_212_24)
						arg_209_1:RecordAudio("106601053", var_212_24)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601053", "story_v_side_old_106601.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601053", "story_v_side_old_106601.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_25 = math.max(var_212_16, arg_209_1.talkMaxDuration)

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_25 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_15) / var_212_25

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_15 + var_212_25 and arg_209_1.time_ < var_212_15 + var_212_25 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play106601054 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 106601054
		arg_213_1.duration_ = 10.07

		local var_213_0 = {
			ja = 7.7,
			ko = 10.066,
			en = 9.533
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play106601055(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_216_1 = 0
			local var_216_2 = 1.075

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_3 = arg_213_1:FormatText(StoryNameCfg[32].name)

				arg_213_1.leftNameTxt_.text = var_216_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_4 = arg_213_1:GetWordFromCfg(106601054)
				local var_216_5 = arg_213_1:FormatText(var_216_4.content)

				arg_213_1.text_.text = var_216_5

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_6 = 43
				local var_216_7 = utf8.len(var_216_5)
				local var_216_8 = var_216_6 <= 0 and var_216_2 or var_216_2 * (var_216_7 / var_216_6)

				if var_216_8 > 0 and var_216_2 < var_216_8 then
					arg_213_1.talkMaxDuration = var_216_8

					if var_216_8 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_5
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601054", "story_v_side_old_106601.awb") ~= 0 then
					local var_216_9 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601054", "story_v_side_old_106601.awb") / 1000

					if var_216_9 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_1
					end

					if var_216_4.prefab_name ~= "" and arg_213_1.actors_[var_216_4.prefab_name] ~= nil then
						local var_216_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_4.prefab_name].transform, "story_v_side_old_106601", "106601054", "story_v_side_old_106601.awb")

						arg_213_1:RecordAudio("106601054", var_216_10)
						arg_213_1:RecordAudio("106601054", var_216_10)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601054", "story_v_side_old_106601.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601054", "story_v_side_old_106601.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_11 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_11 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_11

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_11 and arg_213_1.time_ < var_216_1 + var_216_11 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play106601055 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 106601055
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play106601056(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1066ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1066ui_story == nil then
				arg_217_1.var_.characterEffect1066ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.1

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1066ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1066ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1066ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1066ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 0.425

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_8 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_9 = arg_217_1:GetWordFromCfg(106601055)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 17
				local var_220_12 = utf8.len(var_220_10)
				local var_220_13 = var_220_11 <= 0 and var_220_7 or var_220_7 * (var_220_12 / var_220_11)

				if var_220_13 > 0 and var_220_7 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_10
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play106601056 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 106601056
		arg_221_1.duration_ = 3.07

		local var_221_0 = {
			ja = 3.066,
			ko = 2.8,
			en = 3
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play106601057(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1066ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1066ui_story == nil then
				arg_221_1.var_.characterEffect1066ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.1

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1066ui_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1066ui_story then
				arg_221_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_224_4 = 0

			if var_224_4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action434")
			end

			local var_224_5 = 0

			if var_224_5 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_224_6 = 0
			local var_224_7 = 0.325

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_8 = arg_221_1:FormatText(StoryNameCfg[32].name)

				arg_221_1.leftNameTxt_.text = var_224_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_9 = arg_221_1:GetWordFromCfg(106601056)
				local var_224_10 = arg_221_1:FormatText(var_224_9.content)

				arg_221_1.text_.text = var_224_10

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 13
				local var_224_12 = utf8.len(var_224_10)
				local var_224_13 = var_224_11 <= 0 and var_224_7 or var_224_7 * (var_224_12 / var_224_11)

				if var_224_13 > 0 and var_224_7 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_10
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601056", "story_v_side_old_106601.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601056", "story_v_side_old_106601.awb") / 1000

					if var_224_14 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_6
					end

					if var_224_9.prefab_name ~= "" and arg_221_1.actors_[var_224_9.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_9.prefab_name].transform, "story_v_side_old_106601", "106601056", "story_v_side_old_106601.awb")

						arg_221_1:RecordAudio("106601056", var_224_15)
						arg_221_1:RecordAudio("106601056", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601056", "story_v_side_old_106601.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601056", "story_v_side_old_106601.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_16 and arg_221_1.time_ < var_224_6 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play106601057 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 106601057
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play106601058(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1066ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1066ui_story == nil then
				arg_225_1.var_.characterEffect1066ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.1

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1066ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1066ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1066ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1066ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.15

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_9 = arg_225_1:GetWordFromCfg(106601057)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 6
				local var_228_12 = utf8.len(var_228_10)
				local var_228_13 = var_228_11 <= 0 and var_228_7 or var_228_7 * (var_228_12 / var_228_11)

				if var_228_13 > 0 and var_228_7 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play106601058 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 106601058
		arg_229_1.duration_ = 2.77

		local var_229_0 = {
			ja = 1.833,
			ko = 2.033,
			en = 2.766
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play106601059(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1066ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1066ui_story == nil then
				arg_229_1.var_.characterEffect1066ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.1

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1066ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1066ui_story then
				arg_229_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_232_4 = 0

			if var_232_4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_232_5 = 0
			local var_232_6 = 0.2

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_7 = arg_229_1:FormatText(StoryNameCfg[32].name)

				arg_229_1.leftNameTxt_.text = var_232_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_8 = arg_229_1:GetWordFromCfg(106601058)
				local var_232_9 = arg_229_1:FormatText(var_232_8.content)

				arg_229_1.text_.text = var_232_9

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_10 = 8
				local var_232_11 = utf8.len(var_232_9)
				local var_232_12 = var_232_10 <= 0 and var_232_6 or var_232_6 * (var_232_11 / var_232_10)

				if var_232_12 > 0 and var_232_6 < var_232_12 then
					arg_229_1.talkMaxDuration = var_232_12

					if var_232_12 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_12 + var_232_5
					end
				end

				arg_229_1.text_.text = var_232_9
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601058", "story_v_side_old_106601.awb") ~= 0 then
					local var_232_13 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601058", "story_v_side_old_106601.awb") / 1000

					if var_232_13 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_5
					end

					if var_232_8.prefab_name ~= "" and arg_229_1.actors_[var_232_8.prefab_name] ~= nil then
						local var_232_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_8.prefab_name].transform, "story_v_side_old_106601", "106601058", "story_v_side_old_106601.awb")

						arg_229_1:RecordAudio("106601058", var_232_14)
						arg_229_1:RecordAudio("106601058", var_232_14)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601058", "story_v_side_old_106601.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601058", "story_v_side_old_106601.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_15 = math.max(var_232_6, arg_229_1.talkMaxDuration)

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_15 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_5) / var_232_15

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_5 + var_232_15 and arg_229_1.time_ < var_232_5 + var_232_15 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play106601059 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 106601059
		arg_233_1.duration_ = 4.83

		local var_233_0 = {
			ja = 4.833,
			ko = 4.7,
			en = 4.766
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play106601060(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action442")
			end

			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_236_2 = 0
			local var_236_3 = 0.575

			if var_236_2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_4 = arg_233_1:FormatText(StoryNameCfg[32].name)

				arg_233_1.leftNameTxt_.text = var_236_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_5 = arg_233_1:GetWordFromCfg(106601059)
				local var_236_6 = arg_233_1:FormatText(var_236_5.content)

				arg_233_1.text_.text = var_236_6

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 23
				local var_236_8 = utf8.len(var_236_6)
				local var_236_9 = var_236_7 <= 0 and var_236_3 or var_236_3 * (var_236_8 / var_236_7)

				if var_236_9 > 0 and var_236_3 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_6
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601059", "story_v_side_old_106601.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601059", "story_v_side_old_106601.awb") / 1000

					if var_236_10 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_2
					end

					if var_236_5.prefab_name ~= "" and arg_233_1.actors_[var_236_5.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_5.prefab_name].transform, "story_v_side_old_106601", "106601059", "story_v_side_old_106601.awb")

						arg_233_1:RecordAudio("106601059", var_236_11)
						arg_233_1:RecordAudio("106601059", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601059", "story_v_side_old_106601.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601059", "story_v_side_old_106601.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 <= arg_233_1.time_ and arg_233_1.time_ < var_236_2 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_2) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_2 + var_236_12 and arg_233_1.time_ < var_236_2 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play106601060 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 106601060
		arg_237_1.duration_ = 8.03

		local var_237_0 = {
			ja = 6,
			ko = 8.033,
			en = 5.7
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play106601061(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action424")
			end

			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_240_2 = 0
			local var_240_3 = 0.95

			if var_240_2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_4 = arg_237_1:FormatText(StoryNameCfg[32].name)

				arg_237_1.leftNameTxt_.text = var_240_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_5 = arg_237_1:GetWordFromCfg(106601060)
				local var_240_6 = arg_237_1:FormatText(var_240_5.content)

				arg_237_1.text_.text = var_240_6

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_7 = 38
				local var_240_8 = utf8.len(var_240_6)
				local var_240_9 = var_240_7 <= 0 and var_240_3 or var_240_3 * (var_240_8 / var_240_7)

				if var_240_9 > 0 and var_240_3 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_6
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601060", "story_v_side_old_106601.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601060", "story_v_side_old_106601.awb") / 1000

					if var_240_10 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_2
					end

					if var_240_5.prefab_name ~= "" and arg_237_1.actors_[var_240_5.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_5.prefab_name].transform, "story_v_side_old_106601", "106601060", "story_v_side_old_106601.awb")

						arg_237_1:RecordAudio("106601060", var_240_11)
						arg_237_1:RecordAudio("106601060", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601060", "story_v_side_old_106601.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601060", "story_v_side_old_106601.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_3, arg_237_1.talkMaxDuration)

			if var_240_2 <= arg_237_1.time_ and arg_237_1.time_ < var_240_2 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_2) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_2 + var_240_12 and arg_237_1.time_ < var_240_2 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play106601061 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 106601061
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play106601062(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1066ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1066ui_story == nil then
				arg_241_1.var_.characterEffect1066ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.1

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1066ui_story and not isNil(var_244_0) then
					local var_244_4 = Mathf.Lerp(0, 0.5, var_244_3)

					arg_241_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1066ui_story.fillRatio = var_244_4
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1066ui_story then
				local var_244_5 = 0.5

				arg_241_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1066ui_story.fillRatio = var_244_5
			end

			local var_244_6 = 0
			local var_244_7 = 0.275

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_8 = arg_241_1:FormatText(StoryNameCfg[7].name)

				arg_241_1.leftNameTxt_.text = var_244_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_9 = arg_241_1:GetWordFromCfg(106601061)
				local var_244_10 = arg_241_1:FormatText(var_244_9.content)

				arg_241_1.text_.text = var_244_10

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 11
				local var_244_12 = utf8.len(var_244_10)
				local var_244_13 = var_244_11 <= 0 and var_244_7 or var_244_7 * (var_244_12 / var_244_11)

				if var_244_13 > 0 and var_244_7 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_10
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_14 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_14 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_14

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_14 and arg_241_1.time_ < var_244_6 + var_244_14 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play106601062 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 106601062
		arg_245_1.duration_ = 2

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play106601063(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1066ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1066ui_story == nil then
				arg_245_1.var_.characterEffect1066ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.1

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1066ui_story and not isNil(var_248_0) then
					arg_245_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1066ui_story then
				arg_245_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_248_4 = 0

			if var_248_4 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action443")
			end

			local var_248_5 = 0

			if var_248_5 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_248_6 = 0
			local var_248_7 = 0.05

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_8 = arg_245_1:FormatText(StoryNameCfg[32].name)

				arg_245_1.leftNameTxt_.text = var_248_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_9 = arg_245_1:GetWordFromCfg(106601062)
				local var_248_10 = arg_245_1:FormatText(var_248_9.content)

				arg_245_1.text_.text = var_248_10

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 2
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

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601062", "story_v_side_old_106601.awb") ~= 0 then
					local var_248_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601062", "story_v_side_old_106601.awb") / 1000

					if var_248_14 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_14 + var_248_6
					end

					if var_248_9.prefab_name ~= "" and arg_245_1.actors_[var_248_9.prefab_name] ~= nil then
						local var_248_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_9.prefab_name].transform, "story_v_side_old_106601", "106601062", "story_v_side_old_106601.awb")

						arg_245_1:RecordAudio("106601062", var_248_15)
						arg_245_1:RecordAudio("106601062", var_248_15)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601062", "story_v_side_old_106601.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601062", "story_v_side_old_106601.awb")
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
	Play106601063 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 106601063
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play106601064(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1066ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1066ui_story == nil then
				arg_249_1.var_.characterEffect1066ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.1

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1066ui_story and not isNil(var_252_0) then
					local var_252_4 = Mathf.Lerp(0, 0.5, var_252_3)

					arg_249_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1066ui_story.fillRatio = var_252_4
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1066ui_story then
				local var_252_5 = 0.5

				arg_249_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1066ui_story.fillRatio = var_252_5
			end

			local var_252_6 = 0
			local var_252_7 = 0.35

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_8 = arg_249_1:FormatText(StoryNameCfg[7].name)

				arg_249_1.leftNameTxt_.text = var_252_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_9 = arg_249_1:GetWordFromCfg(106601063)
				local var_252_10 = arg_249_1:FormatText(var_252_9.content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 14
				local var_252_12 = utf8.len(var_252_10)
				local var_252_13 = var_252_11 <= 0 and var_252_7 or var_252_7 * (var_252_12 / var_252_11)

				if var_252_13 > 0 and var_252_7 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_10
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_14 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_14 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_14

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_14 and arg_249_1.time_ < var_252_6 + var_252_14 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play106601064 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 106601064
		arg_253_1.duration_ = 5.97

		local var_253_0 = {
			ja = 5.966,
			ko = 5.166,
			en = 5.066
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play106601065(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1066ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1066ui_story == nil then
				arg_253_1.var_.characterEffect1066ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.1

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1066ui_story and not isNil(var_256_0) then
					arg_253_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1066ui_story then
				arg_253_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_256_4 = 0

			if var_256_4 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_256_5 = 0
			local var_256_6 = 0.475

			if var_256_5 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_7 = arg_253_1:FormatText(StoryNameCfg[32].name)

				arg_253_1.leftNameTxt_.text = var_256_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_8 = arg_253_1:GetWordFromCfg(106601064)
				local var_256_9 = arg_253_1:FormatText(var_256_8.content)

				arg_253_1.text_.text = var_256_9

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_10 = 19
				local var_256_11 = utf8.len(var_256_9)
				local var_256_12 = var_256_10 <= 0 and var_256_6 or var_256_6 * (var_256_11 / var_256_10)

				if var_256_12 > 0 and var_256_6 < var_256_12 then
					arg_253_1.talkMaxDuration = var_256_12

					if var_256_12 + var_256_5 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_5
					end
				end

				arg_253_1.text_.text = var_256_9
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601064", "story_v_side_old_106601.awb") ~= 0 then
					local var_256_13 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601064", "story_v_side_old_106601.awb") / 1000

					if var_256_13 + var_256_5 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_5
					end

					if var_256_8.prefab_name ~= "" and arg_253_1.actors_[var_256_8.prefab_name] ~= nil then
						local var_256_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_8.prefab_name].transform, "story_v_side_old_106601", "106601064", "story_v_side_old_106601.awb")

						arg_253_1:RecordAudio("106601064", var_256_14)
						arg_253_1:RecordAudio("106601064", var_256_14)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601064", "story_v_side_old_106601.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601064", "story_v_side_old_106601.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_15 = math.max(var_256_6, arg_253_1.talkMaxDuration)

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_15 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_5) / var_256_15

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_5 + var_256_15 and arg_253_1.time_ < var_256_5 + var_256_15 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play106601065 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 106601065
		arg_257_1.duration_ = 8.9

		local var_257_0 = {
			ja = 8.3,
			ko = 8.9,
			en = 7.4
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play106601066(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_260_2 = 0
			local var_260_3 = 1.175

			if var_260_2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_4 = arg_257_1:FormatText(StoryNameCfg[32].name)

				arg_257_1.leftNameTxt_.text = var_260_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_5 = arg_257_1:GetWordFromCfg(106601065)
				local var_260_6 = arg_257_1:FormatText(var_260_5.content)

				arg_257_1.text_.text = var_260_6

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 47
				local var_260_8 = utf8.len(var_260_6)
				local var_260_9 = var_260_7 <= 0 and var_260_3 or var_260_3 * (var_260_8 / var_260_7)

				if var_260_9 > 0 and var_260_3 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_6
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601065", "story_v_side_old_106601.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601065", "story_v_side_old_106601.awb") / 1000

					if var_260_10 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_2
					end

					if var_260_5.prefab_name ~= "" and arg_257_1.actors_[var_260_5.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_5.prefab_name].transform, "story_v_side_old_106601", "106601065", "story_v_side_old_106601.awb")

						arg_257_1:RecordAudio("106601065", var_260_11)
						arg_257_1:RecordAudio("106601065", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601065", "story_v_side_old_106601.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601065", "story_v_side_old_106601.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_12 and arg_257_1.time_ < var_260_2 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play106601066 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 106601066
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play106601067(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1066ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1066ui_story == nil then
				arg_261_1.var_.characterEffect1066ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.1

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1066ui_story and not isNil(var_264_0) then
					local var_264_4 = Mathf.Lerp(0, 0.5, var_264_3)

					arg_261_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1066ui_story.fillRatio = var_264_4
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1066ui_story then
				local var_264_5 = 0.5

				arg_261_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1066ui_story.fillRatio = var_264_5
			end

			local var_264_6 = 0
			local var_264_7 = 0.25

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_8 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_9 = arg_261_1:GetWordFromCfg(106601066)
				local var_264_10 = arg_261_1:FormatText(var_264_9.content)

				arg_261_1.text_.text = var_264_10

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 10
				local var_264_12 = utf8.len(var_264_10)
				local var_264_13 = var_264_11 <= 0 and var_264_7 or var_264_7 * (var_264_12 / var_264_11)

				if var_264_13 > 0 and var_264_7 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13

					if var_264_13 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_10
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_14 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_14 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_14

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_14 and arg_261_1.time_ < var_264_6 + var_264_14 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play106601067 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 106601067
		arg_265_1.duration_ = 3.2

		local var_265_0 = {
			ja = 3,
			ko = 3.2,
			en = 2.533
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play106601068(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1066ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1066ui_story == nil then
				arg_265_1.var_.characterEffect1066ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.1

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1066ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1066ui_story then
				arg_265_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_268_4 = 0

			if var_268_4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action424")
			end

			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_268_6 = 0
			local var_268_7 = 0.3

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_8 = arg_265_1:FormatText(StoryNameCfg[32].name)

				arg_265_1.leftNameTxt_.text = var_268_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_9 = arg_265_1:GetWordFromCfg(106601067)
				local var_268_10 = arg_265_1:FormatText(var_268_9.content)

				arg_265_1.text_.text = var_268_10

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601067", "story_v_side_old_106601.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601067", "story_v_side_old_106601.awb") / 1000

					if var_268_14 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_6
					end

					if var_268_9.prefab_name ~= "" and arg_265_1.actors_[var_268_9.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_9.prefab_name].transform, "story_v_side_old_106601", "106601067", "story_v_side_old_106601.awb")

						arg_265_1:RecordAudio("106601067", var_268_15)
						arg_265_1:RecordAudio("106601067", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601067", "story_v_side_old_106601.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601067", "story_v_side_old_106601.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_16 = math.max(var_268_7, arg_265_1.talkMaxDuration)

			if var_268_6 <= arg_265_1.time_ and arg_265_1.time_ < var_268_6 + var_268_16 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_6) / var_268_16

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_6 + var_268_16 and arg_265_1.time_ < var_268_6 + var_268_16 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play106601068 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 106601068
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play106601069(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1066ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1066ui_story == nil then
				arg_269_1.var_.characterEffect1066ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.1

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1066ui_story and not isNil(var_272_0) then
					local var_272_4 = Mathf.Lerp(0, 0.5, var_272_3)

					arg_269_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1066ui_story.fillRatio = var_272_4
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1066ui_story then
				local var_272_5 = 0.5

				arg_269_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1066ui_story.fillRatio = var_272_5
			end

			local var_272_6 = 0
			local var_272_7 = 0.1

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_8 = arg_269_1:FormatText(StoryNameCfg[7].name)

				arg_269_1.leftNameTxt_.text = var_272_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_9 = arg_269_1:GetWordFromCfg(106601068)
				local var_272_10 = arg_269_1:FormatText(var_272_9.content)

				arg_269_1.text_.text = var_272_10

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_11 = 4
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
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_14 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_14 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_14

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_14 and arg_269_1.time_ < var_272_6 + var_272_14 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play106601069 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 106601069
		arg_273_1.duration_ = 7.6

		local var_273_0 = {
			ja = 5.333,
			ko = 6.5,
			en = 7.6
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
				arg_273_0:Play106601070(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1066ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1066ui_story == nil then
				arg_273_1.var_.characterEffect1066ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.1

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1066ui_story and not isNil(var_276_0) then
					arg_273_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1066ui_story then
				arg_273_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_276_4 = 0

			if var_276_4 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_276_5 = 0
			local var_276_6 = 0.8

			if var_276_5 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_7 = arg_273_1:FormatText(StoryNameCfg[32].name)

				arg_273_1.leftNameTxt_.text = var_276_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_8 = arg_273_1:GetWordFromCfg(106601069)
				local var_276_9 = arg_273_1:FormatText(var_276_8.content)

				arg_273_1.text_.text = var_276_9

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_10 = 32
				local var_276_11 = utf8.len(var_276_9)
				local var_276_12 = var_276_10 <= 0 and var_276_6 or var_276_6 * (var_276_11 / var_276_10)

				if var_276_12 > 0 and var_276_6 < var_276_12 then
					arg_273_1.talkMaxDuration = var_276_12

					if var_276_12 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_12 + var_276_5
					end
				end

				arg_273_1.text_.text = var_276_9
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601069", "story_v_side_old_106601.awb") ~= 0 then
					local var_276_13 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601069", "story_v_side_old_106601.awb") / 1000

					if var_276_13 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_5
					end

					if var_276_8.prefab_name ~= "" and arg_273_1.actors_[var_276_8.prefab_name] ~= nil then
						local var_276_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_8.prefab_name].transform, "story_v_side_old_106601", "106601069", "story_v_side_old_106601.awb")

						arg_273_1:RecordAudio("106601069", var_276_14)
						arg_273_1:RecordAudio("106601069", var_276_14)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601069", "story_v_side_old_106601.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601069", "story_v_side_old_106601.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_15 = math.max(var_276_6, arg_273_1.talkMaxDuration)

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_15 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_5) / var_276_15

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_5 + var_276_15 and arg_273_1.time_ < var_276_5 + var_276_15 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play106601070 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 106601070
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play106601071(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1066ui_story"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1066ui_story == nil then
				arg_277_1.var_.characterEffect1066ui_story = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.1

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect1066ui_story and not isNil(var_280_0) then
					local var_280_4 = Mathf.Lerp(0, 0.5, var_280_3)

					arg_277_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1066ui_story.fillRatio = var_280_4
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1066ui_story then
				local var_280_5 = 0.5

				arg_277_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1066ui_story.fillRatio = var_280_5
			end

			local var_280_6 = 0
			local var_280_7 = 0.05

			if var_280_6 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_8 = arg_277_1:FormatText(StoryNameCfg[7].name)

				arg_277_1.leftNameTxt_.text = var_280_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_9 = arg_277_1:GetWordFromCfg(106601070)
				local var_280_10 = arg_277_1:FormatText(var_280_9.content)

				arg_277_1.text_.text = var_280_10

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 2
				local var_280_12 = utf8.len(var_280_10)
				local var_280_13 = var_280_11 <= 0 and var_280_7 or var_280_7 * (var_280_12 / var_280_11)

				if var_280_13 > 0 and var_280_7 < var_280_13 then
					arg_277_1.talkMaxDuration = var_280_13

					if var_280_13 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_13 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_10
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_14 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_14 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_14

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_14 and arg_277_1.time_ < var_280_6 + var_280_14 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play106601071 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 106601071
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play106601072(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.825

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(106601071)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 33
				local var_284_5 = utf8.len(var_284_3)
				local var_284_6 = var_284_4 <= 0 and var_284_1 or var_284_1 * (var_284_5 / var_284_4)

				if var_284_6 > 0 and var_284_1 < var_284_6 then
					arg_281_1.talkMaxDuration = var_284_6

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_7 and arg_281_1.time_ < var_284_0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play106601072 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 106601072
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play106601073(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.775

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

				local var_288_3 = arg_285_1:GetWordFromCfg(106601072)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 31
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
	Play106601073 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 106601073
		arg_289_1.duration_ = 3.9

		local var_289_0 = {
			ja = 1.999999999999,
			ko = 3.2,
			en = 3.9
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
				arg_289_0:Play106601074(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1066ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1066ui_story == nil then
				arg_289_1.var_.characterEffect1066ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.1

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1066ui_story and not isNil(var_292_0) then
					arg_289_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1066ui_story then
				arg_289_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_292_4 = 0

			if var_292_4 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action442")
			end

			local var_292_5 = 0

			if var_292_5 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_292_6 = 0
			local var_292_7 = 0.275

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_8 = arg_289_1:FormatText(StoryNameCfg[32].name)

				arg_289_1.leftNameTxt_.text = var_292_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_9 = arg_289_1:GetWordFromCfg(106601073)
				local var_292_10 = arg_289_1:FormatText(var_292_9.content)

				arg_289_1.text_.text = var_292_10

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 11
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

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601073", "story_v_side_old_106601.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601073", "story_v_side_old_106601.awb") / 1000

					if var_292_14 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_6
					end

					if var_292_9.prefab_name ~= "" and arg_289_1.actors_[var_292_9.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_9.prefab_name].transform, "story_v_side_old_106601", "106601073", "story_v_side_old_106601.awb")

						arg_289_1:RecordAudio("106601073", var_292_15)
						arg_289_1:RecordAudio("106601073", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601073", "story_v_side_old_106601.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601073", "story_v_side_old_106601.awb")
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
	Play106601074 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 106601074
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play106601075(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1066ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1066ui_story == nil then
				arg_293_1.var_.characterEffect1066ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.1

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1066ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1066ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1066ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1066ui_story.fillRatio = var_296_5
			end

			local var_296_6 = 0
			local var_296_7 = 0.875

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

				local var_296_9 = arg_293_1:GetWordFromCfg(106601074)
				local var_296_10 = arg_293_1:FormatText(var_296_9.content)

				arg_293_1.text_.text = var_296_10

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 35
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
	Play106601075 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 106601075
		arg_297_1.duration_ = 8.67

		local var_297_0 = {
			ja = 5.666,
			ko = 8.666,
			en = 8.1
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
				arg_297_0:Play106601076(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1066ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1066ui_story == nil then
				arg_297_1.var_.characterEffect1066ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.1

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1066ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1066ui_story then
				arg_297_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_300_4 = 0

			if var_300_4 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_300_5 = 0
			local var_300_6 = 0.8

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_7 = arg_297_1:FormatText(StoryNameCfg[32].name)

				arg_297_1.leftNameTxt_.text = var_300_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_8 = arg_297_1:GetWordFromCfg(106601075)
				local var_300_9 = arg_297_1:FormatText(var_300_8.content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_10 = 32
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

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601075", "story_v_side_old_106601.awb") ~= 0 then
					local var_300_13 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601075", "story_v_side_old_106601.awb") / 1000

					if var_300_13 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_5
					end

					if var_300_8.prefab_name ~= "" and arg_297_1.actors_[var_300_8.prefab_name] ~= nil then
						local var_300_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_8.prefab_name].transform, "story_v_side_old_106601", "106601075", "story_v_side_old_106601.awb")

						arg_297_1:RecordAudio("106601075", var_300_14)
						arg_297_1:RecordAudio("106601075", var_300_14)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601075", "story_v_side_old_106601.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601075", "story_v_side_old_106601.awb")
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
	Play106601076 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 106601076
		arg_301_1.duration_ = 4.07

		local var_301_0 = {
			ja = 4.066,
			ko = 3.5,
			en = 3.9
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play106601077(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action425")
			end

			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_304_2 = 0
			local var_304_3 = 0.4

			if var_304_2 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_4 = arg_301_1:FormatText(StoryNameCfg[32].name)

				arg_301_1.leftNameTxt_.text = var_304_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_5 = arg_301_1:GetWordFromCfg(106601076)
				local var_304_6 = arg_301_1:FormatText(var_304_5.content)

				arg_301_1.text_.text = var_304_6

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 16
				local var_304_8 = utf8.len(var_304_6)
				local var_304_9 = var_304_7 <= 0 and var_304_3 or var_304_3 * (var_304_8 / var_304_7)

				if var_304_9 > 0 and var_304_3 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_6
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601076", "story_v_side_old_106601.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601076", "story_v_side_old_106601.awb") / 1000

					if var_304_10 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_2
					end

					if var_304_5.prefab_name ~= "" and arg_301_1.actors_[var_304_5.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_5.prefab_name].transform, "story_v_side_old_106601", "106601076", "story_v_side_old_106601.awb")

						arg_301_1:RecordAudio("106601076", var_304_11)
						arg_301_1:RecordAudio("106601076", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601076", "story_v_side_old_106601.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601076", "story_v_side_old_106601.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_12 and arg_301_1.time_ < var_304_2 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play106601077 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 106601077
		arg_305_1.duration_ = 12.53

		local var_305_0 = {
			ja = 12.533,
			ko = 9.733,
			en = 8.9
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play106601078(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action454")
			end

			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_308_2 = 0
			local var_308_3 = 0.95

			if var_308_2 < arg_305_1.time_ and arg_305_1.time_ <= var_308_2 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_4 = arg_305_1:FormatText(StoryNameCfg[32].name)

				arg_305_1.leftNameTxt_.text = var_308_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_5 = arg_305_1:GetWordFromCfg(106601077)
				local var_308_6 = arg_305_1:FormatText(var_308_5.content)

				arg_305_1.text_.text = var_308_6

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_7 = 38
				local var_308_8 = utf8.len(var_308_6)
				local var_308_9 = var_308_7 <= 0 and var_308_3 or var_308_3 * (var_308_8 / var_308_7)

				if var_308_9 > 0 and var_308_3 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_2 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_2
					end
				end

				arg_305_1.text_.text = var_308_6
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601077", "story_v_side_old_106601.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601077", "story_v_side_old_106601.awb") / 1000

					if var_308_10 + var_308_2 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_2
					end

					if var_308_5.prefab_name ~= "" and arg_305_1.actors_[var_308_5.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_5.prefab_name].transform, "story_v_side_old_106601", "106601077", "story_v_side_old_106601.awb")

						arg_305_1:RecordAudio("106601077", var_308_11)
						arg_305_1:RecordAudio("106601077", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601077", "story_v_side_old_106601.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601077", "story_v_side_old_106601.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_12 = math.max(var_308_3, arg_305_1.talkMaxDuration)

			if var_308_2 <= arg_305_1.time_ and arg_305_1.time_ < var_308_2 + var_308_12 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_2) / var_308_12

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_2 + var_308_12 and arg_305_1.time_ < var_308_2 + var_308_12 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play106601078 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 106601078
		arg_309_1.duration_ = 16.47

		local var_309_0 = {
			ja = 16.466,
			ko = 8.966,
			en = 7.3
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
				arg_309_0:Play106601079(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_312_1 = 0
			local var_312_2 = 0.825

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_3 = arg_309_1:FormatText(StoryNameCfg[32].name)

				arg_309_1.leftNameTxt_.text = var_312_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_4 = arg_309_1:GetWordFromCfg(106601078)
				local var_312_5 = arg_309_1:FormatText(var_312_4.content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_6 = 33
				local var_312_7 = utf8.len(var_312_5)
				local var_312_8 = var_312_6 <= 0 and var_312_2 or var_312_2 * (var_312_7 / var_312_6)

				if var_312_8 > 0 and var_312_2 < var_312_8 then
					arg_309_1.talkMaxDuration = var_312_8

					if var_312_8 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_1
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601078", "story_v_side_old_106601.awb") ~= 0 then
					local var_312_9 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601078", "story_v_side_old_106601.awb") / 1000

					if var_312_9 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_1
					end

					if var_312_4.prefab_name ~= "" and arg_309_1.actors_[var_312_4.prefab_name] ~= nil then
						local var_312_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_4.prefab_name].transform, "story_v_side_old_106601", "106601078", "story_v_side_old_106601.awb")

						arg_309_1:RecordAudio("106601078", var_312_10)
						arg_309_1:RecordAudio("106601078", var_312_10)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601078", "story_v_side_old_106601.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601078", "story_v_side_old_106601.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_11 = math.max(var_312_2, arg_309_1.talkMaxDuration)

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_11 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_1) / var_312_11

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_1 + var_312_11 and arg_309_1.time_ < var_312_1 + var_312_11 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play106601079 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 106601079
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play106601080(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1066ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1066ui_story == nil then
				arg_313_1.var_.characterEffect1066ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.1

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1066ui_story and not isNil(var_316_0) then
					local var_316_4 = Mathf.Lerp(0, 0.5, var_316_3)

					arg_313_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1066ui_story.fillRatio = var_316_4
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1066ui_story then
				local var_316_5 = 0.5

				arg_313_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1066ui_story.fillRatio = var_316_5
			end

			local var_316_6 = 0
			local var_316_7 = 0.225

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_8 = arg_313_1:FormatText(StoryNameCfg[7].name)

				arg_313_1.leftNameTxt_.text = var_316_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_9 = arg_313_1:GetWordFromCfg(106601079)
				local var_316_10 = arg_313_1:FormatText(var_316_9.content)

				arg_313_1.text_.text = var_316_10

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 9
				local var_316_12 = utf8.len(var_316_10)
				local var_316_13 = var_316_11 <= 0 and var_316_7 or var_316_7 * (var_316_12 / var_316_11)

				if var_316_13 > 0 and var_316_7 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_10
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_14 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_14 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_14

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_14 and arg_313_1.time_ < var_316_6 + var_316_14 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play106601080 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 106601080
		arg_317_1.duration_ = 5.53

		local var_317_0 = {
			ja = 5.2,
			ko = 3.8,
			en = 5.533
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
				arg_317_0:Play106601081(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1066ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1066ui_story == nil then
				arg_317_1.var_.characterEffect1066ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.1

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1066ui_story and not isNil(var_320_0) then
					arg_317_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1066ui_story then
				arg_317_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_320_4 = 0

			if var_320_4 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action445")
			end

			local var_320_5 = 0

			if var_320_5 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 then
				arg_317_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_320_6 = 0
			local var_320_7 = 0.375

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_8 = arg_317_1:FormatText(StoryNameCfg[32].name)

				arg_317_1.leftNameTxt_.text = var_320_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_9 = arg_317_1:GetWordFromCfg(106601080)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 15
				local var_320_12 = utf8.len(var_320_10)
				local var_320_13 = var_320_11 <= 0 and var_320_7 or var_320_7 * (var_320_12 / var_320_11)

				if var_320_13 > 0 and var_320_7 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601080", "story_v_side_old_106601.awb") ~= 0 then
					local var_320_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601080", "story_v_side_old_106601.awb") / 1000

					if var_320_14 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_14 + var_320_6
					end

					if var_320_9.prefab_name ~= "" and arg_317_1.actors_[var_320_9.prefab_name] ~= nil then
						local var_320_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_9.prefab_name].transform, "story_v_side_old_106601", "106601080", "story_v_side_old_106601.awb")

						arg_317_1:RecordAudio("106601080", var_320_15)
						arg_317_1:RecordAudio("106601080", var_320_15)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601080", "story_v_side_old_106601.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601080", "story_v_side_old_106601.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_16 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_16 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_16

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_16 and arg_317_1.time_ < var_320_6 + var_320_16 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play106601081 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 106601081
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play106601082(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1066ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1066ui_story == nil then
				arg_321_1.var_.characterEffect1066ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.1

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect1066ui_story and not isNil(var_324_0) then
					local var_324_4 = Mathf.Lerp(0, 0.5, var_324_3)

					arg_321_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1066ui_story.fillRatio = var_324_4
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1066ui_story then
				local var_324_5 = 0.5

				arg_321_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1066ui_story.fillRatio = var_324_5
			end

			local var_324_6 = 0
			local var_324_7 = 0.275

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

				local var_324_9 = arg_321_1:GetWordFromCfg(106601081)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 11
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
	Play106601082 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 106601082
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play106601083(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 1.35

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[7].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(106601082)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 54
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_8 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_8 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_8

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_8 and arg_325_1.time_ < var_328_0 + var_328_8 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play106601083 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 106601083
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play106601084(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 1.35

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[7].name)

				arg_329_1.leftNameTxt_.text = var_332_2

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

				local var_332_3 = arg_329_1:GetWordFromCfg(106601083)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 54
				local var_332_6 = utf8.len(var_332_4)
				local var_332_7 = var_332_5 <= 0 and var_332_1 or var_332_1 * (var_332_6 / var_332_5)

				if var_332_7 > 0 and var_332_1 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_8 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_8 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_8

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_8 and arg_329_1.time_ < var_332_0 + var_332_8 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play106601084 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 106601084
		arg_333_1.duration_ = 11.33

		local var_333_0 = {
			ja = 11.333,
			ko = 9.233,
			en = 7.866
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
				arg_333_0:Play106601085(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1066ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1066ui_story == nil then
				arg_333_1.var_.characterEffect1066ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.1

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1066ui_story and not isNil(var_336_0) then
					arg_333_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1066ui_story then
				arg_333_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_336_4 = 0

			if var_336_4 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action453")
			end

			local var_336_5 = 0

			if var_336_5 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_336_6 = 0
			local var_336_7 = 0.975

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[32].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_9 = arg_333_1:GetWordFromCfg(106601084)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 39
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601084", "story_v_side_old_106601.awb") ~= 0 then
					local var_336_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601084", "story_v_side_old_106601.awb") / 1000

					if var_336_14 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_14 + var_336_6
					end

					if var_336_9.prefab_name ~= "" and arg_333_1.actors_[var_336_9.prefab_name] ~= nil then
						local var_336_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_9.prefab_name].transform, "story_v_side_old_106601", "106601084", "story_v_side_old_106601.awb")

						arg_333_1:RecordAudio("106601084", var_336_15)
						arg_333_1:RecordAudio("106601084", var_336_15)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601084", "story_v_side_old_106601.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601084", "story_v_side_old_106601.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_16 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_16 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_16

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_16 and arg_333_1.time_ < var_336_6 + var_336_16 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play106601085 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 106601085
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play106601086(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1066ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1066ui_story == nil then
				arg_337_1.var_.characterEffect1066ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.1

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1066ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1066ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1066ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1066ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 0.325

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_9 = arg_337_1:GetWordFromCfg(106601085)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 13
				local var_340_12 = utf8.len(var_340_10)
				local var_340_13 = var_340_11 <= 0 and var_340_7 or var_340_7 * (var_340_12 / var_340_11)

				if var_340_13 > 0 and var_340_7 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_14 and arg_337_1.time_ < var_340_6 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play106601086 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 106601086
		arg_341_1.duration_ = 1.37

		local var_341_0 = {
			ja = 1.366,
			ko = 0.933,
			en = 0.866
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
				arg_341_0:Play106601087(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1066ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1066ui_story == nil then
				arg_341_1.var_.characterEffect1066ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.1

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect1066ui_story and not isNil(var_344_0) then
					arg_341_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1066ui_story then
				arg_341_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_344_4 = 0
			local var_344_5 = 0.05

			if var_344_4 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_6 = arg_341_1:FormatText(StoryNameCfg[32].name)

				arg_341_1.leftNameTxt_.text = var_344_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_7 = arg_341_1:GetWordFromCfg(106601086)
				local var_344_8 = arg_341_1:FormatText(var_344_7.content)

				arg_341_1.text_.text = var_344_8

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 2
				local var_344_10 = utf8.len(var_344_8)
				local var_344_11 = var_344_9 <= 0 and var_344_5 or var_344_5 * (var_344_10 / var_344_9)

				if var_344_11 > 0 and var_344_5 < var_344_11 then
					arg_341_1.talkMaxDuration = var_344_11

					if var_344_11 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_11 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_8
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601086", "story_v_side_old_106601.awb") ~= 0 then
					local var_344_12 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601086", "story_v_side_old_106601.awb") / 1000

					if var_344_12 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_12 + var_344_4
					end

					if var_344_7.prefab_name ~= "" and arg_341_1.actors_[var_344_7.prefab_name] ~= nil then
						local var_344_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_7.prefab_name].transform, "story_v_side_old_106601", "106601086", "story_v_side_old_106601.awb")

						arg_341_1:RecordAudio("106601086", var_344_13)
						arg_341_1:RecordAudio("106601086", var_344_13)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601086", "story_v_side_old_106601.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601086", "story_v_side_old_106601.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_14 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_14 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_14

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_14 and arg_341_1.time_ < var_344_4 + var_344_14 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play106601087 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 106601087
		arg_345_1.duration_ = 3.6

		local var_345_0 = {
			ja = 3.6,
			ko = 3.366,
			en = 2.1
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
				arg_345_0:Play106601088(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action435")
			end

			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_348_2 = 0
			local var_348_3 = 0.3

			if var_348_2 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_4 = arg_345_1:FormatText(StoryNameCfg[32].name)

				arg_345_1.leftNameTxt_.text = var_348_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_5 = arg_345_1:GetWordFromCfg(106601087)
				local var_348_6 = arg_345_1:FormatText(var_348_5.content)

				arg_345_1.text_.text = var_348_6

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_7 = 12
				local var_348_8 = utf8.len(var_348_6)
				local var_348_9 = var_348_7 <= 0 and var_348_3 or var_348_3 * (var_348_8 / var_348_7)

				if var_348_9 > 0 and var_348_3 < var_348_9 then
					arg_345_1.talkMaxDuration = var_348_9

					if var_348_9 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_9 + var_348_2
					end
				end

				arg_345_1.text_.text = var_348_6
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601087", "story_v_side_old_106601.awb") ~= 0 then
					local var_348_10 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601087", "story_v_side_old_106601.awb") / 1000

					if var_348_10 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_2
					end

					if var_348_5.prefab_name ~= "" and arg_345_1.actors_[var_348_5.prefab_name] ~= nil then
						local var_348_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_5.prefab_name].transform, "story_v_side_old_106601", "106601087", "story_v_side_old_106601.awb")

						arg_345_1:RecordAudio("106601087", var_348_11)
						arg_345_1:RecordAudio("106601087", var_348_11)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601087", "story_v_side_old_106601.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601087", "story_v_side_old_106601.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_12 = math.max(var_348_3, arg_345_1.talkMaxDuration)

			if var_348_2 <= arg_345_1.time_ and arg_345_1.time_ < var_348_2 + var_348_12 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_2) / var_348_12

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_2 + var_348_12 and arg_345_1.time_ < var_348_2 + var_348_12 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play106601088 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 106601088
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play106601089(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1066ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1066ui_story == nil then
				arg_349_1.var_.characterEffect1066ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.1

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1066ui_story and not isNil(var_352_0) then
					local var_352_4 = Mathf.Lerp(0, 0.5, var_352_3)

					arg_349_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1066ui_story.fillRatio = var_352_4
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1066ui_story then
				local var_352_5 = 0.5

				arg_349_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1066ui_story.fillRatio = var_352_5
			end

			local var_352_6 = 0
			local var_352_7 = 0.575

			if var_352_6 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_8 = arg_349_1:GetWordFromCfg(106601088)
				local var_352_9 = arg_349_1:FormatText(var_352_8.content)

				arg_349_1.text_.text = var_352_9

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_10 = 23
				local var_352_11 = utf8.len(var_352_9)
				local var_352_12 = var_352_10 <= 0 and var_352_7 or var_352_7 * (var_352_11 / var_352_10)

				if var_352_12 > 0 and var_352_7 < var_352_12 then
					arg_349_1.talkMaxDuration = var_352_12

					if var_352_12 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_12 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_9
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_13 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_13 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_13

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_13 and arg_349_1.time_ < var_352_6 + var_352_13 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play106601089 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 106601089
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play106601090(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1066ui_story"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos1066ui_story = var_356_0.localPosition
			end

			local var_356_2 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2
				local var_356_4 = Vector3.New(30, -0.82, -5.5)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1066ui_story, var_356_4, var_356_3)

				local var_356_5 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_5.x, var_356_5.y, var_356_5.z)

				local var_356_6 = var_356_0.localEulerAngles

				var_356_6.z = 0
				var_356_6.x = 0
				var_356_0.localEulerAngles = var_356_6
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(30, -0.82, -5.5)

				local var_356_7 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_7.x, var_356_7.y, var_356_7.z)

				local var_356_8 = var_356_0.localEulerAngles

				var_356_8.z = 0
				var_356_8.x = 0
				var_356_0.localEulerAngles = var_356_8
			end

			local var_356_9 = 0
			local var_356_10 = 0.8

			if var_356_9 < arg_353_1.time_ and arg_353_1.time_ <= var_356_9 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_11 = arg_353_1:GetWordFromCfg(106601089)
				local var_356_12 = arg_353_1:FormatText(var_356_11.content)

				arg_353_1.text_.text = var_356_12

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_13 = 32
				local var_356_14 = utf8.len(var_356_12)
				local var_356_15 = var_356_13 <= 0 and var_356_10 or var_356_10 * (var_356_14 / var_356_13)

				if var_356_15 > 0 and var_356_10 < var_356_15 then
					arg_353_1.talkMaxDuration = var_356_15

					if var_356_15 + var_356_9 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_15 + var_356_9
					end
				end

				arg_353_1.text_.text = var_356_12
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_16 = math.max(var_356_10, arg_353_1.talkMaxDuration)

			if var_356_9 <= arg_353_1.time_ and arg_353_1.time_ < var_356_9 + var_356_16 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_9) / var_356_16

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_9 + var_356_16 and arg_353_1.time_ < var_356_9 + var_356_16 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play106601090 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 106601090
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play106601091(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 0.65

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_2 = arg_357_1:FormatText(StoryNameCfg[7].name)

				arg_357_1.leftNameTxt_.text = var_360_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_3 = arg_357_1:GetWordFromCfg(106601090)
				local var_360_4 = arg_357_1:FormatText(var_360_3.content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 26
				local var_360_6 = utf8.len(var_360_4)
				local var_360_7 = var_360_5 <= 0 and var_360_1 or var_360_1 * (var_360_6 / var_360_5)

				if var_360_7 > 0 and var_360_1 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_8 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_8 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_8

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_8 and arg_357_1.time_ < var_360_0 + var_360_8 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play106601091 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 106601091
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play106601092(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.175

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[7].name)

				arg_361_1.leftNameTxt_.text = var_364_2

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

				local var_364_3 = arg_361_1:GetWordFromCfg(106601091)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 7
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_8 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_8 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_8

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_8 and arg_361_1.time_ < var_364_0 + var_364_8 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play106601092 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 106601092
		arg_365_1.duration_ = 3.5

		local var_365_0 = {
			ja = 3.5,
			ko = 2.733,
			en = 2.8
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
				arg_365_0:Play106601093(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1066ui_story"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1066ui_story == nil then
				arg_365_1.var_.characterEffect1066ui_story = var_368_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.1

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.characterEffect1066ui_story and not isNil(var_368_0) then
					arg_365_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1066ui_story then
				arg_365_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_368_4 = arg_365_1.actors_["1066ui_story"].transform
			local var_368_5 = 0

			if var_368_5 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 then
				arg_365_1.var_.moveOldPos1066ui_story = var_368_4.localPosition
			end

			local var_368_6 = 0.001

			if var_368_5 <= arg_365_1.time_ and arg_365_1.time_ < var_368_5 + var_368_6 then
				local var_368_7 = (arg_365_1.time_ - var_368_5) / var_368_6
				local var_368_8 = Vector3.New(0, -0.82, -5.5)

				var_368_4.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1066ui_story, var_368_8, var_368_7)

				local var_368_9 = manager.ui.mainCamera.transform.position - var_368_4.position

				var_368_4.forward = Vector3.New(var_368_9.x, var_368_9.y, var_368_9.z)

				local var_368_10 = var_368_4.localEulerAngles

				var_368_10.z = 0
				var_368_10.x = 0
				var_368_4.localEulerAngles = var_368_10
			end

			if arg_365_1.time_ >= var_368_5 + var_368_6 and arg_365_1.time_ < var_368_5 + var_368_6 + arg_368_0 then
				var_368_4.localPosition = Vector3.New(0, -0.82, -5.5)

				local var_368_11 = manager.ui.mainCamera.transform.position - var_368_4.position

				var_368_4.forward = Vector3.New(var_368_11.x, var_368_11.y, var_368_11.z)

				local var_368_12 = var_368_4.localEulerAngles

				var_368_12.z = 0
				var_368_12.x = 0
				var_368_4.localEulerAngles = var_368_12
			end

			local var_368_13 = 0

			if var_368_13 < arg_365_1.time_ and arg_365_1.time_ <= var_368_13 + arg_368_0 then
				arg_365_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			local var_368_14 = 0

			if var_368_14 < arg_365_1.time_ and arg_365_1.time_ <= var_368_14 + arg_368_0 then
				arg_365_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_368_15 = 0
			local var_368_16 = 0.225

			if var_368_15 < arg_365_1.time_ and arg_365_1.time_ <= var_368_15 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_17 = arg_365_1:FormatText(StoryNameCfg[32].name)

				arg_365_1.leftNameTxt_.text = var_368_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_18 = arg_365_1:GetWordFromCfg(106601092)
				local var_368_19 = arg_365_1:FormatText(var_368_18.content)

				arg_365_1.text_.text = var_368_19

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_20 = 9
				local var_368_21 = utf8.len(var_368_19)
				local var_368_22 = var_368_20 <= 0 and var_368_16 or var_368_16 * (var_368_21 / var_368_20)

				if var_368_22 > 0 and var_368_16 < var_368_22 then
					arg_365_1.talkMaxDuration = var_368_22

					if var_368_22 + var_368_15 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_22 + var_368_15
					end
				end

				arg_365_1.text_.text = var_368_19
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601092", "story_v_side_old_106601.awb") ~= 0 then
					local var_368_23 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601092", "story_v_side_old_106601.awb") / 1000

					if var_368_23 + var_368_15 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_23 + var_368_15
					end

					if var_368_18.prefab_name ~= "" and arg_365_1.actors_[var_368_18.prefab_name] ~= nil then
						local var_368_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_18.prefab_name].transform, "story_v_side_old_106601", "106601092", "story_v_side_old_106601.awb")

						arg_365_1:RecordAudio("106601092", var_368_24)
						arg_365_1:RecordAudio("106601092", var_368_24)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601092", "story_v_side_old_106601.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601092", "story_v_side_old_106601.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_25 = math.max(var_368_16, arg_365_1.talkMaxDuration)

			if var_368_15 <= arg_365_1.time_ and arg_365_1.time_ < var_368_15 + var_368_25 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_15) / var_368_25

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_15 + var_368_25 and arg_365_1.time_ < var_368_15 + var_368_25 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play106601093 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 106601093
		arg_369_1.duration_ = 3.3

		local var_369_0 = {
			ja = 3.3,
			ko = 1.999999999999,
			en = 1.999999999999
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play106601094(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action456")
			end

			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_372_2 = 0
			local var_372_3 = 0.1

			if var_372_2 < arg_369_1.time_ and arg_369_1.time_ <= var_372_2 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_4 = arg_369_1:FormatText(StoryNameCfg[32].name)

				arg_369_1.leftNameTxt_.text = var_372_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_5 = arg_369_1:GetWordFromCfg(106601093)
				local var_372_6 = arg_369_1:FormatText(var_372_5.content)

				arg_369_1.text_.text = var_372_6

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_7 = 4
				local var_372_8 = utf8.len(var_372_6)
				local var_372_9 = var_372_7 <= 0 and var_372_3 or var_372_3 * (var_372_8 / var_372_7)

				if var_372_9 > 0 and var_372_3 < var_372_9 then
					arg_369_1.talkMaxDuration = var_372_9

					if var_372_9 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_2
					end
				end

				arg_369_1.text_.text = var_372_6
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601093", "story_v_side_old_106601.awb") ~= 0 then
					local var_372_10 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601093", "story_v_side_old_106601.awb") / 1000

					if var_372_10 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_2
					end

					if var_372_5.prefab_name ~= "" and arg_369_1.actors_[var_372_5.prefab_name] ~= nil then
						local var_372_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_5.prefab_name].transform, "story_v_side_old_106601", "106601093", "story_v_side_old_106601.awb")

						arg_369_1:RecordAudio("106601093", var_372_11)
						arg_369_1:RecordAudio("106601093", var_372_11)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601093", "story_v_side_old_106601.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601093", "story_v_side_old_106601.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_12 = math.max(var_372_3, arg_369_1.talkMaxDuration)

			if var_372_2 <= arg_369_1.time_ and arg_369_1.time_ < var_372_2 + var_372_12 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_2) / var_372_12

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_2 + var_372_12 and arg_369_1.time_ < var_372_2 + var_372_12 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play106601094 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 106601094
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play106601095(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1066ui_story"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1066ui_story == nil then
				arg_373_1.var_.characterEffect1066ui_story = var_376_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.1

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.characterEffect1066ui_story and not isNil(var_376_0) then
					local var_376_4 = Mathf.Lerp(0, 0.5, var_376_3)

					arg_373_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1066ui_story.fillRatio = var_376_4
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1066ui_story then
				local var_376_5 = 0.5

				arg_373_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1066ui_story.fillRatio = var_376_5
			end

			local var_376_6 = 0
			local var_376_7 = 0.475

			if var_376_6 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_8 = arg_373_1:GetWordFromCfg(106601094)
				local var_376_9 = arg_373_1:FormatText(var_376_8.content)

				arg_373_1.text_.text = var_376_9

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_10 = 19
				local var_376_11 = utf8.len(var_376_9)
				local var_376_12 = var_376_10 <= 0 and var_376_7 or var_376_7 * (var_376_11 / var_376_10)

				if var_376_12 > 0 and var_376_7 < var_376_12 then
					arg_373_1.talkMaxDuration = var_376_12

					if var_376_12 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_12 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_9
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_13 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_13 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_13

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_13 and arg_373_1.time_ < var_376_6 + var_376_13 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play106601095 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 106601095
		arg_377_1.duration_ = 2.7

		local var_377_0 = {
			ja = 2.566,
			ko = 1.733,
			en = 2.7
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
				arg_377_0:Play106601096(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 0.2

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_2 = arg_377_1:FormatText(StoryNameCfg[138].name)

				arg_377_1.leftNameTxt_.text = var_380_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:GetWordFromCfg(106601095)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 8
				local var_380_6 = utf8.len(var_380_4)
				local var_380_7 = var_380_5 <= 0 and var_380_1 or var_380_1 * (var_380_6 / var_380_5)

				if var_380_7 > 0 and var_380_1 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601095", "story_v_side_old_106601.awb") ~= 0 then
					local var_380_8 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601095", "story_v_side_old_106601.awb") / 1000

					if var_380_8 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_0
					end

					if var_380_3.prefab_name ~= "" and arg_377_1.actors_[var_380_3.prefab_name] ~= nil then
						local var_380_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_3.prefab_name].transform, "story_v_side_old_106601", "106601095", "story_v_side_old_106601.awb")

						arg_377_1:RecordAudio("106601095", var_380_9)
						arg_377_1:RecordAudio("106601095", var_380_9)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601095", "story_v_side_old_106601.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601095", "story_v_side_old_106601.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_10 and arg_377_1.time_ < var_380_0 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play106601096 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 106601096
		arg_381_1.duration_ = 7.33

		local var_381_0 = {
			ja = 7.333,
			ko = 4.4,
			en = 5.466
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
				arg_381_0:Play106601097(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 0.45

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_2 = arg_381_1:FormatText(StoryNameCfg[138].name)

				arg_381_1.leftNameTxt_.text = var_384_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_3 = arg_381_1:GetWordFromCfg(106601096)
				local var_384_4 = arg_381_1:FormatText(var_384_3.content)

				arg_381_1.text_.text = var_384_4

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 18
				local var_384_6 = utf8.len(var_384_4)
				local var_384_7 = var_384_5 <= 0 and var_384_1 or var_384_1 * (var_384_6 / var_384_5)

				if var_384_7 > 0 and var_384_1 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_4
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601096", "story_v_side_old_106601.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601096", "story_v_side_old_106601.awb") / 1000

					if var_384_8 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_0
					end

					if var_384_3.prefab_name ~= "" and arg_381_1.actors_[var_384_3.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_3.prefab_name].transform, "story_v_side_old_106601", "106601096", "story_v_side_old_106601.awb")

						arg_381_1:RecordAudio("106601096", var_384_9)
						arg_381_1:RecordAudio("106601096", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601096", "story_v_side_old_106601.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601096", "story_v_side_old_106601.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_10 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_10 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_10

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_10 and arg_381_1.time_ < var_384_0 + var_384_10 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play106601097 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 106601097
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play106601098(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1066ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1066ui_story == nil then
				arg_385_1.var_.characterEffect1066ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.1

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect1066ui_story and not isNil(var_388_0) then
					arg_385_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1066ui_story then
				arg_385_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_388_4 = 0
			local var_388_5 = 0.675

			if var_388_4 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:GetWordFromCfg(106601097)
				local var_388_7 = arg_385_1:FormatText(var_388_6.content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_8 = 27
				local var_388_9 = utf8.len(var_388_7)
				local var_388_10 = var_388_8 <= 0 and var_388_5 or var_388_5 * (var_388_9 / var_388_8)

				if var_388_10 > 0 and var_388_5 < var_388_10 then
					arg_385_1.talkMaxDuration = var_388_10

					if var_388_10 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_11 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_11 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_11

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_11 and arg_385_1.time_ < var_388_4 + var_388_11 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play106601098 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 106601098
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play106601099(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 1.425

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_2 = arg_389_1:GetWordFromCfg(106601098)
				local var_392_3 = arg_389_1:FormatText(var_392_2.content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 57
				local var_392_5 = utf8.len(var_392_3)
				local var_392_6 = var_392_4 <= 0 and var_392_1 or var_392_1 * (var_392_5 / var_392_4)

				if var_392_6 > 0 and var_392_1 < var_392_6 then
					arg_389_1.talkMaxDuration = var_392_6

					if var_392_6 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_6 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_7 and arg_389_1.time_ < var_392_0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play106601099 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 106601099
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play106601100(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1066ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1066ui_story == nil then
				arg_393_1.var_.characterEffect1066ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.1

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect1066ui_story and not isNil(var_396_0) then
					local var_396_4 = Mathf.Lerp(0, 0.5, var_396_3)

					arg_393_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1066ui_story.fillRatio = var_396_4
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1066ui_story then
				local var_396_5 = 0.5

				arg_393_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1066ui_story.fillRatio = var_396_5
			end

			local var_396_6 = 0
			local var_396_7 = 0.6

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_8 = arg_393_1:FormatText(StoryNameCfg[7].name)

				arg_393_1.leftNameTxt_.text = var_396_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_9 = arg_393_1:GetWordFromCfg(106601099)
				local var_396_10 = arg_393_1:FormatText(var_396_9.content)

				arg_393_1.text_.text = var_396_10

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 24
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
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_14 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_14 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_14

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_14 and arg_393_1.time_ < var_396_6 + var_396_14 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play106601100 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 106601100
		arg_397_1.duration_ = 4.9

		local var_397_0 = {
			ja = 4.9,
			ko = 4.266,
			en = 4.366
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play106601101(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1066ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1066ui_story == nil then
				arg_397_1.var_.characterEffect1066ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.1

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1066ui_story and not isNil(var_400_0) then
					arg_397_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1066ui_story then
				arg_397_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_400_4 = 0

			if var_400_4 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action462")
			end

			local var_400_5 = 0

			if var_400_5 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_400_6 = 0
			local var_400_7 = 0.425

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_8 = arg_397_1:FormatText(StoryNameCfg[32].name)

				arg_397_1.leftNameTxt_.text = var_400_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_9 = arg_397_1:GetWordFromCfg(106601100)
				local var_400_10 = arg_397_1:FormatText(var_400_9.content)

				arg_397_1.text_.text = var_400_10

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_11 = 17
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

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601100", "story_v_side_old_106601.awb") ~= 0 then
					local var_400_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601100", "story_v_side_old_106601.awb") / 1000

					if var_400_14 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_14 + var_400_6
					end

					if var_400_9.prefab_name ~= "" and arg_397_1.actors_[var_400_9.prefab_name] ~= nil then
						local var_400_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_9.prefab_name].transform, "story_v_side_old_106601", "106601100", "story_v_side_old_106601.awb")

						arg_397_1:RecordAudio("106601100", var_400_15)
						arg_397_1:RecordAudio("106601100", var_400_15)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601100", "story_v_side_old_106601.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601100", "story_v_side_old_106601.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_16 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_16 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_16

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_16 and arg_397_1.time_ < var_400_6 + var_400_16 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play106601101 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 106601101
		arg_401_1.duration_ = 7.83

		local var_401_0 = {
			ja = 6.6,
			ko = 7.833,
			en = 7.233
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
				arg_401_0:Play106601102(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_404_1 = 0
			local var_404_2 = 1.175

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_3 = arg_401_1:FormatText(StoryNameCfg[32].name)

				arg_401_1.leftNameTxt_.text = var_404_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_4 = arg_401_1:GetWordFromCfg(106601101)
				local var_404_5 = arg_401_1:FormatText(var_404_4.content)

				arg_401_1.text_.text = var_404_5

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_6 = 47
				local var_404_7 = utf8.len(var_404_5)
				local var_404_8 = var_404_6 <= 0 and var_404_2 or var_404_2 * (var_404_7 / var_404_6)

				if var_404_8 > 0 and var_404_2 < var_404_8 then
					arg_401_1.talkMaxDuration = var_404_8

					if var_404_8 + var_404_1 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_1
					end
				end

				arg_401_1.text_.text = var_404_5
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601101", "story_v_side_old_106601.awb") ~= 0 then
					local var_404_9 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601101", "story_v_side_old_106601.awb") / 1000

					if var_404_9 + var_404_1 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_9 + var_404_1
					end

					if var_404_4.prefab_name ~= "" and arg_401_1.actors_[var_404_4.prefab_name] ~= nil then
						local var_404_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_4.prefab_name].transform, "story_v_side_old_106601", "106601101", "story_v_side_old_106601.awb")

						arg_401_1:RecordAudio("106601101", var_404_10)
						arg_401_1:RecordAudio("106601101", var_404_10)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601101", "story_v_side_old_106601.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601101", "story_v_side_old_106601.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_11 = math.max(var_404_2, arg_401_1.talkMaxDuration)

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_11 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_1) / var_404_11

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_1 + var_404_11 and arg_401_1.time_ < var_404_1 + var_404_11 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play106601102 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 106601102
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play106601103(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1066ui_story"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1066ui_story == nil then
				arg_405_1.var_.characterEffect1066ui_story = var_408_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.1

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.characterEffect1066ui_story and not isNil(var_408_0) then
					local var_408_4 = Mathf.Lerp(0, 0.5, var_408_3)

					arg_405_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1066ui_story.fillRatio = var_408_4
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1066ui_story then
				local var_408_5 = 0.5

				arg_405_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1066ui_story.fillRatio = var_408_5
			end

			local var_408_6 = 0
			local var_408_7 = 0.55

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

				local var_408_9 = arg_405_1:GetWordFromCfg(106601102)
				local var_408_10 = arg_405_1:FormatText(var_408_9.content)

				arg_405_1.text_.text = var_408_10

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 22
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
	Play106601103 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 106601103
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play106601104(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 0.525

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_2 = arg_409_1:GetWordFromCfg(106601103)
				local var_412_3 = arg_409_1:FormatText(var_412_2.content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_4 = 21
				local var_412_5 = utf8.len(var_412_3)
				local var_412_6 = var_412_4 <= 0 and var_412_1 or var_412_1 * (var_412_5 / var_412_4)

				if var_412_6 > 0 and var_412_1 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6

					if var_412_6 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_0
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_1, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_0) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_7 and arg_409_1.time_ < var_412_0 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play106601104 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 106601104
		arg_413_1.duration_ = 2.97

		local var_413_0 = {
			ja = 2.966,
			ko = 2.166,
			en = 2.5
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
				arg_413_0:Play106601105(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0
			local var_416_1 = 0.2

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_2 = arg_413_1:FormatText(StoryNameCfg[138].name)

				arg_413_1.leftNameTxt_.text = var_416_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_3 = arg_413_1:GetWordFromCfg(106601104)
				local var_416_4 = arg_413_1:FormatText(var_416_3.content)

				arg_413_1.text_.text = var_416_4

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 8
				local var_416_6 = utf8.len(var_416_4)
				local var_416_7 = var_416_5 <= 0 and var_416_1 or var_416_1 * (var_416_6 / var_416_5)

				if var_416_7 > 0 and var_416_1 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_0
					end
				end

				arg_413_1.text_.text = var_416_4
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601104", "story_v_side_old_106601.awb") ~= 0 then
					local var_416_8 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601104", "story_v_side_old_106601.awb") / 1000

					if var_416_8 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_8 + var_416_0
					end

					if var_416_3.prefab_name ~= "" and arg_413_1.actors_[var_416_3.prefab_name] ~= nil then
						local var_416_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_3.prefab_name].transform, "story_v_side_old_106601", "106601104", "story_v_side_old_106601.awb")

						arg_413_1:RecordAudio("106601104", var_416_9)
						arg_413_1:RecordAudio("106601104", var_416_9)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601104", "story_v_side_old_106601.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601104", "story_v_side_old_106601.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_10 = math.max(var_416_1, arg_413_1.talkMaxDuration)

			if var_416_0 <= arg_413_1.time_ and arg_413_1.time_ < var_416_0 + var_416_10 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_0) / var_416_10

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_0 + var_416_10 and arg_413_1.time_ < var_416_0 + var_416_10 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play106601105 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 106601105
		arg_417_1.duration_ = 2.43

		local var_417_0 = {
			ja = 1.9,
			ko = 2.366,
			en = 2.433
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play106601106(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0
			local var_420_1 = 0.175

			if var_420_0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_2 = arg_417_1:FormatText(StoryNameCfg[138].name)

				arg_417_1.leftNameTxt_.text = var_420_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:GetWordFromCfg(106601105)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 7
				local var_420_6 = utf8.len(var_420_4)
				local var_420_7 = var_420_5 <= 0 and var_420_1 or var_420_1 * (var_420_6 / var_420_5)

				if var_420_7 > 0 and var_420_1 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_0
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601105", "story_v_side_old_106601.awb") ~= 0 then
					local var_420_8 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601105", "story_v_side_old_106601.awb") / 1000

					if var_420_8 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_8 + var_420_0
					end

					if var_420_3.prefab_name ~= "" and arg_417_1.actors_[var_420_3.prefab_name] ~= nil then
						local var_420_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_3.prefab_name].transform, "story_v_side_old_106601", "106601105", "story_v_side_old_106601.awb")

						arg_417_1:RecordAudio("106601105", var_420_9)
						arg_417_1:RecordAudio("106601105", var_420_9)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601105", "story_v_side_old_106601.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601105", "story_v_side_old_106601.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_10 = math.max(var_420_1, arg_417_1.talkMaxDuration)

			if var_420_0 <= arg_417_1.time_ and arg_417_1.time_ < var_420_0 + var_420_10 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_0) / var_420_10

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_0 + var_420_10 and arg_417_1.time_ < var_420_0 + var_420_10 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play106601106 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 106601106
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play106601107(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0
			local var_424_1 = 1.025

			if var_424_0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_2 = arg_421_1:GetWordFromCfg(106601106)
				local var_424_3 = arg_421_1:FormatText(var_424_2.content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 41
				local var_424_5 = utf8.len(var_424_3)
				local var_424_6 = var_424_4 <= 0 and var_424_1 or var_424_1 * (var_424_5 / var_424_4)

				if var_424_6 > 0 and var_424_1 < var_424_6 then
					arg_421_1.talkMaxDuration = var_424_6

					if var_424_6 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_6 + var_424_0
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_1, arg_421_1.talkMaxDuration)

			if var_424_0 <= arg_421_1.time_ and arg_421_1.time_ < var_424_0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_0 + var_424_7 and arg_421_1.time_ < var_424_0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play106601107 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 106601107
		arg_425_1.duration_ = 7.4

		local var_425_0 = {
			ja = 3,
			ko = 7.4,
			en = 6.366
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play106601108(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1066ui_story"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1066ui_story == nil then
				arg_425_1.var_.characterEffect1066ui_story = var_428_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.1

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.characterEffect1066ui_story and not isNil(var_428_0) then
					arg_425_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1066ui_story then
				arg_425_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_428_4 = 0

			if var_428_4 < arg_425_1.time_ and arg_425_1.time_ <= var_428_4 + arg_428_0 then
				arg_425_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action425")
			end

			local var_428_5 = 0

			if var_428_5 < arg_425_1.time_ and arg_425_1.time_ <= var_428_5 + arg_428_0 then
				arg_425_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_428_6 = 0
			local var_428_7 = 0.65

			if var_428_6 < arg_425_1.time_ and arg_425_1.time_ <= var_428_6 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_8 = arg_425_1:FormatText(StoryNameCfg[32].name)

				arg_425_1.leftNameTxt_.text = var_428_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_9 = arg_425_1:GetWordFromCfg(106601107)
				local var_428_10 = arg_425_1:FormatText(var_428_9.content)

				arg_425_1.text_.text = var_428_10

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_11 = 26
				local var_428_12 = utf8.len(var_428_10)
				local var_428_13 = var_428_11 <= 0 and var_428_7 or var_428_7 * (var_428_12 / var_428_11)

				if var_428_13 > 0 and var_428_7 < var_428_13 then
					arg_425_1.talkMaxDuration = var_428_13

					if var_428_13 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_13 + var_428_6
					end
				end

				arg_425_1.text_.text = var_428_10
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601107", "story_v_side_old_106601.awb") ~= 0 then
					local var_428_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601107", "story_v_side_old_106601.awb") / 1000

					if var_428_14 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_14 + var_428_6
					end

					if var_428_9.prefab_name ~= "" and arg_425_1.actors_[var_428_9.prefab_name] ~= nil then
						local var_428_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_9.prefab_name].transform, "story_v_side_old_106601", "106601107", "story_v_side_old_106601.awb")

						arg_425_1:RecordAudio("106601107", var_428_15)
						arg_425_1:RecordAudio("106601107", var_428_15)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601107", "story_v_side_old_106601.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601107", "story_v_side_old_106601.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_16 = math.max(var_428_7, arg_425_1.talkMaxDuration)

			if var_428_6 <= arg_425_1.time_ and arg_425_1.time_ < var_428_6 + var_428_16 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_6) / var_428_16

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_6 + var_428_16 and arg_425_1.time_ < var_428_6 + var_428_16 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play106601108 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 106601108
		arg_429_1.duration_ = 1.9

		local var_429_0 = {
			ja = 1.3,
			ko = 1.9,
			en = 1.266
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play106601109(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["1066ui_story"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1066ui_story == nil then
				arg_429_1.var_.characterEffect1066ui_story = var_432_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.1

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.characterEffect1066ui_story and not isNil(var_432_0) then
					local var_432_4 = Mathf.Lerp(0, 0.5, var_432_3)

					arg_429_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1066ui_story.fillRatio = var_432_4
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1066ui_story then
				local var_432_5 = 0.5

				arg_429_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1066ui_story.fillRatio = var_432_5
			end

			local var_432_6 = 0
			local var_432_7 = 0.175

			if var_432_6 < arg_429_1.time_ and arg_429_1.time_ <= var_432_6 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_8 = arg_429_1:FormatText(StoryNameCfg[138].name)

				arg_429_1.leftNameTxt_.text = var_432_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_9 = arg_429_1:GetWordFromCfg(106601108)
				local var_432_10 = arg_429_1:FormatText(var_432_9.content)

				arg_429_1.text_.text = var_432_10

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_11 = 7
				local var_432_12 = utf8.len(var_432_10)
				local var_432_13 = var_432_11 <= 0 and var_432_7 or var_432_7 * (var_432_12 / var_432_11)

				if var_432_13 > 0 and var_432_7 < var_432_13 then
					arg_429_1.talkMaxDuration = var_432_13

					if var_432_13 + var_432_6 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_13 + var_432_6
					end
				end

				arg_429_1.text_.text = var_432_10
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601108", "story_v_side_old_106601.awb") ~= 0 then
					local var_432_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601108", "story_v_side_old_106601.awb") / 1000

					if var_432_14 + var_432_6 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_14 + var_432_6
					end

					if var_432_9.prefab_name ~= "" and arg_429_1.actors_[var_432_9.prefab_name] ~= nil then
						local var_432_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_9.prefab_name].transform, "story_v_side_old_106601", "106601108", "story_v_side_old_106601.awb")

						arg_429_1:RecordAudio("106601108", var_432_15)
						arg_429_1:RecordAudio("106601108", var_432_15)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601108", "story_v_side_old_106601.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601108", "story_v_side_old_106601.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_16 = math.max(var_432_7, arg_429_1.talkMaxDuration)

			if var_432_6 <= arg_429_1.time_ and arg_429_1.time_ < var_432_6 + var_432_16 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_6) / var_432_16

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_6 + var_432_16 and arg_429_1.time_ < var_432_6 + var_432_16 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play106601109 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 106601109
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play106601110(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0
			local var_436_1 = 0.325

			if var_436_0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_2 = arg_433_1:FormatText(StoryNameCfg[7].name)

				arg_433_1.leftNameTxt_.text = var_436_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_3 = arg_433_1:GetWordFromCfg(106601109)
				local var_436_4 = arg_433_1:FormatText(var_436_3.content)

				arg_433_1.text_.text = var_436_4

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 13
				local var_436_6 = utf8.len(var_436_4)
				local var_436_7 = var_436_5 <= 0 and var_436_1 or var_436_1 * (var_436_6 / var_436_5)

				if var_436_7 > 0 and var_436_1 < var_436_7 then
					arg_433_1.talkMaxDuration = var_436_7

					if var_436_7 + var_436_0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_7 + var_436_0
					end
				end

				arg_433_1.text_.text = var_436_4
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_8 = math.max(var_436_1, arg_433_1.talkMaxDuration)

			if var_436_0 <= arg_433_1.time_ and arg_433_1.time_ < var_436_0 + var_436_8 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_0) / var_436_8

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_0 + var_436_8 and arg_433_1.time_ < var_436_0 + var_436_8 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play106601110 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 106601110
		arg_437_1.duration_ = 11.13

		local var_437_0 = {
			ja = 10,
			ko = 9.5,
			en = 11.133
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play106601111(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["1066ui_story"]
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1066ui_story == nil then
				arg_437_1.var_.characterEffect1066ui_story = var_440_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.1

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 and not isNil(var_440_0) then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2

				if arg_437_1.var_.characterEffect1066ui_story and not isNil(var_440_0) then
					arg_437_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1066ui_story then
				arg_437_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_440_4 = 0

			if var_440_4 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action452")
			end

			local var_440_5 = 0

			if var_440_5 < arg_437_1.time_ and arg_437_1.time_ <= var_440_5 + arg_440_0 then
				arg_437_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_440_6 = 0
			local var_440_7 = 1.175

			if var_440_6 < arg_437_1.time_ and arg_437_1.time_ <= var_440_6 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_8 = arg_437_1:FormatText(StoryNameCfg[32].name)

				arg_437_1.leftNameTxt_.text = var_440_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_9 = arg_437_1:GetWordFromCfg(106601110)
				local var_440_10 = arg_437_1:FormatText(var_440_9.content)

				arg_437_1.text_.text = var_440_10

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_11 = 47
				local var_440_12 = utf8.len(var_440_10)
				local var_440_13 = var_440_11 <= 0 and var_440_7 or var_440_7 * (var_440_12 / var_440_11)

				if var_440_13 > 0 and var_440_7 < var_440_13 then
					arg_437_1.talkMaxDuration = var_440_13

					if var_440_13 + var_440_6 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_13 + var_440_6
					end
				end

				arg_437_1.text_.text = var_440_10
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601110", "story_v_side_old_106601.awb") ~= 0 then
					local var_440_14 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601110", "story_v_side_old_106601.awb") / 1000

					if var_440_14 + var_440_6 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_14 + var_440_6
					end

					if var_440_9.prefab_name ~= "" and arg_437_1.actors_[var_440_9.prefab_name] ~= nil then
						local var_440_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_9.prefab_name].transform, "story_v_side_old_106601", "106601110", "story_v_side_old_106601.awb")

						arg_437_1:RecordAudio("106601110", var_440_15)
						arg_437_1:RecordAudio("106601110", var_440_15)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601110", "story_v_side_old_106601.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601110", "story_v_side_old_106601.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_16 = math.max(var_440_7, arg_437_1.talkMaxDuration)

			if var_440_6 <= arg_437_1.time_ and arg_437_1.time_ < var_440_6 + var_440_16 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_6) / var_440_16

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_6 + var_440_16 and arg_437_1.time_ < var_440_6 + var_440_16 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play106601111 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 106601111
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play106601112(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 1.4

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_2 = arg_441_1:GetWordFromCfg(106601111)
				local var_444_3 = arg_441_1:FormatText(var_444_2.content)

				arg_441_1.text_.text = var_444_3

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_4 = 56
				local var_444_5 = utf8.len(var_444_3)
				local var_444_6 = var_444_4 <= 0 and var_444_1 or var_444_1 * (var_444_5 / var_444_4)

				if var_444_6 > 0 and var_444_1 < var_444_6 then
					arg_441_1.talkMaxDuration = var_444_6

					if var_444_6 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_6 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_3
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_7 and arg_441_1.time_ < var_444_0 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play106601112 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 106601112
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play106601113(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.9

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_2 = arg_445_1:GetWordFromCfg(106601112)
				local var_448_3 = arg_445_1:FormatText(var_448_2.content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 36
				local var_448_5 = utf8.len(var_448_3)
				local var_448_6 = var_448_4 <= 0 and var_448_1 or var_448_1 * (var_448_5 / var_448_4)

				if var_448_6 > 0 and var_448_1 < var_448_6 then
					arg_445_1.talkMaxDuration = var_448_6

					if var_448_6 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_6 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_7 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_7 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_7

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_7 and arg_445_1.time_ < var_448_0 + var_448_7 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play106601113 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 106601113
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play106601114(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["1066ui_story"]
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.characterEffect1066ui_story == nil then
				arg_449_1.var_.characterEffect1066ui_story = var_452_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.1

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 and not isNil(var_452_0) then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2

				if arg_449_1.var_.characterEffect1066ui_story and not isNil(var_452_0) then
					local var_452_4 = Mathf.Lerp(0, 0.5, var_452_3)

					arg_449_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1066ui_story.fillRatio = var_452_4
				end
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.characterEffect1066ui_story then
				local var_452_5 = 0.5

				arg_449_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1066ui_story.fillRatio = var_452_5
			end

			local var_452_6 = arg_449_1.actors_["1066ui_story"].transform
			local var_452_7 = 0

			if var_452_7 < arg_449_1.time_ and arg_449_1.time_ <= var_452_7 + arg_452_0 then
				arg_449_1.var_.moveOldPos1066ui_story = var_452_6.localPosition
			end

			local var_452_8 = 0.001

			if var_452_7 <= arg_449_1.time_ and arg_449_1.time_ < var_452_7 + var_452_8 then
				local var_452_9 = (arg_449_1.time_ - var_452_7) / var_452_8
				local var_452_10 = Vector3.New(30, -0.82, -5.5)

				var_452_6.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1066ui_story, var_452_10, var_452_9)

				local var_452_11 = manager.ui.mainCamera.transform.position - var_452_6.position

				var_452_6.forward = Vector3.New(var_452_11.x, var_452_11.y, var_452_11.z)

				local var_452_12 = var_452_6.localEulerAngles

				var_452_12.z = 0
				var_452_12.x = 0
				var_452_6.localEulerAngles = var_452_12
			end

			if arg_449_1.time_ >= var_452_7 + var_452_8 and arg_449_1.time_ < var_452_7 + var_452_8 + arg_452_0 then
				var_452_6.localPosition = Vector3.New(30, -0.82, -5.5)

				local var_452_13 = manager.ui.mainCamera.transform.position - var_452_6.position

				var_452_6.forward = Vector3.New(var_452_13.x, var_452_13.y, var_452_13.z)

				local var_452_14 = var_452_6.localEulerAngles

				var_452_14.z = 0
				var_452_14.x = 0
				var_452_6.localEulerAngles = var_452_14
			end

			local var_452_15 = 0
			local var_452_16 = 0.3

			if var_452_15 < arg_449_1.time_ and arg_449_1.time_ <= var_452_15 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_17 = arg_449_1:FormatText(StoryNameCfg[7].name)

				arg_449_1.leftNameTxt_.text = var_452_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_18 = arg_449_1:GetWordFromCfg(106601113)
				local var_452_19 = arg_449_1:FormatText(var_452_18.content)

				arg_449_1.text_.text = var_452_19

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_20 = 12
				local var_452_21 = utf8.len(var_452_19)
				local var_452_22 = var_452_20 <= 0 and var_452_16 or var_452_16 * (var_452_21 / var_452_20)

				if var_452_22 > 0 and var_452_16 < var_452_22 then
					arg_449_1.talkMaxDuration = var_452_22

					if var_452_22 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_22 + var_452_15
					end
				end

				arg_449_1.text_.text = var_452_19
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_23 = math.max(var_452_16, arg_449_1.talkMaxDuration)

			if var_452_15 <= arg_449_1.time_ and arg_449_1.time_ < var_452_15 + var_452_23 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_15) / var_452_23

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_15 + var_452_23 and arg_449_1.time_ < var_452_15 + var_452_23 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play106601114 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 106601114
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play106601115(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 0.75

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_2 = arg_453_1:GetWordFromCfg(106601114)
				local var_456_3 = arg_453_1:FormatText(var_456_2.content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 30
				local var_456_5 = utf8.len(var_456_3)
				local var_456_6 = var_456_4 <= 0 and var_456_1 or var_456_1 * (var_456_5 / var_456_4)

				if var_456_6 > 0 and var_456_1 < var_456_6 then
					arg_453_1.talkMaxDuration = var_456_6

					if var_456_6 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_7 and arg_453_1.time_ < var_456_0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play106601115 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 106601115
		arg_457_1.duration_ = 3.23

		local var_457_0 = {
			ja = 3.233,
			ko = 2.266,
			en = 1.8
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play106601116(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.325

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_2 = arg_457_1:FormatText(StoryNameCfg[139].name)

				arg_457_1.leftNameTxt_.text = var_460_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:GetWordFromCfg(106601115)
				local var_460_4 = arg_457_1:FormatText(var_460_3.content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 13
				local var_460_6 = utf8.len(var_460_4)
				local var_460_7 = var_460_5 <= 0 and var_460_1 or var_460_1 * (var_460_6 / var_460_5)

				if var_460_7 > 0 and var_460_1 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_4
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601115", "story_v_side_old_106601.awb") ~= 0 then
					local var_460_8 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601115", "story_v_side_old_106601.awb") / 1000

					if var_460_8 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_8 + var_460_0
					end

					if var_460_3.prefab_name ~= "" and arg_457_1.actors_[var_460_3.prefab_name] ~= nil then
						local var_460_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_3.prefab_name].transform, "story_v_side_old_106601", "106601115", "story_v_side_old_106601.awb")

						arg_457_1:RecordAudio("106601115", var_460_9)
						arg_457_1:RecordAudio("106601115", var_460_9)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601115", "story_v_side_old_106601.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601115", "story_v_side_old_106601.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_10 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_10 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_10

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_10 and arg_457_1.time_ < var_460_0 + var_460_10 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play106601116 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 106601116
		arg_461_1.duration_ = 4.3

		local var_461_0 = {
			ja = 3.833,
			ko = 4.3,
			en = 3.566
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play106601117(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 0.55

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_2 = arg_461_1:FormatText(StoryNameCfg[139].name)

				arg_461_1.leftNameTxt_.text = var_464_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:GetWordFromCfg(106601116)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 22
				local var_464_6 = utf8.len(var_464_4)
				local var_464_7 = var_464_5 <= 0 and var_464_1 or var_464_1 * (var_464_6 / var_464_5)

				if var_464_7 > 0 and var_464_1 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601116", "story_v_side_old_106601.awb") ~= 0 then
					local var_464_8 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601116", "story_v_side_old_106601.awb") / 1000

					if var_464_8 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_8 + var_464_0
					end

					if var_464_3.prefab_name ~= "" and arg_461_1.actors_[var_464_3.prefab_name] ~= nil then
						local var_464_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_3.prefab_name].transform, "story_v_side_old_106601", "106601116", "story_v_side_old_106601.awb")

						arg_461_1:RecordAudio("106601116", var_464_9)
						arg_461_1:RecordAudio("106601116", var_464_9)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601116", "story_v_side_old_106601.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601116", "story_v_side_old_106601.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_10 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_10 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_10

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_10 and arg_461_1.time_ < var_464_0 + var_464_10 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play106601117 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 106601117
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play106601118(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 0.075

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_2 = arg_465_1:FormatText(StoryNameCfg[7].name)

				arg_465_1.leftNameTxt_.text = var_468_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_3 = arg_465_1:GetWordFromCfg(106601117)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 3
				local var_468_6 = utf8.len(var_468_4)
				local var_468_7 = var_468_5 <= 0 and var_468_1 or var_468_1 * (var_468_6 / var_468_5)

				if var_468_7 > 0 and var_468_1 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_8 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_8 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_8

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_8 and arg_465_1.time_ < var_468_0 + var_468_8 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play106601118 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 106601118
		arg_469_1.duration_ = 2.5

		local var_469_0 = {
			ja = 2.3,
			ko = 2.5,
			en = 2.2
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play106601119(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["1066ui_story"]
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1066ui_story == nil then
				arg_469_1.var_.characterEffect1066ui_story = var_472_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.1

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 and not isNil(var_472_0) then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2

				if arg_469_1.var_.characterEffect1066ui_story and not isNil(var_472_0) then
					arg_469_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1066ui_story then
				arg_469_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_472_4 = arg_469_1.actors_["1066ui_story"].transform
			local var_472_5 = 0

			if var_472_5 < arg_469_1.time_ and arg_469_1.time_ <= var_472_5 + arg_472_0 then
				arg_469_1.var_.moveOldPos1066ui_story = var_472_4.localPosition
			end

			local var_472_6 = 0.001

			if var_472_5 <= arg_469_1.time_ and arg_469_1.time_ < var_472_5 + var_472_6 then
				local var_472_7 = (arg_469_1.time_ - var_472_5) / var_472_6
				local var_472_8 = Vector3.New(0, -0.82, -5.5)

				var_472_4.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1066ui_story, var_472_8, var_472_7)

				local var_472_9 = manager.ui.mainCamera.transform.position - var_472_4.position

				var_472_4.forward = Vector3.New(var_472_9.x, var_472_9.y, var_472_9.z)

				local var_472_10 = var_472_4.localEulerAngles

				var_472_10.z = 0
				var_472_10.x = 0
				var_472_4.localEulerAngles = var_472_10
			end

			if arg_469_1.time_ >= var_472_5 + var_472_6 and arg_469_1.time_ < var_472_5 + var_472_6 + arg_472_0 then
				var_472_4.localPosition = Vector3.New(0, -0.82, -5.5)

				local var_472_11 = manager.ui.mainCamera.transform.position - var_472_4.position

				var_472_4.forward = Vector3.New(var_472_11.x, var_472_11.y, var_472_11.z)

				local var_472_12 = var_472_4.localEulerAngles

				var_472_12.z = 0
				var_472_12.x = 0
				var_472_4.localEulerAngles = var_472_12
			end

			local var_472_13 = 0

			if var_472_13 < arg_469_1.time_ and arg_469_1.time_ <= var_472_13 + arg_472_0 then
				arg_469_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_472_14 = 0

			if var_472_14 < arg_469_1.time_ and arg_469_1.time_ <= var_472_14 + arg_472_0 then
				arg_469_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_472_15 = 0
			local var_472_16 = 0.25

			if var_472_15 < arg_469_1.time_ and arg_469_1.time_ <= var_472_15 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_17 = arg_469_1:FormatText(StoryNameCfg[32].name)

				arg_469_1.leftNameTxt_.text = var_472_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_18 = arg_469_1:GetWordFromCfg(106601118)
				local var_472_19 = arg_469_1:FormatText(var_472_18.content)

				arg_469_1.text_.text = var_472_19

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_20 = 10
				local var_472_21 = utf8.len(var_472_19)
				local var_472_22 = var_472_20 <= 0 and var_472_16 or var_472_16 * (var_472_21 / var_472_20)

				if var_472_22 > 0 and var_472_16 < var_472_22 then
					arg_469_1.talkMaxDuration = var_472_22

					if var_472_22 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_22 + var_472_15
					end
				end

				arg_469_1.text_.text = var_472_19
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601118", "story_v_side_old_106601.awb") ~= 0 then
					local var_472_23 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601118", "story_v_side_old_106601.awb") / 1000

					if var_472_23 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_23 + var_472_15
					end

					if var_472_18.prefab_name ~= "" and arg_469_1.actors_[var_472_18.prefab_name] ~= nil then
						local var_472_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_18.prefab_name].transform, "story_v_side_old_106601", "106601118", "story_v_side_old_106601.awb")

						arg_469_1:RecordAudio("106601118", var_472_24)
						arg_469_1:RecordAudio("106601118", var_472_24)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601118", "story_v_side_old_106601.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601118", "story_v_side_old_106601.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_25 = math.max(var_472_16, arg_469_1.talkMaxDuration)

			if var_472_15 <= arg_469_1.time_ and arg_469_1.time_ < var_472_15 + var_472_25 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_15) / var_472_25

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_15 + var_472_25 and arg_469_1.time_ < var_472_15 + var_472_25 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play106601119 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 106601119
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play106601120(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["1066ui_story"]
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect1066ui_story == nil then
				arg_473_1.var_.characterEffect1066ui_story = var_476_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.1

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 and not isNil(var_476_0) then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2

				if arg_473_1.var_.characterEffect1066ui_story and not isNil(var_476_0) then
					local var_476_4 = Mathf.Lerp(0, 0.5, var_476_3)

					arg_473_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1066ui_story.fillRatio = var_476_4
				end
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect1066ui_story then
				local var_476_5 = 0.5

				arg_473_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1066ui_story.fillRatio = var_476_5
			end

			local var_476_6 = 0
			local var_476_7 = 0.475

			if var_476_6 < arg_473_1.time_ and arg_473_1.time_ <= var_476_6 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_8 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_9 = arg_473_1:GetWordFromCfg(106601119)
				local var_476_10 = arg_473_1:FormatText(var_476_9.content)

				arg_473_1.text_.text = var_476_10

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_11 = 19
				local var_476_12 = utf8.len(var_476_10)
				local var_476_13 = var_476_11 <= 0 and var_476_7 or var_476_7 * (var_476_12 / var_476_11)

				if var_476_13 > 0 and var_476_7 < var_476_13 then
					arg_473_1.talkMaxDuration = var_476_13

					if var_476_13 + var_476_6 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_13 + var_476_6
					end
				end

				arg_473_1.text_.text = var_476_10
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_14 = math.max(var_476_7, arg_473_1.talkMaxDuration)

			if var_476_6 <= arg_473_1.time_ and arg_473_1.time_ < var_476_6 + var_476_14 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_6) / var_476_14

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_6 + var_476_14 and arg_473_1.time_ < var_476_6 + var_476_14 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play106601120 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 106601120
		arg_477_1.duration_ = 1.13

		local var_477_0 = {
			ja = 1.133,
			ko = 0.999999999999,
			en = 0.999999999999
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play106601121(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["1066ui_story"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect1066ui_story == nil then
				arg_477_1.var_.characterEffect1066ui_story = var_480_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.1

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.characterEffect1066ui_story and not isNil(var_480_0) then
					arg_477_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect1066ui_story then
				arg_477_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_480_4 = 0

			if var_480_4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_480_5 = 0
			local var_480_6 = 0.075

			if var_480_5 < arg_477_1.time_ and arg_477_1.time_ <= var_480_5 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_7 = arg_477_1:FormatText(StoryNameCfg[32].name)

				arg_477_1.leftNameTxt_.text = var_480_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_8 = arg_477_1:GetWordFromCfg(106601120)
				local var_480_9 = arg_477_1:FormatText(var_480_8.content)

				arg_477_1.text_.text = var_480_9

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_10 = 3
				local var_480_11 = utf8.len(var_480_9)
				local var_480_12 = var_480_10 <= 0 and var_480_6 or var_480_6 * (var_480_11 / var_480_10)

				if var_480_12 > 0 and var_480_6 < var_480_12 then
					arg_477_1.talkMaxDuration = var_480_12

					if var_480_12 + var_480_5 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_12 + var_480_5
					end
				end

				arg_477_1.text_.text = var_480_9
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601120", "story_v_side_old_106601.awb") ~= 0 then
					local var_480_13 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601120", "story_v_side_old_106601.awb") / 1000

					if var_480_13 + var_480_5 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_13 + var_480_5
					end

					if var_480_8.prefab_name ~= "" and arg_477_1.actors_[var_480_8.prefab_name] ~= nil then
						local var_480_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_8.prefab_name].transform, "story_v_side_old_106601", "106601120", "story_v_side_old_106601.awb")

						arg_477_1:RecordAudio("106601120", var_480_14)
						arg_477_1:RecordAudio("106601120", var_480_14)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601120", "story_v_side_old_106601.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601120", "story_v_side_old_106601.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_15 = math.max(var_480_6, arg_477_1.talkMaxDuration)

			if var_480_5 <= arg_477_1.time_ and arg_477_1.time_ < var_480_5 + var_480_15 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_5) / var_480_15

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_5 + var_480_15 and arg_477_1.time_ < var_480_5 + var_480_15 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play106601121 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 106601121
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play106601122(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 1.2

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_2 = arg_481_1:GetWordFromCfg(106601121)
				local var_484_3 = arg_481_1:FormatText(var_484_2.content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 49
				local var_484_5 = utf8.len(var_484_3)
				local var_484_6 = var_484_4 <= 0 and var_484_1 or var_484_1 * (var_484_5 / var_484_4)

				if var_484_6 > 0 and var_484_1 < var_484_6 then
					arg_481_1.talkMaxDuration = var_484_6

					if var_484_6 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_6 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_3
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_7 and arg_481_1.time_ < var_484_0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play106601122 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 106601122
		arg_485_1.duration_ = 8.58

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play106601123(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action446")
			end

			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_488_2 = 0
			local var_488_3 = 0.15

			if var_488_2 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_4 = arg_485_1:FormatText(StoryNameCfg[32].name)

				arg_485_1.leftNameTxt_.text = var_488_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_5 = arg_485_1:GetWordFromCfg(106601122)
				local var_488_6 = arg_485_1:FormatText(var_488_5.content)

				arg_485_1.text_.text = var_488_6

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 6
				local var_488_8 = utf8.len(var_488_6)
				local var_488_9 = var_488_7 <= 0 and var_488_3 or var_488_3 * (var_488_8 / var_488_7)

				if var_488_9 > 0 and var_488_3 < var_488_9 then
					arg_485_1.talkMaxDuration = var_488_9

					if var_488_9 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_9 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_6
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601122", "story_v_side_old_106601.awb") ~= 0 then
					local var_488_10 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601122", "story_v_side_old_106601.awb") / 1000

					if var_488_10 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_10 + var_488_2
					end

					if var_488_5.prefab_name ~= "" and arg_485_1.actors_[var_488_5.prefab_name] ~= nil then
						local var_488_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_5.prefab_name].transform, "story_v_side_old_106601", "106601122", "story_v_side_old_106601.awb")

						arg_485_1:RecordAudio("106601122", var_488_11)
						arg_485_1:RecordAudio("106601122", var_488_11)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601122", "story_v_side_old_106601.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601122", "story_v_side_old_106601.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_12 = math.max(var_488_3, arg_485_1.talkMaxDuration)

			if var_488_2 <= arg_485_1.time_ and arg_485_1.time_ < var_488_2 + var_488_12 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_2) / var_488_12

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_2 + var_488_12 and arg_485_1.time_ < var_488_2 + var_488_12 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play106601123 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 106601123
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play106601124(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["1066ui_story"]
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1066ui_story == nil then
				arg_489_1.var_.characterEffect1066ui_story = var_492_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_2 = 0.1

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 and not isNil(var_492_0) then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2

				if arg_489_1.var_.characterEffect1066ui_story and not isNil(var_492_0) then
					local var_492_4 = Mathf.Lerp(0, 0.5, var_492_3)

					arg_489_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1066ui_story.fillRatio = var_492_4
				end
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1066ui_story then
				local var_492_5 = 0.5

				arg_489_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1066ui_story.fillRatio = var_492_5
			end

			local var_492_6 = 0
			local var_492_7 = 1.3

			if var_492_6 < arg_489_1.time_ and arg_489_1.time_ <= var_492_6 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_8 = arg_489_1:GetWordFromCfg(106601123)
				local var_492_9 = arg_489_1:FormatText(var_492_8.content)

				arg_489_1.text_.text = var_492_9

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_10 = 52
				local var_492_11 = utf8.len(var_492_9)
				local var_492_12 = var_492_10 <= 0 and var_492_7 or var_492_7 * (var_492_11 / var_492_10)

				if var_492_12 > 0 and var_492_7 < var_492_12 then
					arg_489_1.talkMaxDuration = var_492_12

					if var_492_12 + var_492_6 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_12 + var_492_6
					end
				end

				arg_489_1.text_.text = var_492_9
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_13 = math.max(var_492_7, arg_489_1.talkMaxDuration)

			if var_492_6 <= arg_489_1.time_ and arg_489_1.time_ < var_492_6 + var_492_13 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_6) / var_492_13

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_6 + var_492_13 and arg_489_1.time_ < var_492_6 + var_492_13 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play106601124 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 106601124
		arg_493_1.duration_ = 2.2

		local var_493_0 = {
			ja = 1.333,
			ko = 1.866,
			en = 2.2
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
			arg_493_1.auto_ = false
		end

		function arg_493_1.playNext_(arg_495_0)
			arg_493_1.onStoryFinished_()
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0
			local var_496_1 = 0.125

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_2 = arg_493_1:FormatText(StoryNameCfg[138].name)

				arg_493_1.leftNameTxt_.text = var_496_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_3 = arg_493_1:GetWordFromCfg(106601124)
				local var_496_4 = arg_493_1:FormatText(var_496_3.content)

				arg_493_1.text_.text = var_496_4

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_5 = 5
				local var_496_6 = utf8.len(var_496_4)
				local var_496_7 = var_496_5 <= 0 and var_496_1 or var_496_1 * (var_496_6 / var_496_5)

				if var_496_7 > 0 and var_496_1 < var_496_7 then
					arg_493_1.talkMaxDuration = var_496_7

					if var_496_7 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_7 + var_496_0
					end
				end

				arg_493_1.text_.text = var_496_4
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601124", "story_v_side_old_106601.awb") ~= 0 then
					local var_496_8 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601124", "story_v_side_old_106601.awb") / 1000

					if var_496_8 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_8 + var_496_0
					end

					if var_496_3.prefab_name ~= "" and arg_493_1.actors_[var_496_3.prefab_name] ~= nil then
						local var_496_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_3.prefab_name].transform, "story_v_side_old_106601", "106601124", "story_v_side_old_106601.awb")

						arg_493_1:RecordAudio("106601124", var_496_9)
						arg_493_1:RecordAudio("106601124", var_496_9)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601124", "story_v_side_old_106601.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601124", "story_v_side_old_106601.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_10 = math.max(var_496_1, arg_493_1.talkMaxDuration)

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_10 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_0) / var_496_10

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_0 + var_496_10 and arg_493_1.time_ < var_496_0 + var_496_10 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play106601015 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 106601015
		arg_497_1.duration_ = 5

		local var_497_0 = {
			ja = 5,
			ko = 2.233,
			en = 3.033
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play106601016(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["1066ui_story"]
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1066ui_story == nil then
				arg_497_1.var_.characterEffect1066ui_story = var_500_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.1

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 and not isNil(var_500_0) then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2

				if arg_497_1.var_.characterEffect1066ui_story and not isNil(var_500_0) then
					arg_497_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1066ui_story then
				arg_497_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_500_4 = "1066ui_story"

			if arg_497_1.actors_[var_500_4] == nil then
				local var_500_5 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_500_5) then
					local var_500_6 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_497_1.stage_.transform)

					var_500_6.name = var_500_4
					var_500_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_497_1.actors_[var_500_4] = var_500_6

					local var_500_7 = var_500_6:GetComponentInChildren(typeof(CharacterEffect))

					var_500_7.enabled = true

					local var_500_8 = GameObjectTools.GetOrAddComponent(var_500_6, typeof(DynamicBoneHelper))

					if var_500_8 then
						var_500_8:EnableDynamicBone(false)
					end

					arg_497_1:ShowWeapon(var_500_7.transform, false)

					arg_497_1.var_[var_500_4 .. "Animator"] = var_500_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_497_1.var_[var_500_4 .. "Animator"].applyRootMotion = true
					arg_497_1.var_[var_500_4 .. "LipSync"] = var_500_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_500_9 = 0

			if var_500_9 < arg_497_1.time_ and arg_497_1.time_ <= var_500_9 + arg_500_0 then
				arg_497_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action424")
			end

			local var_500_10 = "1066ui_story"

			if arg_497_1.actors_[var_500_10] == nil then
				local var_500_11 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_500_11) then
					local var_500_12 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_497_1.stage_.transform)

					var_500_12.name = var_500_10
					var_500_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_497_1.actors_[var_500_10] = var_500_12

					local var_500_13 = var_500_12:GetComponentInChildren(typeof(CharacterEffect))

					var_500_13.enabled = true

					local var_500_14 = GameObjectTools.GetOrAddComponent(var_500_12, typeof(DynamicBoneHelper))

					if var_500_14 then
						var_500_14:EnableDynamicBone(false)
					end

					arg_497_1:ShowWeapon(var_500_13.transform, false)

					arg_497_1.var_[var_500_10 .. "Animator"] = var_500_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_497_1.var_[var_500_10 .. "Animator"].applyRootMotion = true
					arg_497_1.var_[var_500_10 .. "LipSync"] = var_500_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_500_15 = 0

			if var_500_15 < arg_497_1.time_ and arg_497_1.time_ <= var_500_15 + arg_500_0 then
				arg_497_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_500_16 = 0
			local var_500_17 = 0.275

			if var_500_16 < arg_497_1.time_ and arg_497_1.time_ <= var_500_16 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_18 = arg_497_1:FormatText(StoryNameCfg[32].name)

				arg_497_1.leftNameTxt_.text = var_500_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_19 = arg_497_1:GetWordFromCfg(106601015)
				local var_500_20 = arg_497_1:FormatText(var_500_19.content)

				arg_497_1.text_.text = var_500_20

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_21 = 11
				local var_500_22 = utf8.len(var_500_20)
				local var_500_23 = var_500_21 <= 0 and var_500_17 or var_500_17 * (var_500_22 / var_500_21)

				if var_500_23 > 0 and var_500_17 < var_500_23 then
					arg_497_1.talkMaxDuration = var_500_23

					if var_500_23 + var_500_16 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_23 + var_500_16
					end
				end

				arg_497_1.text_.text = var_500_20
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_106601", "106601015", "story_v_side_old_106601.awb") ~= 0 then
					local var_500_24 = manager.audio:GetVoiceLength("story_v_side_old_106601", "106601015", "story_v_side_old_106601.awb") / 1000

					if var_500_24 + var_500_16 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_24 + var_500_16
					end

					if var_500_19.prefab_name ~= "" and arg_497_1.actors_[var_500_19.prefab_name] ~= nil then
						local var_500_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_19.prefab_name].transform, "story_v_side_old_106601", "106601015", "story_v_side_old_106601.awb")

						arg_497_1:RecordAudio("106601015", var_500_25)
						arg_497_1:RecordAudio("106601015", var_500_25)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_old_106601", "106601015", "story_v_side_old_106601.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_old_106601", "106601015", "story_v_side_old_106601.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_26 = math.max(var_500_17, arg_497_1.talkMaxDuration)

			if var_500_16 <= arg_497_1.time_ and arg_497_1.time_ < var_500_16 + var_500_26 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_16) / var_500_26

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_16 + var_500_26 and arg_497_1.time_ < var_500_16 + var_500_26 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10d",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_side_old_106601.awb"
	}
}
