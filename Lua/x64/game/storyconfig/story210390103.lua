return {
	Play103903001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103903001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play103903002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_6 = "ST03"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = 0

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				local var_4_9 = manager.ui.mainCamera.transform.localPosition
				local var_4_10 = Vector3.New(0, 0, 10) + Vector3.New(var_4_9.x, var_4_9.y, 0)
				local var_4_11 = arg_1_1.bgs_.ST03

				var_4_11.transform.localPosition = var_4_10
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = (var_4_11.transform.localPosition - var_4_9).z
					local var_4_14 = manager.ui.mainCameraCom_
					local var_4_15 = 2 * var_4_13 * Mathf.Tan(var_4_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_16 = var_4_15 * var_4_14.aspect
					local var_4_17 = var_4_12.sprite.bounds.size.x
					local var_4_18 = var_4_12.sprite.bounds.size.y
					local var_4_19 = var_4_16 / var_4_17
					local var_4_20 = var_4_15 / var_4_18
					local var_4_21 = var_4_20 < var_4_19 and var_4_19 or var_4_20

					var_4_11.transform.localScale = Vector3.New(var_4_21, var_4_21, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST03" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_22 = 0
			local var_4_23 = 0.9

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_25 = arg_1_1:GetWordFromCfg(103903001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 36
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
	Play103903002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103903002
		arg_8_1.duration_ = 3.7

		local var_8_0 = {
			ja = 3.7,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_8_0:Play103903003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "music"

				arg_8_1:AudioAction(var_11_2, var_11_3, "bgm_story_mood_daily", "bgm_story_mood_daily", "bgm_story_mood_daily")

				local var_11_4 = ""
				local var_11_5 = manager.audio:GetAudioName("bgm_story_mood_daily", "bgm_story_mood_daily")

				if var_11_5 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_5 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_5

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_5
						arg_8_1.bgmTxt2_.text = var_11_5
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_6 = "1039ui_story"

			if arg_8_1.actors_[var_11_6] == nil then
				local var_11_7 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_11_7) then
					local var_11_8 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_8_1.stage_.transform)

					var_11_8.name = var_11_6
					var_11_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_6] = var_11_8

					local var_11_9 = var_11_8:GetComponentInChildren(typeof(CharacterEffect))

					var_11_9.enabled = true

					local var_11_10 = GameObjectTools.GetOrAddComponent(var_11_8, typeof(DynamicBoneHelper))

					if var_11_10 then
						var_11_10:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_9.transform, false)

					arg_8_1.var_[var_11_6 .. "Animator"] = var_11_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_6 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_6 .. "LipSync"] = var_11_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_11 = arg_8_1.actors_["1039ui_story"]
			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect1039ui_story == nil then
				arg_8_1.var_.characterEffect1039ui_story = var_11_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_13 = 0.1

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 and not isNil(var_11_11) then
				local var_11_14 = (arg_8_1.time_ - var_11_12) / var_11_13

				if arg_8_1.var_.characterEffect1039ui_story and not isNil(var_11_11) then
					arg_8_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 and not isNil(var_11_11) and arg_8_1.var_.characterEffect1039ui_story then
				arg_8_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_11_15 = arg_8_1.actors_["1039ui_story"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos1039ui_story = var_11_15.localPosition
			end

			local var_11_17 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17
				local var_11_19 = Vector3.New(0, -1.06, -5.3)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1039ui_story, var_11_19, var_11_18)

				local var_11_20 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_20.x, var_11_20.y, var_11_20.z)

				local var_11_21 = var_11_15.localEulerAngles

				var_11_21.z = 0
				var_11_21.x = 0
				var_11_15.localEulerAngles = var_11_21
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_11_22 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_22.x, var_11_22.y, var_11_22.z)

				local var_11_23 = var_11_15.localEulerAngles

				var_11_23.z = 0
				var_11_23.x = 0
				var_11_15.localEulerAngles = var_11_23
			end

			local var_11_24 = 0

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			local var_11_25 = 0

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				arg_8_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_11_26 = 0
			local var_11_27 = 0.175

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_28 = arg_8_1:FormatText(StoryNameCfg[9].name)

				arg_8_1.leftNameTxt_.text = var_11_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_29 = arg_8_1:GetWordFromCfg(103903002)
				local var_11_30 = arg_8_1:FormatText(var_11_29.content)

				arg_8_1.text_.text = var_11_30

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_31 = 7
				local var_11_32 = utf8.len(var_11_30)
				local var_11_33 = var_11_31 <= 0 and var_11_27 or var_11_27 * (var_11_32 / var_11_31)

				if var_11_33 > 0 and var_11_27 < var_11_33 then
					arg_8_1.talkMaxDuration = var_11_33

					if var_11_33 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_33 + var_11_26
					end
				end

				arg_8_1.text_.text = var_11_30
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb") ~= 0 then
					local var_11_34 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb") / 1000

					if var_11_34 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_26
					end

					if var_11_29.prefab_name ~= "" and arg_8_1.actors_[var_11_29.prefab_name] ~= nil then
						local var_11_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_29.prefab_name].transform, "story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb")

						arg_8_1:RecordAudio("103903002", var_11_35)
						arg_8_1:RecordAudio("103903002", var_11_35)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_36 = math.max(var_11_27, arg_8_1.talkMaxDuration)

			if var_11_26 <= arg_8_1.time_ and arg_8_1.time_ < var_11_26 + var_11_36 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_26) / var_11_36

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_26 + var_11_36 and arg_8_1.time_ < var_11_26 + var_11_36 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
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
	Play103903003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 103903003
		arg_13_1.duration_ = 4.6

		local var_13_0 = {
			ja = 4.6,
			ko = 3.366,
			zh = 3.366,
			en = 4.066
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
				arg_13_0:Play103903004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_16_1 = 0
			local var_16_2 = 0.4

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_3 = arg_13_1:FormatText(StoryNameCfg[9].name)

				arg_13_1.leftNameTxt_.text = var_16_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(103903003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 16
				local var_16_7 = utf8.len(var_16_5)
				local var_16_8 = var_16_6 <= 0 and var_16_2 or var_16_2 * (var_16_7 / var_16_6)

				if var_16_8 > 0 and var_16_2 < var_16_8 then
					arg_13_1.talkMaxDuration = var_16_8

					if var_16_8 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb") ~= 0 then
					local var_16_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb") / 1000

					if var_16_9 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_1
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb")

						arg_13_1:RecordAudio("103903003", var_16_10)
						arg_13_1:RecordAudio("103903003", var_16_10)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_11 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_11 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_11

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_11 and arg_13_1.time_ < var_16_1 + var_16_11 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play103903004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 103903004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play103903005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1039ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1039ui_story == nil then
				arg_17_1.var_.characterEffect1039ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.1

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1039ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1039ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1039ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1039ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.95

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(103903004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 38
				local var_20_11 = utf8.len(var_20_9)
				local var_20_12 = var_20_10 <= 0 and var_20_7 or var_20_7 * (var_20_11 / var_20_10)

				if var_20_12 > 0 and var_20_7 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_13 and arg_17_1.time_ < var_20_6 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play103903005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 103903005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play103903006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.7

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

				local var_24_2 = arg_21_1:GetWordFromCfg(103903005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 28
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
	Play103903006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 103903006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play103903007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.3

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(103903006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 12
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play103903007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 103903007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play103903008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.525

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(103903007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 21
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play103903008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 103903008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play103903009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.175

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

				local var_36_2 = arg_33_1:GetWordFromCfg(103903008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 47
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
	Play103903009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 103903009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play103903010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.825

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_2

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

				local var_40_3 = arg_37_1:GetWordFromCfg(103903009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 32
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play103903010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 103903010
		arg_41_1.duration_ = 7.9

		local var_41_0 = {
			ja = 7.9,
			ko = 7.866,
			zh = 7.866,
			en = 5.666
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
				arg_41_0:Play103903011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1039ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1039ui_story == nil then
				arg_41_1.var_.characterEffect1039ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.1

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1039ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1039ui_story then
				arg_41_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_44_6 = 0
			local var_44_7 = 0.725

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[9].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(103903010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 28
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

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb")

						arg_41_1:RecordAudio("103903010", var_44_15)
						arg_41_1:RecordAudio("103903010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb")
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
	Play103903011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 103903011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play103903012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1039ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1039ui_story == nil then
				arg_45_1.var_.characterEffect1039ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.1

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1039ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1039ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1039ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1039ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.15

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_9 = arg_45_1:GetWordFromCfg(103903011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 6
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play103903012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 103903012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play103903013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1039ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1039ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(10, -1.06, -5.3)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1039ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = 0
			local var_52_10 = 0.7

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_11 = arg_49_1:GetWordFromCfg(103903012)
				local var_52_12 = arg_49_1:FormatText(var_52_11.content)

				arg_49_1.text_.text = var_52_12

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 28
				local var_52_14 = utf8.len(var_52_12)
				local var_52_15 = var_52_13 <= 0 and var_52_10 or var_52_10 * (var_52_14 / var_52_13)

				if var_52_15 > 0 and var_52_10 < var_52_15 then
					arg_49_1.talkMaxDuration = var_52_15

					if var_52_15 + var_52_9 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_15 + var_52_9
					end
				end

				arg_49_1.text_.text = var_52_12
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_10, arg_49_1.talkMaxDuration)

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_9) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_9 + var_52_16 and arg_49_1.time_ < var_52_9 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play103903013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 103903013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play103903014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.bgs_.ST03.transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPosST03 = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, -100, 10)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPosST03, var_56_4, var_56_3)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_56_5 = "ST02"

			if arg_53_1.bgs_[var_56_5] == nil then
				local var_56_6 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_56_5)
				var_56_6.name = var_56_5
				var_56_6.transform.parent = arg_53_1.stage_.transform
				var_56_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_[var_56_5] = var_56_6
			end

			local var_56_7 = 0

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				local var_56_8 = manager.ui.mainCamera.transform.localPosition
				local var_56_9 = Vector3.New(0, 0, 10) + Vector3.New(var_56_8.x, var_56_8.y, 0)
				local var_56_10 = arg_53_1.bgs_.ST02

				var_56_10.transform.localPosition = var_56_9
				var_56_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_11 = var_56_10:GetComponent("SpriteRenderer")

				if var_56_11 and var_56_11.sprite then
					local var_56_12 = (var_56_10.transform.localPosition - var_56_8).z
					local var_56_13 = manager.ui.mainCameraCom_
					local var_56_14 = 2 * var_56_12 * Mathf.Tan(var_56_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_56_15 = var_56_14 * var_56_13.aspect
					local var_56_16 = var_56_11.sprite.bounds.size.x
					local var_56_17 = var_56_11.sprite.bounds.size.y
					local var_56_18 = var_56_15 / var_56_16
					local var_56_19 = var_56_14 / var_56_17
					local var_56_20 = var_56_19 < var_56_18 and var_56_18 or var_56_19

					var_56_10.transform.localScale = Vector3.New(var_56_20, var_56_20, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "ST02" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_21 = 0
			local var_56_22 = 0.175

			if var_56_21 < arg_53_1.time_ and arg_53_1.time_ <= var_56_21 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_23 = arg_53_1:GetWordFromCfg(103903013)
				local var_56_24 = arg_53_1:FormatText(var_56_23.content)

				arg_53_1.text_.text = var_56_24

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_25 = 7
				local var_56_26 = utf8.len(var_56_24)
				local var_56_27 = var_56_25 <= 0 and var_56_22 or var_56_22 * (var_56_26 / var_56_25)

				if var_56_27 > 0 and var_56_22 < var_56_27 then
					arg_53_1.talkMaxDuration = var_56_27

					if var_56_27 + var_56_21 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_27 + var_56_21
					end
				end

				arg_53_1.text_.text = var_56_24
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_28 = math.max(var_56_22, arg_53_1.talkMaxDuration)

			if var_56_21 <= arg_53_1.time_ and arg_53_1.time_ < var_56_21 + var_56_28 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_21) / var_56_28

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_21 + var_56_28 and arg_53_1.time_ < var_56_21 + var_56_28 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play103903014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 103903014
		arg_57_1.duration_ = 4.93

		local var_57_0 = {
			ja = 4.933,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_57_0:Play103903015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = "1027ui_story"

			if arg_57_1.actors_[var_60_0] == nil then
				local var_60_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_60_1) then
					local var_60_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_57_1.stage_.transform)

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

			local var_60_5 = arg_57_1.actors_["1027ui_story"]
			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1027ui_story == nil then
				arg_57_1.var_.characterEffect1027ui_story = var_60_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_7 = 0.1

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_7 and not isNil(var_60_5) then
				local var_60_8 = (arg_57_1.time_ - var_60_6) / var_60_7

				if arg_57_1.var_.characterEffect1027ui_story and not isNil(var_60_5) then
					arg_57_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_6 + var_60_7 and arg_57_1.time_ < var_60_6 + var_60_7 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1027ui_story then
				arg_57_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_60_9 = arg_57_1.actors_["1027ui_story"].transform
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1.var_.moveOldPos1027ui_story = var_60_9.localPosition
			end

			local var_60_11 = 0.001

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11
				local var_60_13 = Vector3.New(0, -0.922, -5.1)

				var_60_9.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1027ui_story, var_60_13, var_60_12)

				local var_60_14 = manager.ui.mainCamera.transform.position - var_60_9.position

				var_60_9.forward = Vector3.New(var_60_14.x, var_60_14.y, var_60_14.z)

				local var_60_15 = var_60_9.localEulerAngles

				var_60_15.z = 0
				var_60_15.x = 0
				var_60_9.localEulerAngles = var_60_15
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 then
				var_60_9.localPosition = Vector3.New(0, -0.922, -5.1)

				local var_60_16 = manager.ui.mainCamera.transform.position - var_60_9.position

				var_60_9.forward = Vector3.New(var_60_16.x, var_60_16.y, var_60_16.z)

				local var_60_17 = var_60_9.localEulerAngles

				var_60_17.z = 0
				var_60_17.x = 0
				var_60_9.localEulerAngles = var_60_17
			end

			local var_60_18 = 0

			if var_60_18 < arg_57_1.time_ and arg_57_1.time_ <= var_60_18 + arg_60_0 then
				arg_57_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_60_19 = 0

			if var_60_19 < arg_57_1.time_ and arg_57_1.time_ <= var_60_19 + arg_60_0 then
				arg_57_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_60_20 = 0
			local var_60_21 = 0.2

			if var_60_20 < arg_57_1.time_ and arg_57_1.time_ <= var_60_20 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_22 = arg_57_1:FormatText(StoryNameCfg[56].name)

				arg_57_1.leftNameTxt_.text = var_60_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_23 = arg_57_1:GetWordFromCfg(103903014)
				local var_60_24 = arg_57_1:FormatText(var_60_23.content)

				arg_57_1.text_.text = var_60_24

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_25 = 8
				local var_60_26 = utf8.len(var_60_24)
				local var_60_27 = var_60_25 <= 0 and var_60_21 or var_60_21 * (var_60_26 / var_60_25)

				if var_60_27 > 0 and var_60_21 < var_60_27 then
					arg_57_1.talkMaxDuration = var_60_27

					if var_60_27 + var_60_20 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_27 + var_60_20
					end
				end

				arg_57_1.text_.text = var_60_24
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb") ~= 0 then
					local var_60_28 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb") / 1000

					if var_60_28 + var_60_20 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_28 + var_60_20
					end

					if var_60_23.prefab_name ~= "" and arg_57_1.actors_[var_60_23.prefab_name] ~= nil then
						local var_60_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_23.prefab_name].transform, "story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb")

						arg_57_1:RecordAudio("103903014", var_60_29)
						arg_57_1:RecordAudio("103903014", var_60_29)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_30 = math.max(var_60_21, arg_57_1.talkMaxDuration)

			if var_60_20 <= arg_57_1.time_ and arg_57_1.time_ < var_60_20 + var_60_30 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_20) / var_60_30

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_20 + var_60_30 and arg_57_1.time_ < var_60_20 + var_60_30 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play103903015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 103903015
		arg_61_1.duration_ = 4.03

		local var_61_0 = {
			ja = 3.466,
			ko = 4.033,
			zh = 4.033,
			en = 3.3
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
				arg_61_0:Play103903016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "1148ui_story"

			if arg_61_1.actors_[var_64_0] == nil then
				local var_64_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_64_1) then
					local var_64_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_61_1.stage_.transform)

					var_64_2.name = var_64_0
					var_64_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_61_1.actors_[var_64_0] = var_64_2

					local var_64_3 = var_64_2:GetComponentInChildren(typeof(CharacterEffect))

					var_64_3.enabled = true

					local var_64_4 = GameObjectTools.GetOrAddComponent(var_64_2, typeof(DynamicBoneHelper))

					if var_64_4 then
						var_64_4:EnableDynamicBone(false)
					end

					arg_61_1:ShowWeapon(var_64_3.transform, false)

					arg_61_1.var_[var_64_0 .. "Animator"] = var_64_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_61_1.var_[var_64_0 .. "Animator"].applyRootMotion = true
					arg_61_1.var_[var_64_0 .. "LipSync"] = var_64_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_64_5 = arg_61_1.actors_["1148ui_story"]
			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1148ui_story == nil then
				arg_61_1.var_.characterEffect1148ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_7 = 0.1

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_7 and not isNil(var_64_5) then
				local var_64_8 = (arg_61_1.time_ - var_64_6) / var_64_7

				if arg_61_1.var_.characterEffect1148ui_story and not isNil(var_64_5) then
					arg_61_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_6 + var_64_7 and arg_61_1.time_ < var_64_6 + var_64_7 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1148ui_story then
				arg_61_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_64_9 = arg_61_1.actors_["1027ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1027ui_story == nil then
				arg_61_1.var_.characterEffect1027ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.1

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1027ui_story and not isNil(var_64_9) then
					local var_64_13 = Mathf.Lerp(0, 0.5, var_64_12)

					arg_61_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1027ui_story.fillRatio = var_64_13
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1027ui_story then
				local var_64_14 = 0.5

				arg_61_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1027ui_story.fillRatio = var_64_14
			end

			local var_64_15 = arg_61_1.actors_["1027ui_story"].transform
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.var_.moveOldPos1027ui_story = var_64_15.localPosition
			end

			local var_64_17 = 0.001

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17
				local var_64_19 = Vector3.New(0, -0.922, -5.1)

				var_64_15.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1027ui_story, var_64_19, var_64_18)

				local var_64_20 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_20.x, var_64_20.y, var_64_20.z)

				local var_64_21 = var_64_15.localEulerAngles

				var_64_21.z = 0
				var_64_21.x = 0
				var_64_15.localEulerAngles = var_64_21
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				var_64_15.localPosition = Vector3.New(0, -0.922, -5.1)

				local var_64_22 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_22.x, var_64_22.y, var_64_22.z)

				local var_64_23 = var_64_15.localEulerAngles

				var_64_23.z = 0
				var_64_23.x = 0
				var_64_15.localEulerAngles = var_64_23
			end

			local var_64_24 = arg_61_1.actors_["1027ui_story"].transform
			local var_64_25 = 0.033

			if var_64_25 < arg_61_1.time_ and arg_61_1.time_ <= var_64_25 + arg_64_0 then
				arg_61_1.var_.moveOldPos1027ui_story = var_64_24.localPosition
			end

			local var_64_26 = 0.5

			if var_64_25 <= arg_61_1.time_ and arg_61_1.time_ < var_64_25 + var_64_26 then
				local var_64_27 = (arg_61_1.time_ - var_64_25) / var_64_26
				local var_64_28 = Vector3.New(-0.92, -0.922, -5.1)

				var_64_24.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1027ui_story, var_64_28, var_64_27)

				local var_64_29 = manager.ui.mainCamera.transform.position - var_64_24.position

				var_64_24.forward = Vector3.New(var_64_29.x, var_64_29.y, var_64_29.z)

				local var_64_30 = var_64_24.localEulerAngles

				var_64_30.z = 0
				var_64_30.x = 0
				var_64_24.localEulerAngles = var_64_30
			end

			if arg_61_1.time_ >= var_64_25 + var_64_26 and arg_61_1.time_ < var_64_25 + var_64_26 + arg_64_0 then
				var_64_24.localPosition = Vector3.New(-0.92, -0.922, -5.1)

				local var_64_31 = manager.ui.mainCamera.transform.position - var_64_24.position

				var_64_24.forward = Vector3.New(var_64_31.x, var_64_31.y, var_64_31.z)

				local var_64_32 = var_64_24.localEulerAngles

				var_64_32.z = 0
				var_64_32.x = 0
				var_64_24.localEulerAngles = var_64_32
			end

			local var_64_33 = arg_61_1.actors_["1148ui_story"].transform
			local var_64_34 = 0

			if var_64_34 < arg_61_1.time_ and arg_61_1.time_ <= var_64_34 + arg_64_0 then
				arg_61_1.var_.moveOldPos1148ui_story = var_64_33.localPosition
			end

			local var_64_35 = 0.001

			if var_64_34 <= arg_61_1.time_ and arg_61_1.time_ < var_64_34 + var_64_35 then
				local var_64_36 = (arg_61_1.time_ - var_64_34) / var_64_35
				local var_64_37 = Vector3.New(0.83, -0.85, -5.6)

				var_64_33.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1148ui_story, var_64_37, var_64_36)

				local var_64_38 = manager.ui.mainCamera.transform.position - var_64_33.position

				var_64_33.forward = Vector3.New(var_64_38.x, var_64_38.y, var_64_38.z)

				local var_64_39 = var_64_33.localEulerAngles

				var_64_39.z = 0
				var_64_39.x = 0
				var_64_33.localEulerAngles = var_64_39
			end

			if arg_61_1.time_ >= var_64_34 + var_64_35 and arg_61_1.time_ < var_64_34 + var_64_35 + arg_64_0 then
				var_64_33.localPosition = Vector3.New(0.83, -0.85, -5.6)

				local var_64_40 = manager.ui.mainCamera.transform.position - var_64_33.position

				var_64_33.forward = Vector3.New(var_64_40.x, var_64_40.y, var_64_40.z)

				local var_64_41 = var_64_33.localEulerAngles

				var_64_41.z = 0
				var_64_41.x = 0
				var_64_33.localEulerAngles = var_64_41
			end

			local var_64_42 = 0

			if var_64_42 < arg_61_1.time_ and arg_61_1.time_ <= var_64_42 + arg_64_0 then
				arg_61_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			local var_64_43 = 0

			if var_64_43 < arg_61_1.time_ and arg_61_1.time_ <= var_64_43 + arg_64_0 then
				arg_61_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_64_44 = 0
			local var_64_45 = 0.4

			if var_64_44 < arg_61_1.time_ and arg_61_1.time_ <= var_64_44 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_46 = arg_61_1:FormatText(StoryNameCfg[8].name)

				arg_61_1.leftNameTxt_.text = var_64_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_47 = arg_61_1:GetWordFromCfg(103903015)
				local var_64_48 = arg_61_1:FormatText(var_64_47.content)

				arg_61_1.text_.text = var_64_48

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_49 = 16
				local var_64_50 = utf8.len(var_64_48)
				local var_64_51 = var_64_49 <= 0 and var_64_45 or var_64_45 * (var_64_50 / var_64_49)

				if var_64_51 > 0 and var_64_45 < var_64_51 then
					arg_61_1.talkMaxDuration = var_64_51

					if var_64_51 + var_64_44 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_51 + var_64_44
					end
				end

				arg_61_1.text_.text = var_64_48
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb") ~= 0 then
					local var_64_52 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb") / 1000

					if var_64_52 + var_64_44 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_52 + var_64_44
					end

					if var_64_47.prefab_name ~= "" and arg_61_1.actors_[var_64_47.prefab_name] ~= nil then
						local var_64_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_47.prefab_name].transform, "story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb")

						arg_61_1:RecordAudio("103903015", var_64_53)
						arg_61_1:RecordAudio("103903015", var_64_53)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_54 = math.max(var_64_45, arg_61_1.talkMaxDuration)

			if var_64_44 <= arg_61_1.time_ and arg_61_1.time_ < var_64_44 + var_64_54 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_44) / var_64_54

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_44 + var_64_54 and arg_61_1.time_ < var_64_44 + var_64_54 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play103903016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 103903016
		arg_65_1.duration_ = 4.6

		local var_65_0 = {
			ja = 4.6,
			ko = 3.7,
			zh = 3.7,
			en = 3.533
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
				arg_65_0:Play103903017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1027ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1027ui_story == nil then
				arg_65_1.var_.characterEffect1027ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.1

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1027ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1027ui_story then
				arg_65_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1148ui_story"]
			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1148ui_story == nil then
				arg_65_1.var_.characterEffect1148ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.1

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 and not isNil(var_68_4) then
				local var_68_7 = (arg_65_1.time_ - var_68_5) / var_68_6

				if arg_65_1.var_.characterEffect1148ui_story and not isNil(var_68_4) then
					local var_68_8 = Mathf.Lerp(0, 0.5, var_68_7)

					arg_65_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1148ui_story.fillRatio = var_68_8
				end
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1148ui_story then
				local var_68_9 = 0.5

				arg_65_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1148ui_story.fillRatio = var_68_9
			end

			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action424")
			end

			local var_68_11 = 0

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_68_12 = 0
			local var_68_13 = 0.275

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[56].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(103903016)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 11
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

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb")

						arg_65_1:RecordAudio("103903016", var_68_21)
						arg_65_1:RecordAudio("103903016", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb")
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
	Play103903017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 103903017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play103903018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1027ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1027ui_story == nil then
				arg_69_1.var_.characterEffect1027ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.1

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1027ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1027ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1027ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1027ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.075

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[113].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_9 = arg_69_1:GetWordFromCfg(103903017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 3
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play103903018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 103903018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play103903019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.125

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

				local var_76_2 = arg_73_1:GetWordFromCfg(103903018)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 5
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
	Play103903019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 103903019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play103903020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.6

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(103903019)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 24
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play103903020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 103903020
		arg_81_1.duration_ = 8.8

		local var_81_0 = {
			ja = 8.8,
			ko = 6,
			zh = 6,
			en = 7.766
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
				arg_81_0:Play103903021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1039ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1039ui_story == nil then
				arg_81_1.var_.characterEffect1039ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.1

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1039ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1039ui_story then
				arg_81_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_84_4 = arg_81_1.actors_["1027ui_story"].transform
			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.var_.moveOldPos1027ui_story = var_84_4.localPosition
			end

			local var_84_6 = 0.001

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 then
				local var_84_7 = (arg_81_1.time_ - var_84_5) / var_84_6
				local var_84_8 = Vector3.New(10, -0.922, -5.1)

				var_84_4.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1027ui_story, var_84_8, var_84_7)

				local var_84_9 = manager.ui.mainCamera.transform.position - var_84_4.position

				var_84_4.forward = Vector3.New(var_84_9.x, var_84_9.y, var_84_9.z)

				local var_84_10 = var_84_4.localEulerAngles

				var_84_10.z = 0
				var_84_10.x = 0
				var_84_4.localEulerAngles = var_84_10
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 then
				var_84_4.localPosition = Vector3.New(10, -0.922, -5.1)

				local var_84_11 = manager.ui.mainCamera.transform.position - var_84_4.position

				var_84_4.forward = Vector3.New(var_84_11.x, var_84_11.y, var_84_11.z)

				local var_84_12 = var_84_4.localEulerAngles

				var_84_12.z = 0
				var_84_12.x = 0
				var_84_4.localEulerAngles = var_84_12
			end

			local var_84_13 = arg_81_1.actors_["1148ui_story"].transform
			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1.var_.moveOldPos1148ui_story = var_84_13.localPosition
			end

			local var_84_15 = 0.001

			if var_84_14 <= arg_81_1.time_ and arg_81_1.time_ < var_84_14 + var_84_15 then
				local var_84_16 = (arg_81_1.time_ - var_84_14) / var_84_15
				local var_84_17 = Vector3.New(10, -0.85, -5.6)

				var_84_13.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1148ui_story, var_84_17, var_84_16)

				local var_84_18 = manager.ui.mainCamera.transform.position - var_84_13.position

				var_84_13.forward = Vector3.New(var_84_18.x, var_84_18.y, var_84_18.z)

				local var_84_19 = var_84_13.localEulerAngles

				var_84_19.z = 0
				var_84_19.x = 0
				var_84_13.localEulerAngles = var_84_19
			end

			if arg_81_1.time_ >= var_84_14 + var_84_15 and arg_81_1.time_ < var_84_14 + var_84_15 + arg_84_0 then
				var_84_13.localPosition = Vector3.New(10, -0.85, -5.6)

				local var_84_20 = manager.ui.mainCamera.transform.position - var_84_13.position

				var_84_13.forward = Vector3.New(var_84_20.x, var_84_20.y, var_84_20.z)

				local var_84_21 = var_84_13.localEulerAngles

				var_84_21.z = 0
				var_84_21.x = 0
				var_84_13.localEulerAngles = var_84_21
			end

			local var_84_22 = arg_81_1.actors_["1039ui_story"].transform
			local var_84_23 = 0

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.var_.moveOldPos1039ui_story = var_84_22.localPosition
			end

			local var_84_24 = 0.001

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_24 then
				local var_84_25 = (arg_81_1.time_ - var_84_23) / var_84_24
				local var_84_26 = Vector3.New(0, -1.06, -5.3)

				var_84_22.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1039ui_story, var_84_26, var_84_25)

				local var_84_27 = manager.ui.mainCamera.transform.position - var_84_22.position

				var_84_22.forward = Vector3.New(var_84_27.x, var_84_27.y, var_84_27.z)

				local var_84_28 = var_84_22.localEulerAngles

				var_84_28.z = 0
				var_84_28.x = 0
				var_84_22.localEulerAngles = var_84_28
			end

			if arg_81_1.time_ >= var_84_23 + var_84_24 and arg_81_1.time_ < var_84_23 + var_84_24 + arg_84_0 then
				var_84_22.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_84_29 = manager.ui.mainCamera.transform.position - var_84_22.position

				var_84_22.forward = Vector3.New(var_84_29.x, var_84_29.y, var_84_29.z)

				local var_84_30 = var_84_22.localEulerAngles

				var_84_30.z = 0
				var_84_30.x = 0
				var_84_22.localEulerAngles = var_84_30
			end

			local var_84_31 = 0

			if var_84_31 < arg_81_1.time_ and arg_81_1.time_ <= var_84_31 + arg_84_0 then
				arg_81_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action3_1")
			end

			local var_84_32 = 0

			if var_84_32 < arg_81_1.time_ and arg_81_1.time_ <= var_84_32 + arg_84_0 then
				arg_81_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_84_33 = 0
			local var_84_34 = 0.55

			if var_84_33 < arg_81_1.time_ and arg_81_1.time_ <= var_84_33 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_35 = arg_81_1:FormatText(StoryNameCfg[9].name)

				arg_81_1.leftNameTxt_.text = var_84_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_36 = arg_81_1:GetWordFromCfg(103903020)
				local var_84_37 = arg_81_1:FormatText(var_84_36.content)

				arg_81_1.text_.text = var_84_37

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_38 = 22
				local var_84_39 = utf8.len(var_84_37)
				local var_84_40 = var_84_38 <= 0 and var_84_34 or var_84_34 * (var_84_39 / var_84_38)

				if var_84_40 > 0 and var_84_34 < var_84_40 then
					arg_81_1.talkMaxDuration = var_84_40

					if var_84_40 + var_84_33 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_40 + var_84_33
					end
				end

				arg_81_1.text_.text = var_84_37
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb") ~= 0 then
					local var_84_41 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb") / 1000

					if var_84_41 + var_84_33 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_41 + var_84_33
					end

					if var_84_36.prefab_name ~= "" and arg_81_1.actors_[var_84_36.prefab_name] ~= nil then
						local var_84_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_36.prefab_name].transform, "story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb")

						arg_81_1:RecordAudio("103903020", var_84_42)
						arg_81_1:RecordAudio("103903020", var_84_42)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_43 = math.max(var_84_34, arg_81_1.talkMaxDuration)

			if var_84_33 <= arg_81_1.time_ and arg_81_1.time_ < var_84_33 + var_84_43 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_33) / var_84_43

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_33 + var_84_43 and arg_81_1.time_ < var_84_33 + var_84_43 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play103903021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 103903021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play103903022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.45

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(103903021)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 18
				local var_88_5 = utf8.len(var_88_3)
				local var_88_6 = var_88_4 <= 0 and var_88_1 or var_88_1 * (var_88_5 / var_88_4)

				if var_88_6 > 0 and var_88_1 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_7 and arg_85_1.time_ < var_88_0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play103903022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 103903022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play103903023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1039ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1039ui_story == nil then
				arg_89_1.var_.characterEffect1039ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.1

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1039ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1039ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1039ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1039ui_story.fillRatio = var_92_5
			end

			local var_92_6 = arg_89_1.actors_["1039ui_story"].transform
			local var_92_7 = 0

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.var_.moveOldPos1039ui_story = var_92_6.localPosition
			end

			local var_92_8 = 0.001

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_8 then
				local var_92_9 = (arg_89_1.time_ - var_92_7) / var_92_8
				local var_92_10 = Vector3.New(10, -1.06, -5.3)

				var_92_6.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1039ui_story, var_92_10, var_92_9)

				local var_92_11 = manager.ui.mainCamera.transform.position - var_92_6.position

				var_92_6.forward = Vector3.New(var_92_11.x, var_92_11.y, var_92_11.z)

				local var_92_12 = var_92_6.localEulerAngles

				var_92_12.z = 0
				var_92_12.x = 0
				var_92_6.localEulerAngles = var_92_12
			end

			if arg_89_1.time_ >= var_92_7 + var_92_8 and arg_89_1.time_ < var_92_7 + var_92_8 + arg_92_0 then
				var_92_6.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_92_13 = manager.ui.mainCamera.transform.position - var_92_6.position

				var_92_6.forward = Vector3.New(var_92_13.x, var_92_13.y, var_92_13.z)

				local var_92_14 = var_92_6.localEulerAngles

				var_92_14.z = 0
				var_92_14.x = 0
				var_92_6.localEulerAngles = var_92_14
			end

			local var_92_15 = 0
			local var_92_16 = 0.525

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_17 = arg_89_1:GetWordFromCfg(103903022)
				local var_92_18 = arg_89_1:FormatText(var_92_17.content)

				arg_89_1.text_.text = var_92_18

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_19 = 21
				local var_92_20 = utf8.len(var_92_18)
				local var_92_21 = var_92_19 <= 0 and var_92_16 or var_92_16 * (var_92_20 / var_92_19)

				if var_92_21 > 0 and var_92_16 < var_92_21 then
					arg_89_1.talkMaxDuration = var_92_21

					if var_92_21 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_21 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_18
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_22 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_22 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_22

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_22 and arg_89_1.time_ < var_92_15 + var_92_22 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play103903023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 103903023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play103903024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.875

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(103903023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 35
				local var_96_5 = utf8.len(var_96_3)
				local var_96_6 = var_96_4 <= 0 and var_96_1 or var_96_1 * (var_96_5 / var_96_4)

				if var_96_6 > 0 and var_96_1 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_7 and arg_93_1.time_ < var_96_0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play103903024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 103903024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play103903025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.675

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_2

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

				local var_100_3 = arg_97_1:GetWordFromCfg(103903024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 27
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
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play103903025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 103903025
		arg_101_1.duration_ = 7.03

		local var_101_0 = {
			ja = 2.333,
			ko = 7.033,
			zh = 7.033,
			en = 5.533
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
				arg_101_0:Play103903026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1027ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1027ui_story == nil then
				arg_101_1.var_.characterEffect1027ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.1

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1027ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1027ui_story then
				arg_101_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_104_4 = arg_101_1.actors_["1027ui_story"].transform
			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.var_.moveOldPos1027ui_story = var_104_4.localPosition
			end

			local var_104_6 = 0.001

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_6 then
				local var_104_7 = (arg_101_1.time_ - var_104_5) / var_104_6
				local var_104_8 = Vector3.New(0, -0.922, -5.1)

				var_104_4.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1027ui_story, var_104_8, var_104_7)

				local var_104_9 = manager.ui.mainCamera.transform.position - var_104_4.position

				var_104_4.forward = Vector3.New(var_104_9.x, var_104_9.y, var_104_9.z)

				local var_104_10 = var_104_4.localEulerAngles

				var_104_10.z = 0
				var_104_10.x = 0
				var_104_4.localEulerAngles = var_104_10
			end

			if arg_101_1.time_ >= var_104_5 + var_104_6 and arg_101_1.time_ < var_104_5 + var_104_6 + arg_104_0 then
				var_104_4.localPosition = Vector3.New(0, -0.922, -5.1)

				local var_104_11 = manager.ui.mainCamera.transform.position - var_104_4.position

				var_104_4.forward = Vector3.New(var_104_11.x, var_104_11.y, var_104_11.z)

				local var_104_12 = var_104_4.localEulerAngles

				var_104_12.z = 0
				var_104_12.x = 0
				var_104_4.localEulerAngles = var_104_12
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_104_15 = 0
			local var_104_16 = 0.1

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[56].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(103903025)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb")

						arg_101_1:RecordAudio("103903025", var_104_24)
						arg_101_1:RecordAudio("103903025", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb")
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play103903026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 103903026
		arg_105_1.duration_ = 2.77

		local var_105_0 = {
			ja = 2.533,
			ko = 2.433,
			zh = 2.433,
			en = 2.766
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
				arg_105_0:Play103903027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1148ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1148ui_story == nil then
				arg_105_1.var_.characterEffect1148ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.1

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1148ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1148ui_story then
				arg_105_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_108_4 = arg_105_1.actors_["1027ui_story"]
			local var_108_5 = 0

			if var_108_5 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1027ui_story == nil then
				arg_105_1.var_.characterEffect1027ui_story = var_108_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.1

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_6 and not isNil(var_108_4) then
				local var_108_7 = (arg_105_1.time_ - var_108_5) / var_108_6

				if arg_105_1.var_.characterEffect1027ui_story and not isNil(var_108_4) then
					local var_108_8 = Mathf.Lerp(0, 0.5, var_108_7)

					arg_105_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1027ui_story.fillRatio = var_108_8
				end
			end

			if arg_105_1.time_ >= var_108_5 + var_108_6 and arg_105_1.time_ < var_108_5 + var_108_6 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1027ui_story then
				local var_108_9 = 0.5

				arg_105_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1027ui_story.fillRatio = var_108_9
			end

			local var_108_10 = arg_105_1.actors_["1027ui_story"].transform
			local var_108_11 = 0

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1.var_.moveOldPos1027ui_story = var_108_10.localPosition
			end

			local var_108_12 = 0.001

			if var_108_11 <= arg_105_1.time_ and arg_105_1.time_ < var_108_11 + var_108_12 then
				local var_108_13 = (arg_105_1.time_ - var_108_11) / var_108_12
				local var_108_14 = Vector3.New(10, -0.922, -5.1)

				var_108_10.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1027ui_story, var_108_14, var_108_13)

				local var_108_15 = manager.ui.mainCamera.transform.position - var_108_10.position

				var_108_10.forward = Vector3.New(var_108_15.x, var_108_15.y, var_108_15.z)

				local var_108_16 = var_108_10.localEulerAngles

				var_108_16.z = 0
				var_108_16.x = 0
				var_108_10.localEulerAngles = var_108_16
			end

			if arg_105_1.time_ >= var_108_11 + var_108_12 and arg_105_1.time_ < var_108_11 + var_108_12 + arg_108_0 then
				var_108_10.localPosition = Vector3.New(10, -0.922, -5.1)

				local var_108_17 = manager.ui.mainCamera.transform.position - var_108_10.position

				var_108_10.forward = Vector3.New(var_108_17.x, var_108_17.y, var_108_17.z)

				local var_108_18 = var_108_10.localEulerAngles

				var_108_18.z = 0
				var_108_18.x = 0
				var_108_10.localEulerAngles = var_108_18
			end

			local var_108_19 = arg_105_1.actors_["1148ui_story"].transform
			local var_108_20 = 0

			if var_108_20 < arg_105_1.time_ and arg_105_1.time_ <= var_108_20 + arg_108_0 then
				arg_105_1.var_.moveOldPos1148ui_story = var_108_19.localPosition
			end

			local var_108_21 = 0.001

			if var_108_20 <= arg_105_1.time_ and arg_105_1.time_ < var_108_20 + var_108_21 then
				local var_108_22 = (arg_105_1.time_ - var_108_20) / var_108_21
				local var_108_23 = Vector3.New(0, -0.85, -5.6)

				var_108_19.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1148ui_story, var_108_23, var_108_22)

				local var_108_24 = manager.ui.mainCamera.transform.position - var_108_19.position

				var_108_19.forward = Vector3.New(var_108_24.x, var_108_24.y, var_108_24.z)

				local var_108_25 = var_108_19.localEulerAngles

				var_108_25.z = 0
				var_108_25.x = 0
				var_108_19.localEulerAngles = var_108_25
			end

			if arg_105_1.time_ >= var_108_20 + var_108_21 and arg_105_1.time_ < var_108_20 + var_108_21 + arg_108_0 then
				var_108_19.localPosition = Vector3.New(0, -0.85, -5.6)

				local var_108_26 = manager.ui.mainCamera.transform.position - var_108_19.position

				var_108_19.forward = Vector3.New(var_108_26.x, var_108_26.y, var_108_26.z)

				local var_108_27 = var_108_19.localEulerAngles

				var_108_27.z = 0
				var_108_27.x = 0
				var_108_19.localEulerAngles = var_108_27
			end

			local var_108_28 = 0

			if var_108_28 < arg_105_1.time_ and arg_105_1.time_ <= var_108_28 + arg_108_0 then
				arg_105_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_108_29 = 0

			if var_108_29 < arg_105_1.time_ and arg_105_1.time_ <= var_108_29 + arg_108_0 then
				arg_105_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_108_30 = 0
			local var_108_31 = 0.25

			if var_108_30 < arg_105_1.time_ and arg_105_1.time_ <= var_108_30 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_32 = arg_105_1:FormatText(StoryNameCfg[8].name)

				arg_105_1.leftNameTxt_.text = var_108_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_33 = arg_105_1:GetWordFromCfg(103903026)
				local var_108_34 = arg_105_1:FormatText(var_108_33.content)

				arg_105_1.text_.text = var_108_34

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_35 = 10
				local var_108_36 = utf8.len(var_108_34)
				local var_108_37 = var_108_35 <= 0 and var_108_31 or var_108_31 * (var_108_36 / var_108_35)

				if var_108_37 > 0 and var_108_31 < var_108_37 then
					arg_105_1.talkMaxDuration = var_108_37

					if var_108_37 + var_108_30 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_37 + var_108_30
					end
				end

				arg_105_1.text_.text = var_108_34
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb") ~= 0 then
					local var_108_38 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb") / 1000

					if var_108_38 + var_108_30 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_38 + var_108_30
					end

					if var_108_33.prefab_name ~= "" and arg_105_1.actors_[var_108_33.prefab_name] ~= nil then
						local var_108_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_33.prefab_name].transform, "story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb")

						arg_105_1:RecordAudio("103903026", var_108_39)
						arg_105_1:RecordAudio("103903026", var_108_39)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_40 = math.max(var_108_31, arg_105_1.talkMaxDuration)

			if var_108_30 <= arg_105_1.time_ and arg_105_1.time_ < var_108_30 + var_108_40 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_30) / var_108_40

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_30 + var_108_40 and arg_105_1.time_ < var_108_30 + var_108_40 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play103903027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 103903027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play103903028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1148ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1148ui_story == nil then
				arg_109_1.var_.characterEffect1148ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.1

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1148ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1148ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1148ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1148ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.875

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(103903027)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 35
				local var_112_11 = utf8.len(var_112_9)
				local var_112_12 = var_112_10 <= 0 and var_112_7 or var_112_7 * (var_112_11 / var_112_10)

				if var_112_12 > 0 and var_112_7 < var_112_12 then
					arg_109_1.talkMaxDuration = var_112_12

					if var_112_12 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_13 and arg_109_1.time_ < var_112_6 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play103903028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 103903028
		arg_113_1.duration_ = 7.83

		local var_113_0 = {
			ja = 7.833,
			ko = 4.9,
			zh = 4.9,
			en = 4.833
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
				arg_113_0:Play103903029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1039ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1039ui_story == nil then
				arg_113_1.var_.characterEffect1039ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.1

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1039ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1039ui_story then
				arg_113_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_116_4 = arg_113_1.actors_["1148ui_story"].transform
			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.var_.moveOldPos1148ui_story = var_116_4.localPosition
			end

			local var_116_6 = 0.001

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_6 then
				local var_116_7 = (arg_113_1.time_ - var_116_5) / var_116_6
				local var_116_8 = Vector3.New(10, -0.85, -5.6)

				var_116_4.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1148ui_story, var_116_8, var_116_7)

				local var_116_9 = manager.ui.mainCamera.transform.position - var_116_4.position

				var_116_4.forward = Vector3.New(var_116_9.x, var_116_9.y, var_116_9.z)

				local var_116_10 = var_116_4.localEulerAngles

				var_116_10.z = 0
				var_116_10.x = 0
				var_116_4.localEulerAngles = var_116_10
			end

			if arg_113_1.time_ >= var_116_5 + var_116_6 and arg_113_1.time_ < var_116_5 + var_116_6 + arg_116_0 then
				var_116_4.localPosition = Vector3.New(10, -0.85, -5.6)

				local var_116_11 = manager.ui.mainCamera.transform.position - var_116_4.position

				var_116_4.forward = Vector3.New(var_116_11.x, var_116_11.y, var_116_11.z)

				local var_116_12 = var_116_4.localEulerAngles

				var_116_12.z = 0
				var_116_12.x = 0
				var_116_4.localEulerAngles = var_116_12
			end

			local var_116_13 = arg_113_1.actors_["1039ui_story"].transform
			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.var_.moveOldPos1039ui_story = var_116_13.localPosition
			end

			local var_116_15 = 0.001

			if var_116_14 <= arg_113_1.time_ and arg_113_1.time_ < var_116_14 + var_116_15 then
				local var_116_16 = (arg_113_1.time_ - var_116_14) / var_116_15
				local var_116_17 = Vector3.New(0, -1.06, -5.3)

				var_116_13.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1039ui_story, var_116_17, var_116_16)

				local var_116_18 = manager.ui.mainCamera.transform.position - var_116_13.position

				var_116_13.forward = Vector3.New(var_116_18.x, var_116_18.y, var_116_18.z)

				local var_116_19 = var_116_13.localEulerAngles

				var_116_19.z = 0
				var_116_19.x = 0
				var_116_13.localEulerAngles = var_116_19
			end

			if arg_113_1.time_ >= var_116_14 + var_116_15 and arg_113_1.time_ < var_116_14 + var_116_15 + arg_116_0 then
				var_116_13.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_116_20 = manager.ui.mainCamera.transform.position - var_116_13.position

				var_116_13.forward = Vector3.New(var_116_20.x, var_116_20.y, var_116_20.z)

				local var_116_21 = var_116_13.localEulerAngles

				var_116_21.z = 0
				var_116_21.x = 0
				var_116_13.localEulerAngles = var_116_21
			end

			local var_116_22 = 0

			if var_116_22 < arg_113_1.time_ and arg_113_1.time_ <= var_116_22 + arg_116_0 then
				arg_113_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			local var_116_23 = 0

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_116_24 = 0
			local var_116_25 = 0.525

			if var_116_24 < arg_113_1.time_ and arg_113_1.time_ <= var_116_24 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_26 = arg_113_1:FormatText(StoryNameCfg[9].name)

				arg_113_1.leftNameTxt_.text = var_116_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_27 = arg_113_1:GetWordFromCfg(103903028)
				local var_116_28 = arg_113_1:FormatText(var_116_27.content)

				arg_113_1.text_.text = var_116_28

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_29 = 21
				local var_116_30 = utf8.len(var_116_28)
				local var_116_31 = var_116_29 <= 0 and var_116_25 or var_116_25 * (var_116_30 / var_116_29)

				if var_116_31 > 0 and var_116_25 < var_116_31 then
					arg_113_1.talkMaxDuration = var_116_31

					if var_116_31 + var_116_24 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_24
					end
				end

				arg_113_1.text_.text = var_116_28
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb") ~= 0 then
					local var_116_32 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb") / 1000

					if var_116_32 + var_116_24 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_32 + var_116_24
					end

					if var_116_27.prefab_name ~= "" and arg_113_1.actors_[var_116_27.prefab_name] ~= nil then
						local var_116_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_27.prefab_name].transform, "story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb")

						arg_113_1:RecordAudio("103903028", var_116_33)
						arg_113_1:RecordAudio("103903028", var_116_33)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_34 = math.max(var_116_25, arg_113_1.talkMaxDuration)

			if var_116_24 <= arg_113_1.time_ and arg_113_1.time_ < var_116_24 + var_116_34 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_24) / var_116_34

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_24 + var_116_34 and arg_113_1.time_ < var_116_24 + var_116_34 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play103903029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 103903029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play103903030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1039ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1039ui_story == nil then
				arg_117_1.var_.characterEffect1039ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.1

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1039ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1039ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1039ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1039ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.65

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(103903029)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 26
				local var_120_11 = utf8.len(var_120_9)
				local var_120_12 = var_120_10 <= 0 and var_120_7 or var_120_7 * (var_120_11 / var_120_10)

				if var_120_12 > 0 and var_120_7 < var_120_12 then
					arg_117_1.talkMaxDuration = var_120_12

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_13 and arg_117_1.time_ < var_120_6 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play103903030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 103903030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play103903031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1039ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1039ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(10, -1.06, -5.3)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1039ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = 0
			local var_124_10 = 0.425

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_11 = arg_121_1:GetWordFromCfg(103903030)
				local var_124_12 = arg_121_1:FormatText(var_124_11.content)

				arg_121_1.text_.text = var_124_12

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 17
				local var_124_14 = utf8.len(var_124_12)
				local var_124_15 = var_124_13 <= 0 and var_124_10 or var_124_10 * (var_124_14 / var_124_13)

				if var_124_15 > 0 and var_124_10 < var_124_15 then
					arg_121_1.talkMaxDuration = var_124_15

					if var_124_15 + var_124_9 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_15 + var_124_9
					end
				end

				arg_121_1.text_.text = var_124_12
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_10, arg_121_1.talkMaxDuration)

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_9) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_9 + var_124_16 and arg_121_1.time_ < var_124_9 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play103903031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 103903031
		arg_125_1.duration_ = 5.27

		local var_125_0 = {
			ja = 5.266,
			ko = 4.9,
			zh = 4.9,
			en = 4.733
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
				arg_125_0:Play103903032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1027ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1027ui_story == nil then
				arg_125_1.var_.characterEffect1027ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.1

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1027ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1027ui_story then
				arg_125_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["1027ui_story"].transform
			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.var_.moveOldPos1027ui_story = var_128_4.localPosition
			end

			local var_128_6 = 0.001

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 then
				local var_128_7 = (arg_125_1.time_ - var_128_5) / var_128_6
				local var_128_8 = Vector3.New(-0.92, -0.922, -5.1)

				var_128_4.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1027ui_story, var_128_8, var_128_7)

				local var_128_9 = manager.ui.mainCamera.transform.position - var_128_4.position

				var_128_4.forward = Vector3.New(var_128_9.x, var_128_9.y, var_128_9.z)

				local var_128_10 = var_128_4.localEulerAngles

				var_128_10.z = 0
				var_128_10.x = 0
				var_128_4.localEulerAngles = var_128_10
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 then
				var_128_4.localPosition = Vector3.New(-0.92, -0.922, -5.1)

				local var_128_11 = manager.ui.mainCamera.transform.position - var_128_4.position

				var_128_4.forward = Vector3.New(var_128_11.x, var_128_11.y, var_128_11.z)

				local var_128_12 = var_128_4.localEulerAngles

				var_128_12.z = 0
				var_128_12.x = 0
				var_128_4.localEulerAngles = var_128_12
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_128_15 = 0
			local var_128_16 = 0.5

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_17 = arg_125_1:FormatText(StoryNameCfg[56].name)

				arg_125_1.leftNameTxt_.text = var_128_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_18 = arg_125_1:GetWordFromCfg(103903031)
				local var_128_19 = arg_125_1:FormatText(var_128_18.content)

				arg_125_1.text_.text = var_128_19

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_20 = 20
				local var_128_21 = utf8.len(var_128_19)
				local var_128_22 = var_128_20 <= 0 and var_128_16 or var_128_16 * (var_128_21 / var_128_20)

				if var_128_22 > 0 and var_128_16 < var_128_22 then
					arg_125_1.talkMaxDuration = var_128_22

					if var_128_22 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_22 + var_128_15
					end
				end

				arg_125_1.text_.text = var_128_19
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb") ~= 0 then
					local var_128_23 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb") / 1000

					if var_128_23 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_15
					end

					if var_128_18.prefab_name ~= "" and arg_125_1.actors_[var_128_18.prefab_name] ~= nil then
						local var_128_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_18.prefab_name].transform, "story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb")

						arg_125_1:RecordAudio("103903031", var_128_24)
						arg_125_1:RecordAudio("103903031", var_128_24)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_25 = math.max(var_128_16, arg_125_1.talkMaxDuration)

			if var_128_15 <= arg_125_1.time_ and arg_125_1.time_ < var_128_15 + var_128_25 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_15) / var_128_25

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_15 + var_128_25 and arg_125_1.time_ < var_128_15 + var_128_25 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play103903032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 103903032
		arg_129_1.duration_ = 9.9

		local var_129_0 = {
			ja = 8.833,
			ko = 8.233,
			zh = 8.233,
			en = 9.9
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
				arg_129_0:Play103903033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1148ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1148ui_story == nil then
				arg_129_1.var_.characterEffect1148ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.1

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1148ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1148ui_story then
				arg_129_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_132_4 = arg_129_1.actors_["1027ui_story"]
			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect1027ui_story == nil then
				arg_129_1.var_.characterEffect1027ui_story = var_132_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_6 = 0.1

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_6 and not isNil(var_132_4) then
				local var_132_7 = (arg_129_1.time_ - var_132_5) / var_132_6

				if arg_129_1.var_.characterEffect1027ui_story and not isNil(var_132_4) then
					local var_132_8 = Mathf.Lerp(0, 0.5, var_132_7)

					arg_129_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1027ui_story.fillRatio = var_132_8
				end
			end

			if arg_129_1.time_ >= var_132_5 + var_132_6 and arg_129_1.time_ < var_132_5 + var_132_6 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect1027ui_story then
				local var_132_9 = 0.5

				arg_129_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1027ui_story.fillRatio = var_132_9
			end

			local var_132_10 = arg_129_1.actors_["1148ui_story"].transform
			local var_132_11 = 0

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.var_.moveOldPos1148ui_story = var_132_10.localPosition
			end

			local var_132_12 = 0.001

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_12 then
				local var_132_13 = (arg_129_1.time_ - var_132_11) / var_132_12
				local var_132_14 = Vector3.New(0.83, -0.85, -5.6)

				var_132_10.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1148ui_story, var_132_14, var_132_13)

				local var_132_15 = manager.ui.mainCamera.transform.position - var_132_10.position

				var_132_10.forward = Vector3.New(var_132_15.x, var_132_15.y, var_132_15.z)

				local var_132_16 = var_132_10.localEulerAngles

				var_132_16.z = 0
				var_132_16.x = 0
				var_132_10.localEulerAngles = var_132_16
			end

			if arg_129_1.time_ >= var_132_11 + var_132_12 and arg_129_1.time_ < var_132_11 + var_132_12 + arg_132_0 then
				var_132_10.localPosition = Vector3.New(0.83, -0.85, -5.6)

				local var_132_17 = manager.ui.mainCamera.transform.position - var_132_10.position

				var_132_10.forward = Vector3.New(var_132_17.x, var_132_17.y, var_132_17.z)

				local var_132_18 = var_132_10.localEulerAngles

				var_132_18.z = 0
				var_132_18.x = 0
				var_132_10.localEulerAngles = var_132_18
			end

			local var_132_19 = 0

			if var_132_19 < arg_129_1.time_ and arg_129_1.time_ <= var_132_19 + arg_132_0 then
				arg_129_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_132_20 = 0

			if var_132_20 < arg_129_1.time_ and arg_129_1.time_ <= var_132_20 + arg_132_0 then
				arg_129_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_132_21 = 0
			local var_132_22 = 1.125

			if var_132_21 < arg_129_1.time_ and arg_129_1.time_ <= var_132_21 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_23 = arg_129_1:FormatText(StoryNameCfg[8].name)

				arg_129_1.leftNameTxt_.text = var_132_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_24 = arg_129_1:GetWordFromCfg(103903032)
				local var_132_25 = arg_129_1:FormatText(var_132_24.content)

				arg_129_1.text_.text = var_132_25

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_26 = 45
				local var_132_27 = utf8.len(var_132_25)
				local var_132_28 = var_132_26 <= 0 and var_132_22 or var_132_22 * (var_132_27 / var_132_26)

				if var_132_28 > 0 and var_132_22 < var_132_28 then
					arg_129_1.talkMaxDuration = var_132_28

					if var_132_28 + var_132_21 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_28 + var_132_21
					end
				end

				arg_129_1.text_.text = var_132_25
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb") ~= 0 then
					local var_132_29 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb") / 1000

					if var_132_29 + var_132_21 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_29 + var_132_21
					end

					if var_132_24.prefab_name ~= "" and arg_129_1.actors_[var_132_24.prefab_name] ~= nil then
						local var_132_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_24.prefab_name].transform, "story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb")

						arg_129_1:RecordAudio("103903032", var_132_30)
						arg_129_1:RecordAudio("103903032", var_132_30)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_31 = math.max(var_132_22, arg_129_1.talkMaxDuration)

			if var_132_21 <= arg_129_1.time_ and arg_129_1.time_ < var_132_21 + var_132_31 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_21) / var_132_31

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_21 + var_132_31 and arg_129_1.time_ < var_132_21 + var_132_31 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play103903033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 103903033
		arg_133_1.duration_ = 3.6

		local var_133_0 = {
			ja = 3.6,
			ko = 2.2,
			zh = 2.2,
			en = 3.066
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
				arg_133_0:Play103903034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1027ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1027ui_story == nil then
				arg_133_1.var_.characterEffect1027ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.1

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1027ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1027ui_story then
				arg_133_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_136_4 = arg_133_1.actors_["1148ui_story"]
			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect1148ui_story == nil then
				arg_133_1.var_.characterEffect1148ui_story = var_136_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_6 = 0.1

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 and not isNil(var_136_4) then
				local var_136_7 = (arg_133_1.time_ - var_136_5) / var_136_6

				if arg_133_1.var_.characterEffect1148ui_story and not isNil(var_136_4) then
					local var_136_8 = Mathf.Lerp(0, 0.5, var_136_7)

					arg_133_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1148ui_story.fillRatio = var_136_8
				end
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect1148ui_story then
				local var_136_9 = 0.5

				arg_133_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1148ui_story.fillRatio = var_136_9
			end

			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action442")
			end

			local var_136_11 = 0
			local var_136_12 = 0.25

			if var_136_11 < arg_133_1.time_ and arg_133_1.time_ <= var_136_11 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_13 = arg_133_1:FormatText(StoryNameCfg[56].name)

				arg_133_1.leftNameTxt_.text = var_136_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_14 = arg_133_1:GetWordFromCfg(103903033)
				local var_136_15 = arg_133_1:FormatText(var_136_14.content)

				arg_133_1.text_.text = var_136_15

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_16 = 10
				local var_136_17 = utf8.len(var_136_15)
				local var_136_18 = var_136_16 <= 0 and var_136_12 or var_136_12 * (var_136_17 / var_136_16)

				if var_136_18 > 0 and var_136_12 < var_136_18 then
					arg_133_1.talkMaxDuration = var_136_18

					if var_136_18 + var_136_11 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_18 + var_136_11
					end
				end

				arg_133_1.text_.text = var_136_15
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb") ~= 0 then
					local var_136_19 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb") / 1000

					if var_136_19 + var_136_11 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_19 + var_136_11
					end

					if var_136_14.prefab_name ~= "" and arg_133_1.actors_[var_136_14.prefab_name] ~= nil then
						local var_136_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_14.prefab_name].transform, "story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb")

						arg_133_1:RecordAudio("103903033", var_136_20)
						arg_133_1:RecordAudio("103903033", var_136_20)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_21 = math.max(var_136_12, arg_133_1.talkMaxDuration)

			if var_136_11 <= arg_133_1.time_ and arg_133_1.time_ < var_136_11 + var_136_21 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_11) / var_136_21

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_11 + var_136_21 and arg_133_1.time_ < var_136_11 + var_136_21 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play103903034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 103903034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play103903035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1148ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1148ui_story == nil then
				arg_137_1.var_.characterEffect1148ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.1

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1148ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1148ui_story then
				arg_137_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_140_4 = 0
			local var_140_5 = 0.85

			if var_140_4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(103903034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_8 = 34
				local var_140_9 = utf8.len(var_140_7)
				local var_140_10 = var_140_8 <= 0 and var_140_5 or var_140_5 * (var_140_9 / var_140_8)

				if var_140_10 > 0 and var_140_5 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_11 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_11 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_11

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_11 and arg_137_1.time_ < var_140_4 + var_140_11 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play103903035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 103903035
		arg_141_1.duration_ = 2.5

		local var_141_0 = {
			ja = 1.999999999999,
			ko = 2.5,
			zh = 2.5,
			en = 1.999999999999
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
				arg_141_0:Play103903036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1039ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1039ui_story == nil then
				arg_141_1.var_.characterEffect1039ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.1

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1039ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1039ui_story then
				arg_141_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_144_4 = arg_141_1.actors_["1027ui_story"]
			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1027ui_story == nil then
				arg_141_1.var_.characterEffect1027ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_6 = 0.1

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_6 and not isNil(var_144_4) then
				local var_144_7 = (arg_141_1.time_ - var_144_5) / var_144_6

				if arg_141_1.var_.characterEffect1027ui_story and not isNil(var_144_4) then
					local var_144_8 = Mathf.Lerp(0, 0.5, var_144_7)

					arg_141_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1027ui_story.fillRatio = var_144_8
				end
			end

			if arg_141_1.time_ >= var_144_5 + var_144_6 and arg_141_1.time_ < var_144_5 + var_144_6 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1027ui_story then
				local var_144_9 = 0.5

				arg_141_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1027ui_story.fillRatio = var_144_9
			end

			local var_144_10 = arg_141_1.actors_["1148ui_story"]
			local var_144_11 = 0

			if var_144_11 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 and not isNil(var_144_10) and arg_141_1.var_.characterEffect1148ui_story == nil then
				arg_141_1.var_.characterEffect1148ui_story = var_144_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_12 = 0.1

			if var_144_11 <= arg_141_1.time_ and arg_141_1.time_ < var_144_11 + var_144_12 and not isNil(var_144_10) then
				local var_144_13 = (arg_141_1.time_ - var_144_11) / var_144_12

				if arg_141_1.var_.characterEffect1148ui_story and not isNil(var_144_10) then
					local var_144_14 = Mathf.Lerp(0, 0.5, var_144_13)

					arg_141_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1148ui_story.fillRatio = var_144_14
				end
			end

			if arg_141_1.time_ >= var_144_11 + var_144_12 and arg_141_1.time_ < var_144_11 + var_144_12 + arg_144_0 and not isNil(var_144_10) and arg_141_1.var_.characterEffect1148ui_story then
				local var_144_15 = 0.5

				arg_141_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1148ui_story.fillRatio = var_144_15
			end

			local var_144_16 = arg_141_1.actors_["1027ui_story"].transform
			local var_144_17 = 0

			if var_144_17 < arg_141_1.time_ and arg_141_1.time_ <= var_144_17 + arg_144_0 then
				arg_141_1.var_.moveOldPos1027ui_story = var_144_16.localPosition
			end

			local var_144_18 = 0.001

			if var_144_17 <= arg_141_1.time_ and arg_141_1.time_ < var_144_17 + var_144_18 then
				local var_144_19 = (arg_141_1.time_ - var_144_17) / var_144_18
				local var_144_20 = Vector3.New(10, -0.922, -5.1)

				var_144_16.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1027ui_story, var_144_20, var_144_19)

				local var_144_21 = manager.ui.mainCamera.transform.position - var_144_16.position

				var_144_16.forward = Vector3.New(var_144_21.x, var_144_21.y, var_144_21.z)

				local var_144_22 = var_144_16.localEulerAngles

				var_144_22.z = 0
				var_144_22.x = 0
				var_144_16.localEulerAngles = var_144_22
			end

			if arg_141_1.time_ >= var_144_17 + var_144_18 and arg_141_1.time_ < var_144_17 + var_144_18 + arg_144_0 then
				var_144_16.localPosition = Vector3.New(10, -0.922, -5.1)

				local var_144_23 = manager.ui.mainCamera.transform.position - var_144_16.position

				var_144_16.forward = Vector3.New(var_144_23.x, var_144_23.y, var_144_23.z)

				local var_144_24 = var_144_16.localEulerAngles

				var_144_24.z = 0
				var_144_24.x = 0
				var_144_16.localEulerAngles = var_144_24
			end

			local var_144_25 = arg_141_1.actors_["1148ui_story"].transform
			local var_144_26 = 0

			if var_144_26 < arg_141_1.time_ and arg_141_1.time_ <= var_144_26 + arg_144_0 then
				arg_141_1.var_.moveOldPos1148ui_story = var_144_25.localPosition
			end

			local var_144_27 = 0.001

			if var_144_26 <= arg_141_1.time_ and arg_141_1.time_ < var_144_26 + var_144_27 then
				local var_144_28 = (arg_141_1.time_ - var_144_26) / var_144_27
				local var_144_29 = Vector3.New(10, -0.85, -5.6)

				var_144_25.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1148ui_story, var_144_29, var_144_28)

				local var_144_30 = manager.ui.mainCamera.transform.position - var_144_25.position

				var_144_25.forward = Vector3.New(var_144_30.x, var_144_30.y, var_144_30.z)

				local var_144_31 = var_144_25.localEulerAngles

				var_144_31.z = 0
				var_144_31.x = 0
				var_144_25.localEulerAngles = var_144_31
			end

			if arg_141_1.time_ >= var_144_26 + var_144_27 and arg_141_1.time_ < var_144_26 + var_144_27 + arg_144_0 then
				var_144_25.localPosition = Vector3.New(10, -0.85, -5.6)

				local var_144_32 = manager.ui.mainCamera.transform.position - var_144_25.position

				var_144_25.forward = Vector3.New(var_144_32.x, var_144_32.y, var_144_32.z)

				local var_144_33 = var_144_25.localEulerAngles

				var_144_33.z = 0
				var_144_33.x = 0
				var_144_25.localEulerAngles = var_144_33
			end

			local var_144_34 = arg_141_1.actors_["1039ui_story"].transform
			local var_144_35 = 0

			if var_144_35 < arg_141_1.time_ and arg_141_1.time_ <= var_144_35 + arg_144_0 then
				arg_141_1.var_.moveOldPos1039ui_story = var_144_34.localPosition
			end

			local var_144_36 = 0.001

			if var_144_35 <= arg_141_1.time_ and arg_141_1.time_ < var_144_35 + var_144_36 then
				local var_144_37 = (arg_141_1.time_ - var_144_35) / var_144_36
				local var_144_38 = Vector3.New(0, -1.06, -5.3)

				var_144_34.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1039ui_story, var_144_38, var_144_37)

				local var_144_39 = manager.ui.mainCamera.transform.position - var_144_34.position

				var_144_34.forward = Vector3.New(var_144_39.x, var_144_39.y, var_144_39.z)

				local var_144_40 = var_144_34.localEulerAngles

				var_144_40.z = 0
				var_144_40.x = 0
				var_144_34.localEulerAngles = var_144_40
			end

			if arg_141_1.time_ >= var_144_35 + var_144_36 and arg_141_1.time_ < var_144_35 + var_144_36 + arg_144_0 then
				var_144_34.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_144_41 = manager.ui.mainCamera.transform.position - var_144_34.position

				var_144_34.forward = Vector3.New(var_144_41.x, var_144_41.y, var_144_41.z)

				local var_144_42 = var_144_34.localEulerAngles

				var_144_42.z = 0
				var_144_42.x = 0
				var_144_34.localEulerAngles = var_144_42
			end

			local var_144_43 = 0

			if var_144_43 < arg_141_1.time_ and arg_141_1.time_ <= var_144_43 + arg_144_0 then
				arg_141_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			local var_144_44 = 0

			if var_144_44 < arg_141_1.time_ and arg_141_1.time_ <= var_144_44 + arg_144_0 then
				arg_141_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_144_45 = 0
			local var_144_46 = 0.125

			if var_144_45 < arg_141_1.time_ and arg_141_1.time_ <= var_144_45 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_47 = arg_141_1:FormatText(StoryNameCfg[9].name)

				arg_141_1.leftNameTxt_.text = var_144_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_48 = arg_141_1:GetWordFromCfg(103903035)
				local var_144_49 = arg_141_1:FormatText(var_144_48.content)

				arg_141_1.text_.text = var_144_49

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_50 = 5
				local var_144_51 = utf8.len(var_144_49)
				local var_144_52 = var_144_50 <= 0 and var_144_46 or var_144_46 * (var_144_51 / var_144_50)

				if var_144_52 > 0 and var_144_46 < var_144_52 then
					arg_141_1.talkMaxDuration = var_144_52

					if var_144_52 + var_144_45 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_52 + var_144_45
					end
				end

				arg_141_1.text_.text = var_144_49
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb") ~= 0 then
					local var_144_53 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb") / 1000

					if var_144_53 + var_144_45 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_53 + var_144_45
					end

					if var_144_48.prefab_name ~= "" and arg_141_1.actors_[var_144_48.prefab_name] ~= nil then
						local var_144_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_48.prefab_name].transform, "story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb")

						arg_141_1:RecordAudio("103903035", var_144_54)
						arg_141_1:RecordAudio("103903035", var_144_54)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_55 = math.max(var_144_46, arg_141_1.talkMaxDuration)

			if var_144_45 <= arg_141_1.time_ and arg_141_1.time_ < var_144_45 + var_144_55 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_45) / var_144_55

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_45 + var_144_55 and arg_141_1.time_ < var_144_45 + var_144_55 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play103903036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 103903036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play103903037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.525

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(103903036)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 21
				local var_148_5 = utf8.len(var_148_3)
				local var_148_6 = var_148_4 <= 0 and var_148_1 or var_148_1 * (var_148_5 / var_148_4)

				if var_148_6 > 0 and var_148_1 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_7 and arg_145_1.time_ < var_148_0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play103903037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 103903037
		arg_149_1.duration_ = 7.9

		local var_149_0 = {
			ja = 7.9,
			ko = 4.233,
			zh = 4.233,
			en = 4.466
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play103903038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_152_2 = 0
			local var_152_3 = 0.6

			if var_152_2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_4 = arg_149_1:FormatText(StoryNameCfg[9].name)

				arg_149_1.leftNameTxt_.text = var_152_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_5 = arg_149_1:GetWordFromCfg(103903037)
				local var_152_6 = arg_149_1:FormatText(var_152_5.content)

				arg_149_1.text_.text = var_152_6

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 24
				local var_152_8 = utf8.len(var_152_6)
				local var_152_9 = var_152_7 <= 0 and var_152_3 or var_152_3 * (var_152_8 / var_152_7)

				if var_152_9 > 0 and var_152_3 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_6
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb") / 1000

					if var_152_10 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_2
					end

					if var_152_5.prefab_name ~= "" and arg_149_1.actors_[var_152_5.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_5.prefab_name].transform, "story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb")

						arg_149_1:RecordAudio("103903037", var_152_11)
						arg_149_1:RecordAudio("103903037", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_12 and arg_149_1.time_ < var_152_2 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play103903038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 103903038
		arg_153_1.duration_ = 10.47

		local var_153_0 = {
			ja = 10.466,
			ko = 6.6,
			zh = 6.6,
			en = 10.2
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play103903039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_156_1 = 0
			local var_156_2 = 0.7

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_3 = arg_153_1:FormatText(StoryNameCfg[9].name)

				arg_153_1.leftNameTxt_.text = var_156_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_4 = arg_153_1:GetWordFromCfg(103903038)
				local var_156_5 = arg_153_1:FormatText(var_156_4.content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 28
				local var_156_7 = utf8.len(var_156_5)
				local var_156_8 = var_156_6 <= 0 and var_156_2 or var_156_2 * (var_156_7 / var_156_6)

				if var_156_8 > 0 and var_156_2 < var_156_8 then
					arg_153_1.talkMaxDuration = var_156_8

					if var_156_8 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb") ~= 0 then
					local var_156_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb") / 1000

					if var_156_9 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_1
					end

					if var_156_4.prefab_name ~= "" and arg_153_1.actors_[var_156_4.prefab_name] ~= nil then
						local var_156_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_4.prefab_name].transform, "story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb")

						arg_153_1:RecordAudio("103903038", var_156_10)
						arg_153_1:RecordAudio("103903038", var_156_10)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_11 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_11 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_11

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_11 and arg_153_1.time_ < var_156_1 + var_156_11 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play103903039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 103903039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play103903040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1039ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1039ui_story == nil then
				arg_157_1.var_.characterEffect1039ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.1

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1039ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1039ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1039ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1039ui_story.fillRatio = var_160_5
			end

			local var_160_6 = arg_157_1.actors_["1039ui_story"].transform
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 then
				arg_157_1.var_.moveOldPos1039ui_story = var_160_6.localPosition
			end

			local var_160_8 = 0.001

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8
				local var_160_10 = Vector3.New(10, -1.06, -5.3)

				var_160_6.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1039ui_story, var_160_10, var_160_9)

				local var_160_11 = manager.ui.mainCamera.transform.position - var_160_6.position

				var_160_6.forward = Vector3.New(var_160_11.x, var_160_11.y, var_160_11.z)

				local var_160_12 = var_160_6.localEulerAngles

				var_160_12.z = 0
				var_160_12.x = 0
				var_160_6.localEulerAngles = var_160_12
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 then
				var_160_6.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_160_13 = manager.ui.mainCamera.transform.position - var_160_6.position

				var_160_6.forward = Vector3.New(var_160_13.x, var_160_13.y, var_160_13.z)

				local var_160_14 = var_160_6.localEulerAngles

				var_160_14.z = 0
				var_160_14.x = 0
				var_160_6.localEulerAngles = var_160_14
			end

			local var_160_15 = 0
			local var_160_16 = 0.325

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_17 = arg_157_1:GetWordFromCfg(103903039)
				local var_160_18 = arg_157_1:FormatText(var_160_17.content)

				arg_157_1.text_.text = var_160_18

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_19 = 13
				local var_160_20 = utf8.len(var_160_18)
				local var_160_21 = var_160_19 <= 0 and var_160_16 or var_160_16 * (var_160_20 / var_160_19)

				if var_160_21 > 0 and var_160_16 < var_160_21 then
					arg_157_1.talkMaxDuration = var_160_21

					if var_160_21 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_21 + var_160_15
					end
				end

				arg_157_1.text_.text = var_160_18
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_22 = math.max(var_160_16, arg_157_1.talkMaxDuration)

			if var_160_15 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_22 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_15) / var_160_22

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_15 + var_160_22 and arg_157_1.time_ < var_160_15 + var_160_22 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play103903040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 103903040
		arg_161_1.duration_ = 4.2

		local var_161_0 = {
			ja = 4.2,
			ko = 2.866,
			zh = 2.866,
			en = 3.833
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play103903041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1027ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1027ui_story == nil then
				arg_161_1.var_.characterEffect1027ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.1

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1027ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1027ui_story then
				arg_161_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_164_4 = arg_161_1.actors_["1027ui_story"].transform
			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1.var_.moveOldPos1027ui_story = var_164_4.localPosition
			end

			local var_164_6 = 0.001

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_6 then
				local var_164_7 = (arg_161_1.time_ - var_164_5) / var_164_6
				local var_164_8 = Vector3.New(0, -0.922, -5.1)

				var_164_4.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1027ui_story, var_164_8, var_164_7)

				local var_164_9 = manager.ui.mainCamera.transform.position - var_164_4.position

				var_164_4.forward = Vector3.New(var_164_9.x, var_164_9.y, var_164_9.z)

				local var_164_10 = var_164_4.localEulerAngles

				var_164_10.z = 0
				var_164_10.x = 0
				var_164_4.localEulerAngles = var_164_10
			end

			if arg_161_1.time_ >= var_164_5 + var_164_6 and arg_161_1.time_ < var_164_5 + var_164_6 + arg_164_0 then
				var_164_4.localPosition = Vector3.New(0, -0.922, -5.1)

				local var_164_11 = manager.ui.mainCamera.transform.position - var_164_4.position

				var_164_4.forward = Vector3.New(var_164_11.x, var_164_11.y, var_164_11.z)

				local var_164_12 = var_164_4.localEulerAngles

				var_164_12.z = 0
				var_164_12.x = 0
				var_164_4.localEulerAngles = var_164_12
			end

			local var_164_13 = 0

			if var_164_13 < arg_161_1.time_ and arg_161_1.time_ <= var_164_13 + arg_164_0 then
				arg_161_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			local var_164_14 = 0

			if var_164_14 < arg_161_1.time_ and arg_161_1.time_ <= var_164_14 + arg_164_0 then
				arg_161_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_164_15 = 0
			local var_164_16 = 0.225

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_17 = arg_161_1:FormatText(StoryNameCfg[56].name)

				arg_161_1.leftNameTxt_.text = var_164_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_18 = arg_161_1:GetWordFromCfg(103903040)
				local var_164_19 = arg_161_1:FormatText(var_164_18.content)

				arg_161_1.text_.text = var_164_19

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_20 = 9
				local var_164_21 = utf8.len(var_164_19)
				local var_164_22 = var_164_20 <= 0 and var_164_16 or var_164_16 * (var_164_21 / var_164_20)

				if var_164_22 > 0 and var_164_16 < var_164_22 then
					arg_161_1.talkMaxDuration = var_164_22

					if var_164_22 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_22 + var_164_15
					end
				end

				arg_161_1.text_.text = var_164_19
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb") ~= 0 then
					local var_164_23 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb") / 1000

					if var_164_23 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_23 + var_164_15
					end

					if var_164_18.prefab_name ~= "" and arg_161_1.actors_[var_164_18.prefab_name] ~= nil then
						local var_164_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_18.prefab_name].transform, "story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb")

						arg_161_1:RecordAudio("103903040", var_164_24)
						arg_161_1:RecordAudio("103903040", var_164_24)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_25 = math.max(var_164_16, arg_161_1.talkMaxDuration)

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_25 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_15) / var_164_25

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_15 + var_164_25 and arg_161_1.time_ < var_164_15 + var_164_25 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play103903041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 103903041
		arg_165_1.duration_ = 4.3

		local var_165_0 = {
			ja = 4.3,
			ko = 4.233,
			zh = 4.233,
			en = 3.6
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play103903042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1148ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1148ui_story == nil then
				arg_165_1.var_.characterEffect1148ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.1

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1148ui_story and not isNil(var_168_0) then
					arg_165_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1148ui_story then
				arg_165_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_168_4 = arg_165_1.actors_["1027ui_story"]
			local var_168_5 = 0

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1027ui_story == nil then
				arg_165_1.var_.characterEffect1027ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_6 = 0.1

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_6 and not isNil(var_168_4) then
				local var_168_7 = (arg_165_1.time_ - var_168_5) / var_168_6

				if arg_165_1.var_.characterEffect1027ui_story and not isNil(var_168_4) then
					local var_168_8 = Mathf.Lerp(0, 0.5, var_168_7)

					arg_165_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1027ui_story.fillRatio = var_168_8
				end
			end

			if arg_165_1.time_ >= var_168_5 + var_168_6 and arg_165_1.time_ < var_168_5 + var_168_6 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1027ui_story then
				local var_168_9 = 0.5

				arg_165_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1027ui_story.fillRatio = var_168_9
			end

			local var_168_10 = arg_165_1.actors_["1027ui_story"].transform
			local var_168_11 = 0

			if var_168_11 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1.var_.moveOldPos1027ui_story = var_168_10.localPosition
			end

			local var_168_12 = 0.001

			if var_168_11 <= arg_165_1.time_ and arg_165_1.time_ < var_168_11 + var_168_12 then
				local var_168_13 = (arg_165_1.time_ - var_168_11) / var_168_12
				local var_168_14 = Vector3.New(10, -0.922, -5.1)

				var_168_10.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1027ui_story, var_168_14, var_168_13)

				local var_168_15 = manager.ui.mainCamera.transform.position - var_168_10.position

				var_168_10.forward = Vector3.New(var_168_15.x, var_168_15.y, var_168_15.z)

				local var_168_16 = var_168_10.localEulerAngles

				var_168_16.z = 0
				var_168_16.x = 0
				var_168_10.localEulerAngles = var_168_16
			end

			if arg_165_1.time_ >= var_168_11 + var_168_12 and arg_165_1.time_ < var_168_11 + var_168_12 + arg_168_0 then
				var_168_10.localPosition = Vector3.New(10, -0.922, -5.1)

				local var_168_17 = manager.ui.mainCamera.transform.position - var_168_10.position

				var_168_10.forward = Vector3.New(var_168_17.x, var_168_17.y, var_168_17.z)

				local var_168_18 = var_168_10.localEulerAngles

				var_168_18.z = 0
				var_168_18.x = 0
				var_168_10.localEulerAngles = var_168_18
			end

			local var_168_19 = arg_165_1.actors_["1148ui_story"].transform
			local var_168_20 = 0

			if var_168_20 < arg_165_1.time_ and arg_165_1.time_ <= var_168_20 + arg_168_0 then
				arg_165_1.var_.moveOldPos1148ui_story = var_168_19.localPosition
			end

			local var_168_21 = 0.001

			if var_168_20 <= arg_165_1.time_ and arg_165_1.time_ < var_168_20 + var_168_21 then
				local var_168_22 = (arg_165_1.time_ - var_168_20) / var_168_21
				local var_168_23 = Vector3.New(0, -0.85, -5.6)

				var_168_19.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1148ui_story, var_168_23, var_168_22)

				local var_168_24 = manager.ui.mainCamera.transform.position - var_168_19.position

				var_168_19.forward = Vector3.New(var_168_24.x, var_168_24.y, var_168_24.z)

				local var_168_25 = var_168_19.localEulerAngles

				var_168_25.z = 0
				var_168_25.x = 0
				var_168_19.localEulerAngles = var_168_25
			end

			if arg_165_1.time_ >= var_168_20 + var_168_21 and arg_165_1.time_ < var_168_20 + var_168_21 + arg_168_0 then
				var_168_19.localPosition = Vector3.New(0, -0.85, -5.6)

				local var_168_26 = manager.ui.mainCamera.transform.position - var_168_19.position

				var_168_19.forward = Vector3.New(var_168_26.x, var_168_26.y, var_168_26.z)

				local var_168_27 = var_168_19.localEulerAngles

				var_168_27.z = 0
				var_168_27.x = 0
				var_168_19.localEulerAngles = var_168_27
			end

			local var_168_28 = 0

			if var_168_28 < arg_165_1.time_ and arg_165_1.time_ <= var_168_28 + arg_168_0 then
				arg_165_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_168_29 = 0

			if var_168_29 < arg_165_1.time_ and arg_165_1.time_ <= var_168_29 + arg_168_0 then
				arg_165_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_168_30 = 0
			local var_168_31 = 0.475

			if var_168_30 < arg_165_1.time_ and arg_165_1.time_ <= var_168_30 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_32 = arg_165_1:FormatText(StoryNameCfg[8].name)

				arg_165_1.leftNameTxt_.text = var_168_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_33 = arg_165_1:GetWordFromCfg(103903041)
				local var_168_34 = arg_165_1:FormatText(var_168_33.content)

				arg_165_1.text_.text = var_168_34

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_35 = 19
				local var_168_36 = utf8.len(var_168_34)
				local var_168_37 = var_168_35 <= 0 and var_168_31 or var_168_31 * (var_168_36 / var_168_35)

				if var_168_37 > 0 and var_168_31 < var_168_37 then
					arg_165_1.talkMaxDuration = var_168_37

					if var_168_37 + var_168_30 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_37 + var_168_30
					end
				end

				arg_165_1.text_.text = var_168_34
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb") ~= 0 then
					local var_168_38 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb") / 1000

					if var_168_38 + var_168_30 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_38 + var_168_30
					end

					if var_168_33.prefab_name ~= "" and arg_165_1.actors_[var_168_33.prefab_name] ~= nil then
						local var_168_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_33.prefab_name].transform, "story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb")

						arg_165_1:RecordAudio("103903041", var_168_39)
						arg_165_1:RecordAudio("103903041", var_168_39)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_40 = math.max(var_168_31, arg_165_1.talkMaxDuration)

			if var_168_30 <= arg_165_1.time_ and arg_165_1.time_ < var_168_30 + var_168_40 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_30) / var_168_40

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_30 + var_168_40 and arg_165_1.time_ < var_168_30 + var_168_40 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play103903042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 103903042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play103903043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1148ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1148ui_story == nil then
				arg_169_1.var_.characterEffect1148ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.1

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1148ui_story and not isNil(var_172_0) then
					local var_172_4 = Mathf.Lerp(0, 0.5, var_172_3)

					arg_169_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1148ui_story.fillRatio = var_172_4
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1148ui_story then
				local var_172_5 = 0.5

				arg_169_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1148ui_story.fillRatio = var_172_5
			end

			local var_172_6 = arg_169_1.actors_["1148ui_story"].transform
			local var_172_7 = 0

			if var_172_7 < arg_169_1.time_ and arg_169_1.time_ <= var_172_7 + arg_172_0 then
				arg_169_1.var_.moveOldPos1148ui_story = var_172_6.localPosition
			end

			local var_172_8 = 0.001

			if var_172_7 <= arg_169_1.time_ and arg_169_1.time_ < var_172_7 + var_172_8 then
				local var_172_9 = (arg_169_1.time_ - var_172_7) / var_172_8
				local var_172_10 = Vector3.New(10, -0.85, -5.6)

				var_172_6.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1148ui_story, var_172_10, var_172_9)

				local var_172_11 = manager.ui.mainCamera.transform.position - var_172_6.position

				var_172_6.forward = Vector3.New(var_172_11.x, var_172_11.y, var_172_11.z)

				local var_172_12 = var_172_6.localEulerAngles

				var_172_12.z = 0
				var_172_12.x = 0
				var_172_6.localEulerAngles = var_172_12
			end

			if arg_169_1.time_ >= var_172_7 + var_172_8 and arg_169_1.time_ < var_172_7 + var_172_8 + arg_172_0 then
				var_172_6.localPosition = Vector3.New(10, -0.85, -5.6)

				local var_172_13 = manager.ui.mainCamera.transform.position - var_172_6.position

				var_172_6.forward = Vector3.New(var_172_13.x, var_172_13.y, var_172_13.z)

				local var_172_14 = var_172_6.localEulerAngles

				var_172_14.z = 0
				var_172_14.x = 0
				var_172_6.localEulerAngles = var_172_14
			end

			local var_172_15 = 0

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				arg_169_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_172_16 = 0
			local var_172_17 = 0.8

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_18 = arg_169_1:GetWordFromCfg(103903042)
				local var_172_19 = arg_169_1:FormatText(var_172_18.content)

				arg_169_1.text_.text = var_172_19

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_20 = 32
				local var_172_21 = utf8.len(var_172_19)
				local var_172_22 = var_172_20 <= 0 and var_172_17 or var_172_17 * (var_172_21 / var_172_20)

				if var_172_22 > 0 and var_172_17 < var_172_22 then
					arg_169_1.talkMaxDuration = var_172_22

					if var_172_22 + var_172_16 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_22 + var_172_16
					end
				end

				arg_169_1.text_.text = var_172_19
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_23 = math.max(var_172_17, arg_169_1.talkMaxDuration)

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_23 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_16) / var_172_23

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_16 + var_172_23 and arg_169_1.time_ < var_172_16 + var_172_23 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play103903043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 103903043
		arg_173_1.duration_ = 2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play103903044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1027ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1027ui_story == nil then
				arg_173_1.var_.characterEffect1027ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.1

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1027ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1027ui_story then
				arg_173_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_176_4 = arg_173_1.actors_["1148ui_story"]
			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1148ui_story == nil then
				arg_173_1.var_.characterEffect1148ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_6 = 0.1

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_6 and not isNil(var_176_4) then
				local var_176_7 = (arg_173_1.time_ - var_176_5) / var_176_6

				if arg_173_1.var_.characterEffect1148ui_story and not isNil(var_176_4) then
					arg_173_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_5 + var_176_6 and arg_173_1.time_ < var_176_5 + var_176_6 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1148ui_story then
				arg_173_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_176_8 = arg_173_1.actors_["1027ui_story"].transform
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.var_.moveOldPos1027ui_story = var_176_8.localPosition
			end

			local var_176_10 = 0.001

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_10 then
				local var_176_11 = (arg_173_1.time_ - var_176_9) / var_176_10
				local var_176_12 = Vector3.New(-0.92, -0.922, -5.1)

				var_176_8.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1027ui_story, var_176_12, var_176_11)

				local var_176_13 = manager.ui.mainCamera.transform.position - var_176_8.position

				var_176_8.forward = Vector3.New(var_176_13.x, var_176_13.y, var_176_13.z)

				local var_176_14 = var_176_8.localEulerAngles

				var_176_14.z = 0
				var_176_14.x = 0
				var_176_8.localEulerAngles = var_176_14
			end

			if arg_173_1.time_ >= var_176_9 + var_176_10 and arg_173_1.time_ < var_176_9 + var_176_10 + arg_176_0 then
				var_176_8.localPosition = Vector3.New(-0.92, -0.922, -5.1)

				local var_176_15 = manager.ui.mainCamera.transform.position - var_176_8.position

				var_176_8.forward = Vector3.New(var_176_15.x, var_176_15.y, var_176_15.z)

				local var_176_16 = var_176_8.localEulerAngles

				var_176_16.z = 0
				var_176_16.x = 0
				var_176_8.localEulerAngles = var_176_16
			end

			local var_176_17 = 0

			if var_176_17 < arg_173_1.time_ and arg_173_1.time_ <= var_176_17 + arg_176_0 then
				arg_173_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_176_18 = arg_173_1.actors_["1148ui_story"].transform
			local var_176_19 = 0

			if var_176_19 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 then
				arg_173_1.var_.moveOldPos1148ui_story = var_176_18.localPosition
			end

			local var_176_20 = 0.001

			if var_176_19 <= arg_173_1.time_ and arg_173_1.time_ < var_176_19 + var_176_20 then
				local var_176_21 = (arg_173_1.time_ - var_176_19) / var_176_20
				local var_176_22 = Vector3.New(0.83, -0.85, -5.6)

				var_176_18.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1148ui_story, var_176_22, var_176_21)

				local var_176_23 = manager.ui.mainCamera.transform.position - var_176_18.position

				var_176_18.forward = Vector3.New(var_176_23.x, var_176_23.y, var_176_23.z)

				local var_176_24 = var_176_18.localEulerAngles

				var_176_24.z = 0
				var_176_24.x = 0
				var_176_18.localEulerAngles = var_176_24
			end

			if arg_173_1.time_ >= var_176_19 + var_176_20 and arg_173_1.time_ < var_176_19 + var_176_20 + arg_176_0 then
				var_176_18.localPosition = Vector3.New(0.83, -0.85, -5.6)

				local var_176_25 = manager.ui.mainCamera.transform.position - var_176_18.position

				var_176_18.forward = Vector3.New(var_176_25.x, var_176_25.y, var_176_25.z)

				local var_176_26 = var_176_18.localEulerAngles

				var_176_26.z = 0
				var_176_26.x = 0
				var_176_18.localEulerAngles = var_176_26
			end

			local var_176_27 = 0

			if var_176_27 < arg_173_1.time_ and arg_173_1.time_ <= var_176_27 + arg_176_0 then
				arg_173_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_176_28 = 0

			if var_176_28 < arg_173_1.time_ and arg_173_1.time_ <= var_176_28 + arg_176_0 then
				arg_173_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_176_29 = 0
			local var_176_30 = 0.05

			if var_176_29 < arg_173_1.time_ and arg_173_1.time_ <= var_176_29 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_31 = arg_173_1:FormatText(StoryNameCfg[114].name)

				arg_173_1.leftNameTxt_.text = var_176_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_32 = arg_173_1:GetWordFromCfg(103903043)
				local var_176_33 = arg_173_1:FormatText(var_176_32.content)

				arg_173_1.text_.text = var_176_33

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_34 = 2
				local var_176_35 = utf8.len(var_176_33)
				local var_176_36 = var_176_34 <= 0 and var_176_30 or var_176_30 * (var_176_35 / var_176_34)

				if var_176_36 > 0 and var_176_30 < var_176_36 then
					arg_173_1.talkMaxDuration = var_176_36

					if var_176_36 + var_176_29 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_36 + var_176_29
					end
				end

				arg_173_1.text_.text = var_176_33
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb") ~= 0 then
					local var_176_37 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb") / 1000

					if var_176_37 + var_176_29 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_37 + var_176_29
					end

					if var_176_32.prefab_name ~= "" and arg_173_1.actors_[var_176_32.prefab_name] ~= nil then
						local var_176_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_32.prefab_name].transform, "story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb")

						arg_173_1:RecordAudio("103903043", var_176_38)
						arg_173_1:RecordAudio("103903043", var_176_38)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_39 = math.max(var_176_30, arg_173_1.talkMaxDuration)

			if var_176_29 <= arg_173_1.time_ and arg_173_1.time_ < var_176_29 + var_176_39 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_29) / var_176_39

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_29 + var_176_39 and arg_173_1.time_ < var_176_29 + var_176_39 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play103903044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 103903044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play103903045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.75

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_2 = arg_177_1:GetWordFromCfg(103903044)
				local var_180_3 = arg_177_1:FormatText(var_180_2.content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 30
				local var_180_5 = utf8.len(var_180_3)
				local var_180_6 = var_180_4 <= 0 and var_180_1 or var_180_1 * (var_180_5 / var_180_4)

				if var_180_6 > 0 and var_180_1 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_7 and arg_177_1.time_ < var_180_0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play103903045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 103903045
		arg_181_1.duration_ = 4.1

		local var_181_0 = {
			ja = 4.1,
			ko = 3.566,
			zh = 3.566,
			en = 3.3
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play103903046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1039ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1039ui_story == nil then
				arg_181_1.var_.characterEffect1039ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.1

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1039ui_story and not isNil(var_184_0) then
					arg_181_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1039ui_story then
				arg_181_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["1027ui_story"]
			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1027ui_story == nil then
				arg_181_1.var_.characterEffect1027ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.1

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_6 and not isNil(var_184_4) then
				local var_184_7 = (arg_181_1.time_ - var_184_5) / var_184_6

				if arg_181_1.var_.characterEffect1027ui_story and not isNil(var_184_4) then
					local var_184_8 = Mathf.Lerp(0, 0.5, var_184_7)

					arg_181_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1027ui_story.fillRatio = var_184_8
				end
			end

			if arg_181_1.time_ >= var_184_5 + var_184_6 and arg_181_1.time_ < var_184_5 + var_184_6 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1027ui_story then
				local var_184_9 = 0.5

				arg_181_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1027ui_story.fillRatio = var_184_9
			end

			local var_184_10 = arg_181_1.actors_["1148ui_story"]
			local var_184_11 = 0

			if var_184_11 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 and not isNil(var_184_10) and arg_181_1.var_.characterEffect1148ui_story == nil then
				arg_181_1.var_.characterEffect1148ui_story = var_184_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_12 = 0.1

			if var_184_11 <= arg_181_1.time_ and arg_181_1.time_ < var_184_11 + var_184_12 and not isNil(var_184_10) then
				local var_184_13 = (arg_181_1.time_ - var_184_11) / var_184_12

				if arg_181_1.var_.characterEffect1148ui_story and not isNil(var_184_10) then
					local var_184_14 = Mathf.Lerp(0, 0.5, var_184_13)

					arg_181_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1148ui_story.fillRatio = var_184_14
				end
			end

			if arg_181_1.time_ >= var_184_11 + var_184_12 and arg_181_1.time_ < var_184_11 + var_184_12 + arg_184_0 and not isNil(var_184_10) and arg_181_1.var_.characterEffect1148ui_story then
				local var_184_15 = 0.5

				arg_181_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1148ui_story.fillRatio = var_184_15
			end

			local var_184_16 = arg_181_1.actors_["1027ui_story"].transform
			local var_184_17 = 0

			if var_184_17 < arg_181_1.time_ and arg_181_1.time_ <= var_184_17 + arg_184_0 then
				arg_181_1.var_.moveOldPos1027ui_story = var_184_16.localPosition
			end

			local var_184_18 = 0.001

			if var_184_17 <= arg_181_1.time_ and arg_181_1.time_ < var_184_17 + var_184_18 then
				local var_184_19 = (arg_181_1.time_ - var_184_17) / var_184_18
				local var_184_20 = Vector3.New(10, -0.922, -5.1)

				var_184_16.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1027ui_story, var_184_20, var_184_19)

				local var_184_21 = manager.ui.mainCamera.transform.position - var_184_16.position

				var_184_16.forward = Vector3.New(var_184_21.x, var_184_21.y, var_184_21.z)

				local var_184_22 = var_184_16.localEulerAngles

				var_184_22.z = 0
				var_184_22.x = 0
				var_184_16.localEulerAngles = var_184_22
			end

			if arg_181_1.time_ >= var_184_17 + var_184_18 and arg_181_1.time_ < var_184_17 + var_184_18 + arg_184_0 then
				var_184_16.localPosition = Vector3.New(10, -0.922, -5.1)

				local var_184_23 = manager.ui.mainCamera.transform.position - var_184_16.position

				var_184_16.forward = Vector3.New(var_184_23.x, var_184_23.y, var_184_23.z)

				local var_184_24 = var_184_16.localEulerAngles

				var_184_24.z = 0
				var_184_24.x = 0
				var_184_16.localEulerAngles = var_184_24
			end

			local var_184_25 = arg_181_1.actors_["1148ui_story"].transform
			local var_184_26 = 0

			if var_184_26 < arg_181_1.time_ and arg_181_1.time_ <= var_184_26 + arg_184_0 then
				arg_181_1.var_.moveOldPos1148ui_story = var_184_25.localPosition
			end

			local var_184_27 = 0.001

			if var_184_26 <= arg_181_1.time_ and arg_181_1.time_ < var_184_26 + var_184_27 then
				local var_184_28 = (arg_181_1.time_ - var_184_26) / var_184_27
				local var_184_29 = Vector3.New(10, -0.85, -5.6)

				var_184_25.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1148ui_story, var_184_29, var_184_28)

				local var_184_30 = manager.ui.mainCamera.transform.position - var_184_25.position

				var_184_25.forward = Vector3.New(var_184_30.x, var_184_30.y, var_184_30.z)

				local var_184_31 = var_184_25.localEulerAngles

				var_184_31.z = 0
				var_184_31.x = 0
				var_184_25.localEulerAngles = var_184_31
			end

			if arg_181_1.time_ >= var_184_26 + var_184_27 and arg_181_1.time_ < var_184_26 + var_184_27 + arg_184_0 then
				var_184_25.localPosition = Vector3.New(10, -0.85, -5.6)

				local var_184_32 = manager.ui.mainCamera.transform.position - var_184_25.position

				var_184_25.forward = Vector3.New(var_184_32.x, var_184_32.y, var_184_32.z)

				local var_184_33 = var_184_25.localEulerAngles

				var_184_33.z = 0
				var_184_33.x = 0
				var_184_25.localEulerAngles = var_184_33
			end

			local var_184_34 = arg_181_1.actors_["1039ui_story"].transform
			local var_184_35 = 0

			if var_184_35 < arg_181_1.time_ and arg_181_1.time_ <= var_184_35 + arg_184_0 then
				arg_181_1.var_.moveOldPos1039ui_story = var_184_34.localPosition
			end

			local var_184_36 = 0.001

			if var_184_35 <= arg_181_1.time_ and arg_181_1.time_ < var_184_35 + var_184_36 then
				local var_184_37 = (arg_181_1.time_ - var_184_35) / var_184_36
				local var_184_38 = Vector3.New(0, -1.06, -5.3)

				var_184_34.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1039ui_story, var_184_38, var_184_37)

				local var_184_39 = manager.ui.mainCamera.transform.position - var_184_34.position

				var_184_34.forward = Vector3.New(var_184_39.x, var_184_39.y, var_184_39.z)

				local var_184_40 = var_184_34.localEulerAngles

				var_184_40.z = 0
				var_184_40.x = 0
				var_184_34.localEulerAngles = var_184_40
			end

			if arg_181_1.time_ >= var_184_35 + var_184_36 and arg_181_1.time_ < var_184_35 + var_184_36 + arg_184_0 then
				var_184_34.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_184_41 = manager.ui.mainCamera.transform.position - var_184_34.position

				var_184_34.forward = Vector3.New(var_184_41.x, var_184_41.y, var_184_41.z)

				local var_184_42 = var_184_34.localEulerAngles

				var_184_42.z = 0
				var_184_42.x = 0
				var_184_34.localEulerAngles = var_184_42
			end

			local var_184_43 = 0

			if var_184_43 < arg_181_1.time_ and arg_181_1.time_ <= var_184_43 + arg_184_0 then
				arg_181_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			local var_184_44 = 0

			if var_184_44 < arg_181_1.time_ and arg_181_1.time_ <= var_184_44 + arg_184_0 then
				arg_181_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_184_45 = 0
			local var_184_46 = 0.35

			if var_184_45 < arg_181_1.time_ and arg_181_1.time_ <= var_184_45 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_47 = arg_181_1:FormatText(StoryNameCfg[9].name)

				arg_181_1.leftNameTxt_.text = var_184_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_48 = arg_181_1:GetWordFromCfg(103903045)
				local var_184_49 = arg_181_1:FormatText(var_184_48.content)

				arg_181_1.text_.text = var_184_49

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_50 = 14
				local var_184_51 = utf8.len(var_184_49)
				local var_184_52 = var_184_50 <= 0 and var_184_46 or var_184_46 * (var_184_51 / var_184_50)

				if var_184_52 > 0 and var_184_46 < var_184_52 then
					arg_181_1.talkMaxDuration = var_184_52

					if var_184_52 + var_184_45 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_52 + var_184_45
					end
				end

				arg_181_1.text_.text = var_184_49
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb") ~= 0 then
					local var_184_53 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb") / 1000

					if var_184_53 + var_184_45 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_53 + var_184_45
					end

					if var_184_48.prefab_name ~= "" and arg_181_1.actors_[var_184_48.prefab_name] ~= nil then
						local var_184_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_48.prefab_name].transform, "story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb")

						arg_181_1:RecordAudio("103903045", var_184_54)
						arg_181_1:RecordAudio("103903045", var_184_54)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_55 = math.max(var_184_46, arg_181_1.talkMaxDuration)

			if var_184_45 <= arg_181_1.time_ and arg_181_1.time_ < var_184_45 + var_184_55 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_45) / var_184_55

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_45 + var_184_55 and arg_181_1.time_ < var_184_45 + var_184_55 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play103903046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 103903046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play103903047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1039ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1039ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(10, -1.06, -5.3)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1039ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = 0
			local var_188_10 = 0.65

			if var_188_9 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_11 = arg_185_1:GetWordFromCfg(103903046)
				local var_188_12 = arg_185_1:FormatText(var_188_11.content)

				arg_185_1.text_.text = var_188_12

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 26
				local var_188_14 = utf8.len(var_188_12)
				local var_188_15 = var_188_13 <= 0 and var_188_10 or var_188_10 * (var_188_14 / var_188_13)

				if var_188_15 > 0 and var_188_10 < var_188_15 then
					arg_185_1.talkMaxDuration = var_188_15

					if var_188_15 + var_188_9 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_15 + var_188_9
					end
				end

				arg_185_1.text_.text = var_188_12
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_10, arg_185_1.talkMaxDuration)

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_9) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_9 + var_188_16 and arg_185_1.time_ < var_188_9 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play103903047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 103903047
		arg_189_1.duration_ = 3

		local var_189_0 = {
			ja = 2.766,
			ko = 3,
			zh = 3,
			en = 1.999999999999
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play103903048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1027ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1027ui_story == nil then
				arg_189_1.var_.characterEffect1027ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.1

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1027ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1027ui_story then
				arg_189_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_192_4 = arg_189_1.actors_["1148ui_story"]
			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1148ui_story == nil then
				arg_189_1.var_.characterEffect1148ui_story = var_192_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.1

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_6 and not isNil(var_192_4) then
				local var_192_7 = (arg_189_1.time_ - var_192_5) / var_192_6

				if arg_189_1.var_.characterEffect1148ui_story and not isNil(var_192_4) then
					arg_189_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_5 + var_192_6 and arg_189_1.time_ < var_192_5 + var_192_6 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1148ui_story then
				arg_189_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_192_8 = arg_189_1.actors_["1027ui_story"].transform
			local var_192_9 = 0

			if var_192_9 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1.var_.moveOldPos1027ui_story = var_192_8.localPosition
			end

			local var_192_10 = 0.001

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_10 then
				local var_192_11 = (arg_189_1.time_ - var_192_9) / var_192_10
				local var_192_12 = Vector3.New(-0.92, -0.922, -5.1)

				var_192_8.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1027ui_story, var_192_12, var_192_11)

				local var_192_13 = manager.ui.mainCamera.transform.position - var_192_8.position

				var_192_8.forward = Vector3.New(var_192_13.x, var_192_13.y, var_192_13.z)

				local var_192_14 = var_192_8.localEulerAngles

				var_192_14.z = 0
				var_192_14.x = 0
				var_192_8.localEulerAngles = var_192_14
			end

			if arg_189_1.time_ >= var_192_9 + var_192_10 and arg_189_1.time_ < var_192_9 + var_192_10 + arg_192_0 then
				var_192_8.localPosition = Vector3.New(-0.92, -0.922, -5.1)

				local var_192_15 = manager.ui.mainCamera.transform.position - var_192_8.position

				var_192_8.forward = Vector3.New(var_192_15.x, var_192_15.y, var_192_15.z)

				local var_192_16 = var_192_8.localEulerAngles

				var_192_16.z = 0
				var_192_16.x = 0
				var_192_8.localEulerAngles = var_192_16
			end

			local var_192_17 = 0

			if var_192_17 < arg_189_1.time_ and arg_189_1.time_ <= var_192_17 + arg_192_0 then
				arg_189_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_192_18 = arg_189_1.actors_["1148ui_story"].transform
			local var_192_19 = 0

			if var_192_19 < arg_189_1.time_ and arg_189_1.time_ <= var_192_19 + arg_192_0 then
				arg_189_1.var_.moveOldPos1148ui_story = var_192_18.localPosition
			end

			local var_192_20 = 0.001

			if var_192_19 <= arg_189_1.time_ and arg_189_1.time_ < var_192_19 + var_192_20 then
				local var_192_21 = (arg_189_1.time_ - var_192_19) / var_192_20
				local var_192_22 = Vector3.New(0.83, -0.85, -5.6)

				var_192_18.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1148ui_story, var_192_22, var_192_21)

				local var_192_23 = manager.ui.mainCamera.transform.position - var_192_18.position

				var_192_18.forward = Vector3.New(var_192_23.x, var_192_23.y, var_192_23.z)

				local var_192_24 = var_192_18.localEulerAngles

				var_192_24.z = 0
				var_192_24.x = 0
				var_192_18.localEulerAngles = var_192_24
			end

			if arg_189_1.time_ >= var_192_19 + var_192_20 and arg_189_1.time_ < var_192_19 + var_192_20 + arg_192_0 then
				var_192_18.localPosition = Vector3.New(0.83, -0.85, -5.6)

				local var_192_25 = manager.ui.mainCamera.transform.position - var_192_18.position

				var_192_18.forward = Vector3.New(var_192_25.x, var_192_25.y, var_192_25.z)

				local var_192_26 = var_192_18.localEulerAngles

				var_192_26.z = 0
				var_192_26.x = 0
				var_192_18.localEulerAngles = var_192_26
			end

			local var_192_27 = 0

			if var_192_27 < arg_189_1.time_ and arg_189_1.time_ <= var_192_27 + arg_192_0 then
				arg_189_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_192_28 = 0

			if var_192_28 < arg_189_1.time_ and arg_189_1.time_ <= var_192_28 + arg_192_0 then
				arg_189_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_192_29 = 0
			local var_192_30 = 0.075

			if var_192_29 < arg_189_1.time_ and arg_189_1.time_ <= var_192_29 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_31 = arg_189_1:FormatText(StoryNameCfg[114].name)

				arg_189_1.leftNameTxt_.text = var_192_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_32 = arg_189_1:GetWordFromCfg(103903047)
				local var_192_33 = arg_189_1:FormatText(var_192_32.content)

				arg_189_1.text_.text = var_192_33

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_34 = 3
				local var_192_35 = utf8.len(var_192_33)
				local var_192_36 = var_192_34 <= 0 and var_192_30 or var_192_30 * (var_192_35 / var_192_34)

				if var_192_36 > 0 and var_192_30 < var_192_36 then
					arg_189_1.talkMaxDuration = var_192_36

					if var_192_36 + var_192_29 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_36 + var_192_29
					end
				end

				arg_189_1.text_.text = var_192_33
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb") ~= 0 then
					local var_192_37 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb") / 1000

					if var_192_37 + var_192_29 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_37 + var_192_29
					end

					if var_192_32.prefab_name ~= "" and arg_189_1.actors_[var_192_32.prefab_name] ~= nil then
						local var_192_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_32.prefab_name].transform, "story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb")

						arg_189_1:RecordAudio("103903047", var_192_38)
						arg_189_1:RecordAudio("103903047", var_192_38)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_39 = math.max(var_192_30, arg_189_1.talkMaxDuration)

			if var_192_29 <= arg_189_1.time_ and arg_189_1.time_ < var_192_29 + var_192_39 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_29) / var_192_39

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_29 + var_192_39 and arg_189_1.time_ < var_192_29 + var_192_39 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play103903048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 103903048
		arg_193_1.duration_ = 1.2

		local var_193_0 = {
			ja = 1.133,
			ko = 1.033,
			zh = 1.033,
			en = 1.2
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
				arg_193_0:Play103903049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_196_1 = 0
			local var_196_2 = 0.025

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_3 = arg_193_1:FormatText(StoryNameCfg[114].name)

				arg_193_1.leftNameTxt_.text = var_196_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_4 = arg_193_1:GetWordFromCfg(103903048)
				local var_196_5 = arg_193_1:FormatText(var_196_4.content)

				arg_193_1.text_.text = var_196_5

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_6 = 1
				local var_196_7 = utf8.len(var_196_5)
				local var_196_8 = var_196_6 <= 0 and var_196_2 or var_196_2 * (var_196_7 / var_196_6)

				if var_196_8 > 0 and var_196_2 < var_196_8 then
					arg_193_1.talkMaxDuration = var_196_8

					if var_196_8 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_5
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb") ~= 0 then
					local var_196_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb") / 1000

					if var_196_9 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_1
					end

					if var_196_4.prefab_name ~= "" and arg_193_1.actors_[var_196_4.prefab_name] ~= nil then
						local var_196_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_4.prefab_name].transform, "story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb")

						arg_193_1:RecordAudio("103903048", var_196_10)
						arg_193_1:RecordAudio("103903048", var_196_10)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_11 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_11 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_11

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_11 and arg_193_1.time_ < var_196_1 + var_196_11 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play103903049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 103903049
		arg_197_1.duration_ = 3.87

		local var_197_0 = {
			ja = 3.7,
			ko = 3.166,
			zh = 3.166,
			en = 3.866
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play103903050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1148ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1148ui_story == nil then
				arg_197_1.var_.characterEffect1148ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.1

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1148ui_story and not isNil(var_200_0) then
					local var_200_4 = Mathf.Lerp(0, 0.5, var_200_3)

					arg_197_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1148ui_story.fillRatio = var_200_4
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1148ui_story then
				local var_200_5 = 0.5

				arg_197_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1148ui_story.fillRatio = var_200_5
			end

			local var_200_6 = 0

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action423")
			end

			local var_200_7 = 0

			if var_200_7 < arg_197_1.time_ and arg_197_1.time_ <= var_200_7 + arg_200_0 then
				arg_197_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_200_8 = 0
			local var_200_9 = 0.225

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_10 = arg_197_1:FormatText(StoryNameCfg[56].name)

				arg_197_1.leftNameTxt_.text = var_200_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_11 = arg_197_1:GetWordFromCfg(103903049)
				local var_200_12 = arg_197_1:FormatText(var_200_11.content)

				arg_197_1.text_.text = var_200_12

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 9
				local var_200_14 = utf8.len(var_200_12)
				local var_200_15 = var_200_13 <= 0 and var_200_9 or var_200_9 * (var_200_14 / var_200_13)

				if var_200_15 > 0 and var_200_9 < var_200_15 then
					arg_197_1.talkMaxDuration = var_200_15

					if var_200_15 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_15 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_12
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb") ~= 0 then
					local var_200_16 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb") / 1000

					if var_200_16 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_16 + var_200_8
					end

					if var_200_11.prefab_name ~= "" and arg_197_1.actors_[var_200_11.prefab_name] ~= nil then
						local var_200_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_11.prefab_name].transform, "story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb")

						arg_197_1:RecordAudio("103903049", var_200_17)
						arg_197_1:RecordAudio("103903049", var_200_17)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_18 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_18 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_18

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_18 and arg_197_1.time_ < var_200_8 + var_200_18 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play103903050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 103903050
		arg_201_1.duration_ = 5.97

		local var_201_0 = {
			ja = 5.233,
			ko = 5.4,
			zh = 5.4,
			en = 5.966
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play103903051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1148ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1148ui_story == nil then
				arg_201_1.var_.characterEffect1148ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.1

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1148ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1148ui_story then
				arg_201_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_204_4 = arg_201_1.actors_["1027ui_story"]
			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1027ui_story == nil then
				arg_201_1.var_.characterEffect1027ui_story = var_204_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_6 = 0.1

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_6 and not isNil(var_204_4) then
				local var_204_7 = (arg_201_1.time_ - var_204_5) / var_204_6

				if arg_201_1.var_.characterEffect1027ui_story and not isNil(var_204_4) then
					local var_204_8 = Mathf.Lerp(0, 0.5, var_204_7)

					arg_201_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1027ui_story.fillRatio = var_204_8
				end
			end

			if arg_201_1.time_ >= var_204_5 + var_204_6 and arg_201_1.time_ < var_204_5 + var_204_6 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1027ui_story then
				local var_204_9 = 0.5

				arg_201_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1027ui_story.fillRatio = var_204_9
			end

			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action437")
			end

			local var_204_11 = 0

			if var_204_11 < arg_201_1.time_ and arg_201_1.time_ <= var_204_11 + arg_204_0 then
				arg_201_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_204_12 = 0
			local var_204_13 = 0.525

			if var_204_12 < arg_201_1.time_ and arg_201_1.time_ <= var_204_12 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_14 = arg_201_1:FormatText(StoryNameCfg[8].name)

				arg_201_1.leftNameTxt_.text = var_204_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_15 = arg_201_1:GetWordFromCfg(103903050)
				local var_204_16 = arg_201_1:FormatText(var_204_15.content)

				arg_201_1.text_.text = var_204_16

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_17 = 21
				local var_204_18 = utf8.len(var_204_16)
				local var_204_19 = var_204_17 <= 0 and var_204_13 or var_204_13 * (var_204_18 / var_204_17)

				if var_204_19 > 0 and var_204_13 < var_204_19 then
					arg_201_1.talkMaxDuration = var_204_19

					if var_204_19 + var_204_12 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_19 + var_204_12
					end
				end

				arg_201_1.text_.text = var_204_16
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb") ~= 0 then
					local var_204_20 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb") / 1000

					if var_204_20 + var_204_12 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_20 + var_204_12
					end

					if var_204_15.prefab_name ~= "" and arg_201_1.actors_[var_204_15.prefab_name] ~= nil then
						local var_204_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_15.prefab_name].transform, "story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb")

						arg_201_1:RecordAudio("103903050", var_204_21)
						arg_201_1:RecordAudio("103903050", var_204_21)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_22 = math.max(var_204_13, arg_201_1.talkMaxDuration)

			if var_204_12 <= arg_201_1.time_ and arg_201_1.time_ < var_204_12 + var_204_22 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_12) / var_204_22

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_12 + var_204_22 and arg_201_1.time_ < var_204_12 + var_204_22 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play103903051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 103903051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play103903052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1027ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1027ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(10, -0.922, -5.1)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1027ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(10, -0.922, -5.1)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["1148ui_story"].transform
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 then
				arg_205_1.var_.moveOldPos1148ui_story = var_208_9.localPosition
			end

			local var_208_11 = 0.001

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11
				local var_208_13 = Vector3.New(10, -0.85, -5.6)

				var_208_9.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1148ui_story, var_208_13, var_208_12)

				local var_208_14 = manager.ui.mainCamera.transform.position - var_208_9.position

				var_208_9.forward = Vector3.New(var_208_14.x, var_208_14.y, var_208_14.z)

				local var_208_15 = var_208_9.localEulerAngles

				var_208_15.z = 0
				var_208_15.x = 0
				var_208_9.localEulerAngles = var_208_15
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 then
				var_208_9.localPosition = Vector3.New(10, -0.85, -5.6)

				local var_208_16 = manager.ui.mainCamera.transform.position - var_208_9.position

				var_208_9.forward = Vector3.New(var_208_16.x, var_208_16.y, var_208_16.z)

				local var_208_17 = var_208_9.localEulerAngles

				var_208_17.z = 0
				var_208_17.x = 0
				var_208_9.localEulerAngles = var_208_17
			end

			local var_208_18 = 0
			local var_208_19 = 0.45

			if var_208_18 < arg_205_1.time_ and arg_205_1.time_ <= var_208_18 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_20 = arg_205_1:GetWordFromCfg(103903051)
				local var_208_21 = arg_205_1:FormatText(var_208_20.content)

				arg_205_1.text_.text = var_208_21

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_22 = 18
				local var_208_23 = utf8.len(var_208_21)
				local var_208_24 = var_208_22 <= 0 and var_208_19 or var_208_19 * (var_208_23 / var_208_22)

				if var_208_24 > 0 and var_208_19 < var_208_24 then
					arg_205_1.talkMaxDuration = var_208_24

					if var_208_24 + var_208_18 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_24 + var_208_18
					end
				end

				arg_205_1.text_.text = var_208_21
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_25 = math.max(var_208_19, arg_205_1.talkMaxDuration)

			if var_208_18 <= arg_205_1.time_ and arg_205_1.time_ < var_208_18 + var_208_25 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_18) / var_208_25

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_18 + var_208_25 and arg_205_1.time_ < var_208_18 + var_208_25 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play103903052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 103903052
		arg_209_1.duration_ = 6.17

		local var_209_0 = {
			ja = 6.166,
			ko = 2.1,
			zh = 2.1,
			en = 2.2
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
				arg_209_0:Play103903053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1039ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1039ui_story == nil then
				arg_209_1.var_.characterEffect1039ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.1

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1039ui_story and not isNil(var_212_0) then
					arg_209_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1039ui_story then
				arg_209_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_212_4 = arg_209_1.bgs_.ST02.transform
			local var_212_5 = 0

			if var_212_5 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.var_.moveOldPosST02 = var_212_4.localPosition
			end

			local var_212_6 = 0.001

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_6 then
				local var_212_7 = (arg_209_1.time_ - var_212_5) / var_212_6
				local var_212_8 = Vector3.New(0, -100, 10)

				var_212_4.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPosST02, var_212_8, var_212_7)
			end

			if arg_209_1.time_ >= var_212_5 + var_212_6 and arg_209_1.time_ < var_212_5 + var_212_6 + arg_212_0 then
				var_212_4.localPosition = Vector3.New(0, -100, 10)
			end

			local var_212_9 = 0

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				local var_212_10 = manager.ui.mainCamera.transform.localPosition
				local var_212_11 = Vector3.New(0, 0, 10) + Vector3.New(var_212_10.x, var_212_10.y, 0)
				local var_212_12 = arg_209_1.bgs_.ST03

				var_212_12.transform.localPosition = var_212_11
				var_212_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_13 = var_212_12:GetComponent("SpriteRenderer")

				if var_212_13 and var_212_13.sprite then
					local var_212_14 = (var_212_12.transform.localPosition - var_212_10).z
					local var_212_15 = manager.ui.mainCameraCom_
					local var_212_16 = 2 * var_212_14 * Mathf.Tan(var_212_15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_212_17 = var_212_16 * var_212_15.aspect
					local var_212_18 = var_212_13.sprite.bounds.size.x
					local var_212_19 = var_212_13.sprite.bounds.size.y
					local var_212_20 = var_212_17 / var_212_18
					local var_212_21 = var_212_16 / var_212_19
					local var_212_22 = var_212_21 < var_212_20 and var_212_20 or var_212_21

					var_212_12.transform.localScale = Vector3.New(var_212_22, var_212_22, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "ST03" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_23 = arg_209_1.actors_["1039ui_story"].transform
			local var_212_24 = 0

			if var_212_24 < arg_209_1.time_ and arg_209_1.time_ <= var_212_24 + arg_212_0 then
				arg_209_1.var_.moveOldPos1039ui_story = var_212_23.localPosition
			end

			local var_212_25 = 0.001

			if var_212_24 <= arg_209_1.time_ and arg_209_1.time_ < var_212_24 + var_212_25 then
				local var_212_26 = (arg_209_1.time_ - var_212_24) / var_212_25
				local var_212_27 = Vector3.New(0, -1.06, -5.3)

				var_212_23.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1039ui_story, var_212_27, var_212_26)

				local var_212_28 = manager.ui.mainCamera.transform.position - var_212_23.position

				var_212_23.forward = Vector3.New(var_212_28.x, var_212_28.y, var_212_28.z)

				local var_212_29 = var_212_23.localEulerAngles

				var_212_29.z = 0
				var_212_29.x = 0
				var_212_23.localEulerAngles = var_212_29
			end

			if arg_209_1.time_ >= var_212_24 + var_212_25 and arg_209_1.time_ < var_212_24 + var_212_25 + arg_212_0 then
				var_212_23.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_212_30 = manager.ui.mainCamera.transform.position - var_212_23.position

				var_212_23.forward = Vector3.New(var_212_30.x, var_212_30.y, var_212_30.z)

				local var_212_31 = var_212_23.localEulerAngles

				var_212_31.z = 0
				var_212_31.x = 0
				var_212_23.localEulerAngles = var_212_31
			end

			local var_212_32 = 0

			if var_212_32 < arg_209_1.time_ and arg_209_1.time_ <= var_212_32 + arg_212_0 then
				arg_209_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			local var_212_33 = 0

			if var_212_33 < arg_209_1.time_ and arg_209_1.time_ <= var_212_33 + arg_212_0 then
				arg_209_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_212_34 = 0
			local var_212_35 = 0.25

			if var_212_34 < arg_209_1.time_ and arg_209_1.time_ <= var_212_34 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_36 = arg_209_1:FormatText(StoryNameCfg[9].name)

				arg_209_1.leftNameTxt_.text = var_212_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_37 = arg_209_1:GetWordFromCfg(103903052)
				local var_212_38 = arg_209_1:FormatText(var_212_37.content)

				arg_209_1.text_.text = var_212_38

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_39 = 10
				local var_212_40 = utf8.len(var_212_38)
				local var_212_41 = var_212_39 <= 0 and var_212_35 or var_212_35 * (var_212_40 / var_212_39)

				if var_212_41 > 0 and var_212_35 < var_212_41 then
					arg_209_1.talkMaxDuration = var_212_41

					if var_212_41 + var_212_34 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_41 + var_212_34
					end
				end

				arg_209_1.text_.text = var_212_38
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb") ~= 0 then
					local var_212_42 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb") / 1000

					if var_212_42 + var_212_34 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_42 + var_212_34
					end

					if var_212_37.prefab_name ~= "" and arg_209_1.actors_[var_212_37.prefab_name] ~= nil then
						local var_212_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_37.prefab_name].transform, "story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb")

						arg_209_1:RecordAudio("103903052", var_212_43)
						arg_209_1:RecordAudio("103903052", var_212_43)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_44 = math.max(var_212_35, arg_209_1.talkMaxDuration)

			if var_212_34 <= arg_209_1.time_ and arg_209_1.time_ < var_212_34 + var_212_44 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_34) / var_212_44

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_34 + var_212_44 and arg_209_1.time_ < var_212_34 + var_212_44 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST02",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
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
	Play103903053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 103903053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play103903054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1039ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1039ui_story == nil then
				arg_213_1.var_.characterEffect1039ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.1

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1039ui_story and not isNil(var_216_0) then
					local var_216_4 = Mathf.Lerp(0, 0.5, var_216_3)

					arg_213_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1039ui_story.fillRatio = var_216_4
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1039ui_story then
				local var_216_5 = 0.5

				arg_213_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1039ui_story.fillRatio = var_216_5
			end

			local var_216_6 = 0
			local var_216_7 = 0.6

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_8 = arg_213_1:GetWordFromCfg(103903053)
				local var_216_9 = arg_213_1:FormatText(var_216_8.content)

				arg_213_1.text_.text = var_216_9

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_10 = 24
				local var_216_11 = utf8.len(var_216_9)
				local var_216_12 = var_216_10 <= 0 and var_216_7 or var_216_7 * (var_216_11 / var_216_10)

				if var_216_12 > 0 and var_216_7 < var_216_12 then
					arg_213_1.talkMaxDuration = var_216_12

					if var_216_12 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_12 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_9
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_13 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_13 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_13

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_13 and arg_213_1.time_ < var_216_6 + var_216_13 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play103903054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 103903054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play103903055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 1

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				local var_220_2 = "play"
				local var_220_3 = "effect"

				arg_217_1:AudioAction(var_220_2, var_220_3, "se_story_side_1039", "se_story_1039_run", "")
			end

			local var_220_4 = 0
			local var_220_5 = 0.7

			if var_220_4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_6 = arg_217_1:GetWordFromCfg(103903054)
				local var_220_7 = arg_217_1:FormatText(var_220_6.content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_8 = 28
				local var_220_9 = utf8.len(var_220_7)
				local var_220_10 = var_220_8 <= 0 and var_220_5 or var_220_5 * (var_220_9 / var_220_8)

				if var_220_10 > 0 and var_220_5 < var_220_10 then
					arg_217_1.talkMaxDuration = var_220_10

					if var_220_10 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_11 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_11 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_11

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_11 and arg_217_1.time_ < var_220_4 + var_220_11 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play103903055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 103903055
		arg_221_1.duration_ = 3.7

		local var_221_0 = {
			ja = 3.7,
			ko = 3.666,
			zh = 3.666,
			en = 2.033
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
				arg_221_0:Play103903056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1027ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1027ui_story == nil then
				arg_221_1.var_.characterEffect1027ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.1

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1027ui_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1027ui_story then
				arg_221_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_224_4 = arg_221_1.actors_["1039ui_story"].transform
			local var_224_5 = 0

			if var_224_5 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.var_.moveOldPos1039ui_story = var_224_4.localPosition
			end

			local var_224_6 = 0.001

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_6 then
				local var_224_7 = (arg_221_1.time_ - var_224_5) / var_224_6
				local var_224_8 = Vector3.New(10, -1.06, -5.3)

				var_224_4.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1039ui_story, var_224_8, var_224_7)

				local var_224_9 = manager.ui.mainCamera.transform.position - var_224_4.position

				var_224_4.forward = Vector3.New(var_224_9.x, var_224_9.y, var_224_9.z)

				local var_224_10 = var_224_4.localEulerAngles

				var_224_10.z = 0
				var_224_10.x = 0
				var_224_4.localEulerAngles = var_224_10
			end

			if arg_221_1.time_ >= var_224_5 + var_224_6 and arg_221_1.time_ < var_224_5 + var_224_6 + arg_224_0 then
				var_224_4.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_224_11 = manager.ui.mainCamera.transform.position - var_224_4.position

				var_224_4.forward = Vector3.New(var_224_11.x, var_224_11.y, var_224_11.z)

				local var_224_12 = var_224_4.localEulerAngles

				var_224_12.z = 0
				var_224_12.x = 0
				var_224_4.localEulerAngles = var_224_12
			end

			local var_224_13 = arg_221_1.actors_["1027ui_story"].transform
			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1.var_.moveOldPos1027ui_story = var_224_13.localPosition
			end

			local var_224_15 = 0.001

			if var_224_14 <= arg_221_1.time_ and arg_221_1.time_ < var_224_14 + var_224_15 then
				local var_224_16 = (arg_221_1.time_ - var_224_14) / var_224_15
				local var_224_17 = Vector3.New(0, -0.922, -5.1)

				var_224_13.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1027ui_story, var_224_17, var_224_16)

				local var_224_18 = manager.ui.mainCamera.transform.position - var_224_13.position

				var_224_13.forward = Vector3.New(var_224_18.x, var_224_18.y, var_224_18.z)

				local var_224_19 = var_224_13.localEulerAngles

				var_224_19.z = 0
				var_224_19.x = 0
				var_224_13.localEulerAngles = var_224_19
			end

			if arg_221_1.time_ >= var_224_14 + var_224_15 and arg_221_1.time_ < var_224_14 + var_224_15 + arg_224_0 then
				var_224_13.localPosition = Vector3.New(0, -0.922, -5.1)

				local var_224_20 = manager.ui.mainCamera.transform.position - var_224_13.position

				var_224_13.forward = Vector3.New(var_224_20.x, var_224_20.y, var_224_20.z)

				local var_224_21 = var_224_13.localEulerAngles

				var_224_21.z = 0
				var_224_21.x = 0
				var_224_13.localEulerAngles = var_224_21
			end

			local var_224_22 = 0

			if var_224_22 < arg_221_1.time_ and arg_221_1.time_ <= var_224_22 + arg_224_0 then
				arg_221_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_224_23 = 0

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 then
				arg_221_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_224_24 = 0
			local var_224_25 = 0.175

			if var_224_24 < arg_221_1.time_ and arg_221_1.time_ <= var_224_24 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_26 = arg_221_1:FormatText(StoryNameCfg[56].name)

				arg_221_1.leftNameTxt_.text = var_224_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_27 = arg_221_1:GetWordFromCfg(103903055)
				local var_224_28 = arg_221_1:FormatText(var_224_27.content)

				arg_221_1.text_.text = var_224_28

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_29 = 7
				local var_224_30 = utf8.len(var_224_28)
				local var_224_31 = var_224_29 <= 0 and var_224_25 or var_224_25 * (var_224_30 / var_224_29)

				if var_224_31 > 0 and var_224_25 < var_224_31 then
					arg_221_1.talkMaxDuration = var_224_31

					if var_224_31 + var_224_24 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_31 + var_224_24
					end
				end

				arg_221_1.text_.text = var_224_28
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb") ~= 0 then
					local var_224_32 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb") / 1000

					if var_224_32 + var_224_24 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_32 + var_224_24
					end

					if var_224_27.prefab_name ~= "" and arg_221_1.actors_[var_224_27.prefab_name] ~= nil then
						local var_224_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_27.prefab_name].transform, "story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb")

						arg_221_1:RecordAudio("103903055", var_224_33)
						arg_221_1:RecordAudio("103903055", var_224_33)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_34 = math.max(var_224_25, arg_221_1.talkMaxDuration)

			if var_224_24 <= arg_221_1.time_ and arg_221_1.time_ < var_224_24 + var_224_34 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_24) / var_224_34

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_24 + var_224_34 and arg_221_1.time_ < var_224_24 + var_224_34 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play103903056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 103903056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play103903057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.325

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(103903056)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 13
				local var_228_5 = utf8.len(var_228_3)
				local var_228_6 = var_228_4 <= 0 and var_228_1 or var_228_1 * (var_228_5 / var_228_4)

				if var_228_6 > 0 and var_228_1 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_7 and arg_225_1.time_ < var_228_0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play103903057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 103903057
		arg_229_1.duration_ = 7.63

		local var_229_0 = {
			ja = 7.633,
			ko = 4.366,
			zh = 4.366,
			en = 3.166
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
				arg_229_0:Play103903058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action426")
			end

			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_232_2 = 0
			local var_232_3 = 0.3

			if var_232_2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_4 = arg_229_1:FormatText(StoryNameCfg[56].name)

				arg_229_1.leftNameTxt_.text = var_232_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_5 = arg_229_1:GetWordFromCfg(103903057)
				local var_232_6 = arg_229_1:FormatText(var_232_5.content)

				arg_229_1.text_.text = var_232_6

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 12
				local var_232_8 = utf8.len(var_232_6)
				local var_232_9 = var_232_7 <= 0 and var_232_3 or var_232_3 * (var_232_8 / var_232_7)

				if var_232_9 > 0 and var_232_3 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_6
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb") / 1000

					if var_232_10 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_2
					end

					if var_232_5.prefab_name ~= "" and arg_229_1.actors_[var_232_5.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_5.prefab_name].transform, "story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb")

						arg_229_1:RecordAudio("103903057", var_232_11)
						arg_229_1:RecordAudio("103903057", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_12 and arg_229_1.time_ < var_232_2 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play103903058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 103903058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play103903059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1027ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1027ui_story == nil then
				arg_233_1.var_.characterEffect1027ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.1

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1027ui_story and not isNil(var_236_0) then
					local var_236_4 = Mathf.Lerp(0, 0.5, var_236_3)

					arg_233_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1027ui_story.fillRatio = var_236_4
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1027ui_story then
				local var_236_5 = 0.5

				arg_233_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1027ui_story.fillRatio = var_236_5
			end

			local var_236_6 = 0
			local var_236_7 = 0.575

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_8 = arg_233_1:GetWordFromCfg(103903058)
				local var_236_9 = arg_233_1:FormatText(var_236_8.content)

				arg_233_1.text_.text = var_236_9

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_10 = 23
				local var_236_11 = utf8.len(var_236_9)
				local var_236_12 = var_236_10 <= 0 and var_236_7 or var_236_7 * (var_236_11 / var_236_10)

				if var_236_12 > 0 and var_236_7 < var_236_12 then
					arg_233_1.talkMaxDuration = var_236_12

					if var_236_12 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_12 + var_236_6
					end
				end

				arg_233_1.text_.text = var_236_9
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_13 = math.max(var_236_7, arg_233_1.talkMaxDuration)

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_13 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_6) / var_236_13

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_6 + var_236_13 and arg_233_1.time_ < var_236_6 + var_236_13 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play103903059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 103903059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play103903060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.7

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

				local var_240_2 = arg_237_1:GetWordFromCfg(103903059)
				local var_240_3 = arg_237_1:FormatText(var_240_2.content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 28
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
	Play103903060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 103903060
		arg_241_1.duration_ = 5.7

		local var_241_0 = {
			ja = 5.7,
			ko = 5.233,
			zh = 5.233,
			en = 4.266
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
				arg_241_0:Play103903061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 1

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				local var_244_2 = "play"
				local var_244_3 = "music"

				arg_241_1:AudioAction(var_244_2, var_244_3, "ui_battle", "ui_battle_pausebgm", "")

				local var_244_4 = ""
				local var_244_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_pausebgm")

				if var_244_5 ~= "" then
					if arg_241_1.bgmTxt_.text ~= var_244_5 and arg_241_1.bgmTxt_.text ~= "" then
						if arg_241_1.bgmTxt2_.text ~= "" then
							arg_241_1.bgmTxt_.text = arg_241_1.bgmTxt2_.text
						end

						arg_241_1.bgmTxt2_.text = var_244_5

						arg_241_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_241_1.bgmTxt_.text = var_244_5
						arg_241_1.bgmTxt2_.text = var_244_5
					end

					if arg_241_1.bgmTimer then
						arg_241_1.bgmTimer:Stop()

						arg_241_1.bgmTimer = nil
					end

					if arg_241_1.settingData.show_music_name == 1 then
						arg_241_1.musicController:SetSelectedState("show")
						arg_241_1.musicAnimator_:Play("open", 0, 0)

						if arg_241_1.settingData.music_time ~= 0 then
							arg_241_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_241_1.settingData.music_time), function()
								if arg_241_1 == nil or isNil(arg_241_1.bgmTxt_) then
									return
								end

								arg_241_1.musicController:SetSelectedState("hide")
								arg_241_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_244_6 = arg_241_1.actors_["1027ui_story"]
			local var_244_7 = 0

			if var_244_7 < arg_241_1.time_ and arg_241_1.time_ <= var_244_7 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect1027ui_story == nil then
				arg_241_1.var_.characterEffect1027ui_story = var_244_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_8 = 0.1

			if var_244_7 <= arg_241_1.time_ and arg_241_1.time_ < var_244_7 + var_244_8 and not isNil(var_244_6) then
				local var_244_9 = (arg_241_1.time_ - var_244_7) / var_244_8

				if arg_241_1.var_.characterEffect1027ui_story and not isNil(var_244_6) then
					arg_241_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_7 + var_244_8 and arg_241_1.time_ < var_244_7 + var_244_8 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect1027ui_story then
				arg_241_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action463")
			end

			local var_244_11 = 0

			if var_244_11 < arg_241_1.time_ and arg_241_1.time_ <= var_244_11 + arg_244_0 then
				arg_241_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_244_12 = 0
			local var_244_13 = 0.175

			if var_244_12 < arg_241_1.time_ and arg_241_1.time_ <= var_244_12 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_14 = arg_241_1:FormatText(StoryNameCfg[56].name)

				arg_241_1.leftNameTxt_.text = var_244_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_15 = arg_241_1:GetWordFromCfg(103903060)
				local var_244_16 = arg_241_1:FormatText(var_244_15.content)

				arg_241_1.text_.text = var_244_16

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_17 = 7
				local var_244_18 = utf8.len(var_244_16)
				local var_244_19 = var_244_17 <= 0 and var_244_13 or var_244_13 * (var_244_18 / var_244_17)

				if var_244_19 > 0 and var_244_13 < var_244_19 then
					arg_241_1.talkMaxDuration = var_244_19

					if var_244_19 + var_244_12 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_19 + var_244_12
					end
				end

				arg_241_1.text_.text = var_244_16
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb") ~= 0 then
					local var_244_20 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb") / 1000

					if var_244_20 + var_244_12 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_20 + var_244_12
					end

					if var_244_15.prefab_name ~= "" and arg_241_1.actors_[var_244_15.prefab_name] ~= nil then
						local var_244_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_15.prefab_name].transform, "story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb")

						arg_241_1:RecordAudio("103903060", var_244_21)
						arg_241_1:RecordAudio("103903060", var_244_21)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_22 = math.max(var_244_13, arg_241_1.talkMaxDuration)

			if var_244_12 <= arg_241_1.time_ and arg_241_1.time_ < var_244_12 + var_244_22 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_12) / var_244_22

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_12 + var_244_22 and arg_241_1.time_ < var_244_12 + var_244_22 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play103903061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 103903061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play103903062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.425

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_2 = arg_246_1:GetWordFromCfg(103903061)
				local var_249_3 = arg_246_1:FormatText(var_249_2.content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 17
				local var_249_5 = utf8.len(var_249_3)
				local var_249_6 = var_249_4 <= 0 and var_249_1 or var_249_1 * (var_249_5 / var_249_4)

				if var_249_6 > 0 and var_249_1 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_7 and arg_246_1.time_ < var_249_0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play103903062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 103903062
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play103903063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1027ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1027ui_story == nil then
				arg_250_1.var_.characterEffect1027ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.1

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect1027ui_story and not isNil(var_253_0) then
					local var_253_4 = Mathf.Lerp(0, 0.5, var_253_3)

					arg_250_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1027ui_story.fillRatio = var_253_4
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1027ui_story then
				local var_253_5 = 0.5

				arg_250_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1027ui_story.fillRatio = var_253_5
			end

			local var_253_6 = 0
			local var_253_7 = 0.225

			if var_253_6 < arg_250_1.time_ and arg_250_1.time_ <= var_253_6 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_8 = arg_250_1:FormatText(StoryNameCfg[7].name)

				arg_250_1.leftNameTxt_.text = var_253_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_9 = arg_250_1:GetWordFromCfg(103903062)
				local var_253_10 = arg_250_1:FormatText(var_253_9.content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 9
				local var_253_12 = utf8.len(var_253_10)
				local var_253_13 = var_253_11 <= 0 and var_253_7 or var_253_7 * (var_253_12 / var_253_11)

				if var_253_13 > 0 and var_253_7 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13

					if var_253_13 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_6
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_14 = math.max(var_253_7, arg_250_1.talkMaxDuration)

			if var_253_6 <= arg_250_1.time_ and arg_250_1.time_ < var_253_6 + var_253_14 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_6) / var_253_14

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_6 + var_253_14 and arg_250_1.time_ < var_253_6 + var_253_14 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play103903063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 103903063
		arg_254_1.duration_ = 8

		local var_254_0 = {
			ja = 1.8,
			ko = 3.6,
			zh = 3.6,
			en = 8
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play103903064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1027ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1027ui_story == nil then
				arg_254_1.var_.characterEffect1027ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.1

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1027ui_story and not isNil(var_257_0) then
					arg_254_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1027ui_story then
				arg_254_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_257_4 = 0

			if var_257_4 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_257_5 = 0
			local var_257_6 = 0.1

			if var_257_5 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_7 = arg_254_1:FormatText(StoryNameCfg[56].name)

				arg_254_1.leftNameTxt_.text = var_257_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_8 = arg_254_1:GetWordFromCfg(103903063)
				local var_257_9 = arg_254_1:FormatText(var_257_8.content)

				arg_254_1.text_.text = var_257_9

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_10 = 4
				local var_257_11 = utf8.len(var_257_9)
				local var_257_12 = var_257_10 <= 0 and var_257_6 or var_257_6 * (var_257_11 / var_257_10)

				if var_257_12 > 0 and var_257_6 < var_257_12 then
					arg_254_1.talkMaxDuration = var_257_12

					if var_257_12 + var_257_5 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_12 + var_257_5
					end
				end

				arg_254_1.text_.text = var_257_9
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb") ~= 0 then
					local var_257_13 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb") / 1000

					if var_257_13 + var_257_5 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_13 + var_257_5
					end

					if var_257_8.prefab_name ~= "" and arg_254_1.actors_[var_257_8.prefab_name] ~= nil then
						local var_257_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_8.prefab_name].transform, "story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb")

						arg_254_1:RecordAudio("103903063", var_257_14)
						arg_254_1:RecordAudio("103903063", var_257_14)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_15 = math.max(var_257_6, arg_254_1.talkMaxDuration)

			if var_257_5 <= arg_254_1.time_ and arg_254_1.time_ < var_257_5 + var_257_15 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_5) / var_257_15

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_5 + var_257_15 and arg_254_1.time_ < var_257_5 + var_257_15 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play103903064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 103903064
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play103903065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1027ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1027ui_story == nil then
				arg_258_1.var_.characterEffect1027ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.1

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect1027ui_story and not isNil(var_261_0) then
					local var_261_4 = Mathf.Lerp(0, 0.5, var_261_3)

					arg_258_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1027ui_story.fillRatio = var_261_4
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1027ui_story then
				local var_261_5 = 0.5

				arg_258_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1027ui_story.fillRatio = var_261_5
			end

			local var_261_6 = 0
			local var_261_7 = 0.25

			if var_261_6 < arg_258_1.time_ and arg_258_1.time_ <= var_261_6 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_8 = arg_258_1:FormatText(StoryNameCfg[7].name)

				arg_258_1.leftNameTxt_.text = var_261_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_9 = arg_258_1:GetWordFromCfg(103903064)
				local var_261_10 = arg_258_1:FormatText(var_261_9.content)

				arg_258_1.text_.text = var_261_10

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_11 = 10
				local var_261_12 = utf8.len(var_261_10)
				local var_261_13 = var_261_11 <= 0 and var_261_7 or var_261_7 * (var_261_12 / var_261_11)

				if var_261_13 > 0 and var_261_7 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_6 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_6
					end
				end

				arg_258_1.text_.text = var_261_10
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_14 = math.max(var_261_7, arg_258_1.talkMaxDuration)

			if var_261_6 <= arg_258_1.time_ and arg_258_1.time_ < var_261_6 + var_261_14 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_6) / var_261_14

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_6 + var_261_14 and arg_258_1.time_ < var_261_6 + var_261_14 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play103903065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 103903065
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play103903066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 0.975

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_2 = arg_262_1:GetWordFromCfg(103903065)
				local var_265_3 = arg_262_1:FormatText(var_265_2.content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 39
				local var_265_5 = utf8.len(var_265_3)
				local var_265_6 = var_265_4 <= 0 and var_265_1 or var_265_1 * (var_265_5 / var_265_4)

				if var_265_6 > 0 and var_265_1 < var_265_6 then
					arg_262_1.talkMaxDuration = var_265_6

					if var_265_6 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_7 and arg_262_1.time_ < var_265_0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play103903066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 103903066
		arg_266_1.duration_ = 3.1

		local var_266_0 = {
			ja = 2.666,
			ko = 2.533,
			zh = 2.533,
			en = 3.1
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play103903067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1039ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1039ui_story == nil then
				arg_266_1.var_.characterEffect1039ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.1

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect1039ui_story and not isNil(var_269_0) then
					arg_266_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1039ui_story then
				arg_266_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_269_4 = arg_266_1.actors_["1027ui_story"].transform
			local var_269_5 = 0

			if var_269_5 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1.var_.moveOldPos1027ui_story = var_269_4.localPosition
			end

			local var_269_6 = 0.001

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_6 then
				local var_269_7 = (arg_266_1.time_ - var_269_5) / var_269_6
				local var_269_8 = Vector3.New(10, -0.922, -5.1)

				var_269_4.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1027ui_story, var_269_8, var_269_7)

				local var_269_9 = manager.ui.mainCamera.transform.position - var_269_4.position

				var_269_4.forward = Vector3.New(var_269_9.x, var_269_9.y, var_269_9.z)

				local var_269_10 = var_269_4.localEulerAngles

				var_269_10.z = 0
				var_269_10.x = 0
				var_269_4.localEulerAngles = var_269_10
			end

			if arg_266_1.time_ >= var_269_5 + var_269_6 and arg_266_1.time_ < var_269_5 + var_269_6 + arg_269_0 then
				var_269_4.localPosition = Vector3.New(10, -0.922, -5.1)

				local var_269_11 = manager.ui.mainCamera.transform.position - var_269_4.position

				var_269_4.forward = Vector3.New(var_269_11.x, var_269_11.y, var_269_11.z)

				local var_269_12 = var_269_4.localEulerAngles

				var_269_12.z = 0
				var_269_12.x = 0
				var_269_4.localEulerAngles = var_269_12
			end

			local var_269_13 = arg_266_1.actors_["1039ui_story"].transform
			local var_269_14 = 0

			if var_269_14 < arg_266_1.time_ and arg_266_1.time_ <= var_269_14 + arg_269_0 then
				arg_266_1.var_.moveOldPos1039ui_story = var_269_13.localPosition
			end

			local var_269_15 = 0.001

			if var_269_14 <= arg_266_1.time_ and arg_266_1.time_ < var_269_14 + var_269_15 then
				local var_269_16 = (arg_266_1.time_ - var_269_14) / var_269_15
				local var_269_17 = Vector3.New(0, -1.06, -5.3)

				var_269_13.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1039ui_story, var_269_17, var_269_16)

				local var_269_18 = manager.ui.mainCamera.transform.position - var_269_13.position

				var_269_13.forward = Vector3.New(var_269_18.x, var_269_18.y, var_269_18.z)

				local var_269_19 = var_269_13.localEulerAngles

				var_269_19.z = 0
				var_269_19.x = 0
				var_269_13.localEulerAngles = var_269_19
			end

			if arg_266_1.time_ >= var_269_14 + var_269_15 and arg_266_1.time_ < var_269_14 + var_269_15 + arg_269_0 then
				var_269_13.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_269_20 = manager.ui.mainCamera.transform.position - var_269_13.position

				var_269_13.forward = Vector3.New(var_269_20.x, var_269_20.y, var_269_20.z)

				local var_269_21 = var_269_13.localEulerAngles

				var_269_21.z = 0
				var_269_21.x = 0
				var_269_13.localEulerAngles = var_269_21
			end

			local var_269_22 = 0

			if var_269_22 < arg_266_1.time_ and arg_266_1.time_ <= var_269_22 + arg_269_0 then
				arg_266_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			local var_269_23 = 0

			if var_269_23 < arg_266_1.time_ and arg_266_1.time_ <= var_269_23 + arg_269_0 then
				arg_266_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_269_24 = 0
			local var_269_25 = 0.2

			if var_269_24 < arg_266_1.time_ and arg_266_1.time_ <= var_269_24 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_26 = arg_266_1:FormatText(StoryNameCfg[9].name)

				arg_266_1.leftNameTxt_.text = var_269_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_27 = arg_266_1:GetWordFromCfg(103903066)
				local var_269_28 = arg_266_1:FormatText(var_269_27.content)

				arg_266_1.text_.text = var_269_28

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_29 = 8
				local var_269_30 = utf8.len(var_269_28)
				local var_269_31 = var_269_29 <= 0 and var_269_25 or var_269_25 * (var_269_30 / var_269_29)

				if var_269_31 > 0 and var_269_25 < var_269_31 then
					arg_266_1.talkMaxDuration = var_269_31

					if var_269_31 + var_269_24 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_31 + var_269_24
					end
				end

				arg_266_1.text_.text = var_269_28
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb") ~= 0 then
					local var_269_32 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb") / 1000

					if var_269_32 + var_269_24 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_32 + var_269_24
					end

					if var_269_27.prefab_name ~= "" and arg_266_1.actors_[var_269_27.prefab_name] ~= nil then
						local var_269_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_27.prefab_name].transform, "story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb")

						arg_266_1:RecordAudio("103903066", var_269_33)
						arg_266_1:RecordAudio("103903066", var_269_33)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_34 = math.max(var_269_25, arg_266_1.talkMaxDuration)

			if var_269_24 <= arg_266_1.time_ and arg_266_1.time_ < var_269_24 + var_269_34 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_24) / var_269_34

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_24 + var_269_34 and arg_266_1.time_ < var_269_24 + var_269_34 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play103903067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 103903067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play103903068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.35

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_2 = arg_270_1:GetWordFromCfg(103903067)
				local var_273_3 = arg_270_1:FormatText(var_273_2.content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 14
				local var_273_5 = utf8.len(var_273_3)
				local var_273_6 = var_273_4 <= 0 and var_273_1 or var_273_1 * (var_273_5 / var_273_4)

				if var_273_6 > 0 and var_273_1 < var_273_6 then
					arg_270_1.talkMaxDuration = var_273_6

					if var_273_6 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_6 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_7 and arg_270_1.time_ < var_273_0 + var_273_7 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play103903068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 103903068
		arg_274_1.duration_ = 6.2

		local var_274_0 = {
			ja = 4.933,
			ko = 6.2,
			zh = 6.2,
			en = 5.966
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play103903069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_277_1 = 0
			local var_277_2 = 0.775

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_3 = arg_274_1:FormatText(StoryNameCfg[9].name)

				arg_274_1.leftNameTxt_.text = var_277_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:GetWordFromCfg(103903068)
				local var_277_5 = arg_274_1:FormatText(var_277_4.content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_6 = 31
				local var_277_7 = utf8.len(var_277_5)
				local var_277_8 = var_277_6 <= 0 and var_277_2 or var_277_2 * (var_277_7 / var_277_6)

				if var_277_8 > 0 and var_277_2 < var_277_8 then
					arg_274_1.talkMaxDuration = var_277_8

					if var_277_8 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_1
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb") ~= 0 then
					local var_277_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb") / 1000

					if var_277_9 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_9 + var_277_1
					end

					if var_277_4.prefab_name ~= "" and arg_274_1.actors_[var_277_4.prefab_name] ~= nil then
						local var_277_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_4.prefab_name].transform, "story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb")

						arg_274_1:RecordAudio("103903068", var_277_10)
						arg_274_1:RecordAudio("103903068", var_277_10)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_11 = math.max(var_277_2, arg_274_1.talkMaxDuration)

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_11 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_1) / var_277_11

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_1 + var_277_11 and arg_274_1.time_ < var_277_1 + var_277_11 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play103903069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 103903069
		arg_278_1.duration_ = 6.27

		local var_278_0 = {
			ja = 6.266,
			ko = 4.7,
			zh = 4.7,
			en = 5.766
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play103903070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1027ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1027ui_story == nil then
				arg_278_1.var_.characterEffect1027ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.1

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect1027ui_story and not isNil(var_281_0) then
					arg_278_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1027ui_story then
				arg_278_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_281_4 = arg_278_1.actors_["1039ui_story"]
			local var_281_5 = 0

			if var_281_5 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 and not isNil(var_281_4) and arg_278_1.var_.characterEffect1039ui_story == nil then
				arg_278_1.var_.characterEffect1039ui_story = var_281_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_6 = 0.1

			if var_281_5 <= arg_278_1.time_ and arg_278_1.time_ < var_281_5 + var_281_6 and not isNil(var_281_4) then
				local var_281_7 = (arg_278_1.time_ - var_281_5) / var_281_6

				if arg_278_1.var_.characterEffect1039ui_story and not isNil(var_281_4) then
					local var_281_8 = Mathf.Lerp(0, 0.5, var_281_7)

					arg_278_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1039ui_story.fillRatio = var_281_8
				end
			end

			if arg_278_1.time_ >= var_281_5 + var_281_6 and arg_278_1.time_ < var_281_5 + var_281_6 + arg_281_0 and not isNil(var_281_4) and arg_278_1.var_.characterEffect1039ui_story then
				local var_281_9 = 0.5

				arg_278_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1039ui_story.fillRatio = var_281_9
			end

			local var_281_10 = arg_278_1.actors_["1039ui_story"].transform
			local var_281_11 = 0

			if var_281_11 < arg_278_1.time_ and arg_278_1.time_ <= var_281_11 + arg_281_0 then
				arg_278_1.var_.moveOldPos1039ui_story = var_281_10.localPosition
			end

			local var_281_12 = 0.001

			if var_281_11 <= arg_278_1.time_ and arg_278_1.time_ < var_281_11 + var_281_12 then
				local var_281_13 = (arg_278_1.time_ - var_281_11) / var_281_12
				local var_281_14 = Vector3.New(0, -1.06, -5.3)

				var_281_10.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1039ui_story, var_281_14, var_281_13)

				local var_281_15 = manager.ui.mainCamera.transform.position - var_281_10.position

				var_281_10.forward = Vector3.New(var_281_15.x, var_281_15.y, var_281_15.z)

				local var_281_16 = var_281_10.localEulerAngles

				var_281_16.z = 0
				var_281_16.x = 0
				var_281_10.localEulerAngles = var_281_16
			end

			if arg_278_1.time_ >= var_281_11 + var_281_12 and arg_278_1.time_ < var_281_11 + var_281_12 + arg_281_0 then
				var_281_10.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_281_17 = manager.ui.mainCamera.transform.position - var_281_10.position

				var_281_10.forward = Vector3.New(var_281_17.x, var_281_17.y, var_281_17.z)

				local var_281_18 = var_281_10.localEulerAngles

				var_281_18.z = 0
				var_281_18.x = 0
				var_281_10.localEulerAngles = var_281_18
			end

			local var_281_19 = arg_278_1.actors_["1039ui_story"].transform
			local var_281_20 = 0.033

			if var_281_20 < arg_278_1.time_ and arg_278_1.time_ <= var_281_20 + arg_281_0 then
				arg_278_1.var_.moveOldPos1039ui_story = var_281_19.localPosition
			end

			local var_281_21 = 0.5

			if var_281_20 <= arg_278_1.time_ and arg_278_1.time_ < var_281_20 + var_281_21 then
				local var_281_22 = (arg_278_1.time_ - var_281_20) / var_281_21
				local var_281_23 = Vector3.New(-0.85, -1.06, -5.3)

				var_281_19.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1039ui_story, var_281_23, var_281_22)

				local var_281_24 = manager.ui.mainCamera.transform.position - var_281_19.position

				var_281_19.forward = Vector3.New(var_281_24.x, var_281_24.y, var_281_24.z)

				local var_281_25 = var_281_19.localEulerAngles

				var_281_25.z = 0
				var_281_25.x = 0
				var_281_19.localEulerAngles = var_281_25
			end

			if arg_278_1.time_ >= var_281_20 + var_281_21 and arg_278_1.time_ < var_281_20 + var_281_21 + arg_281_0 then
				var_281_19.localPosition = Vector3.New(-0.85, -1.06, -5.3)

				local var_281_26 = manager.ui.mainCamera.transform.position - var_281_19.position

				var_281_19.forward = Vector3.New(var_281_26.x, var_281_26.y, var_281_26.z)

				local var_281_27 = var_281_19.localEulerAngles

				var_281_27.z = 0
				var_281_27.x = 0
				var_281_19.localEulerAngles = var_281_27
			end

			local var_281_28 = arg_278_1.actors_["1027ui_story"].transform
			local var_281_29 = 0

			if var_281_29 < arg_278_1.time_ and arg_278_1.time_ <= var_281_29 + arg_281_0 then
				arg_278_1.var_.moveOldPos1027ui_story = var_281_28.localPosition
			end

			local var_281_30 = 0.001

			if var_281_29 <= arg_278_1.time_ and arg_278_1.time_ < var_281_29 + var_281_30 then
				local var_281_31 = (arg_278_1.time_ - var_281_29) / var_281_30
				local var_281_32 = Vector3.New(0.92, -0.922, -5.1)

				var_281_28.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1027ui_story, var_281_32, var_281_31)

				local var_281_33 = manager.ui.mainCamera.transform.position - var_281_28.position

				var_281_28.forward = Vector3.New(var_281_33.x, var_281_33.y, var_281_33.z)

				local var_281_34 = var_281_28.localEulerAngles

				var_281_34.z = 0
				var_281_34.x = 0
				var_281_28.localEulerAngles = var_281_34
			end

			if arg_278_1.time_ >= var_281_29 + var_281_30 and arg_278_1.time_ < var_281_29 + var_281_30 + arg_281_0 then
				var_281_28.localPosition = Vector3.New(0.92, -0.922, -5.1)

				local var_281_35 = manager.ui.mainCamera.transform.position - var_281_28.position

				var_281_28.forward = Vector3.New(var_281_35.x, var_281_35.y, var_281_35.z)

				local var_281_36 = var_281_28.localEulerAngles

				var_281_36.z = 0
				var_281_36.x = 0
				var_281_28.localEulerAngles = var_281_36
			end

			local var_281_37 = 0

			if var_281_37 < arg_278_1.time_ and arg_278_1.time_ <= var_281_37 + arg_281_0 then
				arg_278_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			local var_281_38 = 0

			if var_281_38 < arg_278_1.time_ and arg_278_1.time_ <= var_281_38 + arg_281_0 then
				arg_278_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_281_39 = 0
			local var_281_40 = 0.25

			if var_281_39 < arg_278_1.time_ and arg_278_1.time_ <= var_281_39 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_41 = arg_278_1:FormatText(StoryNameCfg[56].name)

				arg_278_1.leftNameTxt_.text = var_281_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_42 = arg_278_1:GetWordFromCfg(103903069)
				local var_281_43 = arg_278_1:FormatText(var_281_42.content)

				arg_278_1.text_.text = var_281_43

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_44 = 10
				local var_281_45 = utf8.len(var_281_43)
				local var_281_46 = var_281_44 <= 0 and var_281_40 or var_281_40 * (var_281_45 / var_281_44)

				if var_281_46 > 0 and var_281_40 < var_281_46 then
					arg_278_1.talkMaxDuration = var_281_46

					if var_281_46 + var_281_39 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_46 + var_281_39
					end
				end

				arg_278_1.text_.text = var_281_43
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb") ~= 0 then
					local var_281_47 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb") / 1000

					if var_281_47 + var_281_39 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_47 + var_281_39
					end

					if var_281_42.prefab_name ~= "" and arg_278_1.actors_[var_281_42.prefab_name] ~= nil then
						local var_281_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_42.prefab_name].transform, "story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb")

						arg_278_1:RecordAudio("103903069", var_281_48)
						arg_278_1:RecordAudio("103903069", var_281_48)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_49 = math.max(var_281_40, arg_278_1.talkMaxDuration)

			if var_281_39 <= arg_278_1.time_ and arg_278_1.time_ < var_281_39 + var_281_49 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_39) / var_281_49

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_39 + var_281_49 and arg_278_1.time_ < var_281_39 + var_281_49 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play103903070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 103903070
		arg_282_1.duration_ = 7.9

		local var_282_0 = {
			ja = 6.066,
			ko = 7.9,
			zh = 7.9,
			en = 4.9
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play103903071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1039ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1039ui_story == nil then
				arg_282_1.var_.characterEffect1039ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.1

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect1039ui_story and not isNil(var_285_0) then
					arg_282_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1039ui_story then
				arg_282_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_285_4 = arg_282_1.actors_["1027ui_story"]
			local var_285_5 = 0

			if var_285_5 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 and not isNil(var_285_4) and arg_282_1.var_.characterEffect1027ui_story == nil then
				arg_282_1.var_.characterEffect1027ui_story = var_285_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_6 = 0.1

			if var_285_5 <= arg_282_1.time_ and arg_282_1.time_ < var_285_5 + var_285_6 and not isNil(var_285_4) then
				local var_285_7 = (arg_282_1.time_ - var_285_5) / var_285_6

				if arg_282_1.var_.characterEffect1027ui_story and not isNil(var_285_4) then
					local var_285_8 = Mathf.Lerp(0, 0.5, var_285_7)

					arg_282_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1027ui_story.fillRatio = var_285_8
				end
			end

			if arg_282_1.time_ >= var_285_5 + var_285_6 and arg_282_1.time_ < var_285_5 + var_285_6 + arg_285_0 and not isNil(var_285_4) and arg_282_1.var_.characterEffect1027ui_story then
				local var_285_9 = 0.5

				arg_282_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1027ui_story.fillRatio = var_285_9
			end

			local var_285_10 = 0

			if var_285_10 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 then
				arg_282_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			local var_285_11 = 0

			if var_285_11 < arg_282_1.time_ and arg_282_1.time_ <= var_285_11 + arg_285_0 then
				arg_282_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_285_12 = 0
			local var_285_13 = 0.75

			if var_285_12 < arg_282_1.time_ and arg_282_1.time_ <= var_285_12 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_14 = arg_282_1:FormatText(StoryNameCfg[9].name)

				arg_282_1.leftNameTxt_.text = var_285_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_15 = arg_282_1:GetWordFromCfg(103903070)
				local var_285_16 = arg_282_1:FormatText(var_285_15.content)

				arg_282_1.text_.text = var_285_16

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_17 = 30
				local var_285_18 = utf8.len(var_285_16)
				local var_285_19 = var_285_17 <= 0 and var_285_13 or var_285_13 * (var_285_18 / var_285_17)

				if var_285_19 > 0 and var_285_13 < var_285_19 then
					arg_282_1.talkMaxDuration = var_285_19

					if var_285_19 + var_285_12 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_19 + var_285_12
					end
				end

				arg_282_1.text_.text = var_285_16
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb") ~= 0 then
					local var_285_20 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb") / 1000

					if var_285_20 + var_285_12 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_20 + var_285_12
					end

					if var_285_15.prefab_name ~= "" and arg_282_1.actors_[var_285_15.prefab_name] ~= nil then
						local var_285_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_15.prefab_name].transform, "story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb")

						arg_282_1:RecordAudio("103903070", var_285_21)
						arg_282_1:RecordAudio("103903070", var_285_21)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_22 = math.max(var_285_13, arg_282_1.talkMaxDuration)

			if var_285_12 <= arg_282_1.time_ and arg_282_1.time_ < var_285_12 + var_285_22 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_12) / var_285_22

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_12 + var_285_22 and arg_282_1.time_ < var_285_12 + var_285_22 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play103903071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 103903071
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play103903072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1039ui_story"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1039ui_story == nil then
				arg_286_1.var_.characterEffect1039ui_story = var_289_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.1

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.characterEffect1039ui_story and not isNil(var_289_0) then
					local var_289_4 = Mathf.Lerp(0, 0.5, var_289_3)

					arg_286_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1039ui_story.fillRatio = var_289_4
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1039ui_story then
				local var_289_5 = 0.5

				arg_286_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1039ui_story.fillRatio = var_289_5
			end

			local var_289_6 = 0
			local var_289_7 = 0.5

			if var_289_6 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_8 = arg_286_1:GetWordFromCfg(103903071)
				local var_289_9 = arg_286_1:FormatText(var_289_8.content)

				arg_286_1.text_.text = var_289_9

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_10 = 20
				local var_289_11 = utf8.len(var_289_9)
				local var_289_12 = var_289_10 <= 0 and var_289_7 or var_289_7 * (var_289_11 / var_289_10)

				if var_289_12 > 0 and var_289_7 < var_289_12 then
					arg_286_1.talkMaxDuration = var_289_12

					if var_289_12 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_12 + var_289_6
					end
				end

				arg_286_1.text_.text = var_289_9
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_13 = math.max(var_289_7, arg_286_1.talkMaxDuration)

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_13 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_6) / var_289_13

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_6 + var_289_13 and arg_286_1.time_ < var_289_6 + var_289_13 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play103903072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 103903072
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play103903073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.225

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_2 = arg_290_1:GetWordFromCfg(103903072)
				local var_293_3 = arg_290_1:FormatText(var_293_2.content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 9
				local var_293_5 = utf8.len(var_293_3)
				local var_293_6 = var_293_4 <= 0 and var_293_1 or var_293_1 * (var_293_5 / var_293_4)

				if var_293_6 > 0 and var_293_1 < var_293_6 then
					arg_290_1.talkMaxDuration = var_293_6

					if var_293_6 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_7 and arg_290_1.time_ < var_293_0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play103903073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 103903073
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play103903074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.bgs_.ST03.transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPosST03 = var_297_0.localPosition
			end

			local var_297_2 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2
				local var_297_4 = Vector3.New(0, -100, 10)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPosST03, var_297_4, var_297_3)
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_297_5 = "D04a"

			if arg_294_1.bgs_[var_297_5] == nil then
				local var_297_6 = Object.Instantiate(arg_294_1.paintGo_)

				var_297_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_297_5)
				var_297_6.name = var_297_5
				var_297_6.transform.parent = arg_294_1.stage_.transform
				var_297_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.bgs_[var_297_5] = var_297_6
			end

			local var_297_7 = 0

			if var_297_7 < arg_294_1.time_ and arg_294_1.time_ <= var_297_7 + arg_297_0 then
				local var_297_8 = manager.ui.mainCamera.transform.localPosition
				local var_297_9 = Vector3.New(0, 0, 10) + Vector3.New(var_297_8.x, var_297_8.y, 0)
				local var_297_10 = arg_294_1.bgs_.D04a

				var_297_10.transform.localPosition = var_297_9
				var_297_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_11 = var_297_10:GetComponent("SpriteRenderer")

				if var_297_11 and var_297_11.sprite then
					local var_297_12 = (var_297_10.transform.localPosition - var_297_8).z
					local var_297_13 = manager.ui.mainCameraCom_
					local var_297_14 = 2 * var_297_12 * Mathf.Tan(var_297_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_297_15 = var_297_14 * var_297_13.aspect
					local var_297_16 = var_297_11.sprite.bounds.size.x
					local var_297_17 = var_297_11.sprite.bounds.size.y
					local var_297_18 = var_297_15 / var_297_16
					local var_297_19 = var_297_14 / var_297_17
					local var_297_20 = var_297_19 < var_297_18 and var_297_18 or var_297_19

					var_297_10.transform.localScale = Vector3.New(var_297_20, var_297_20, 0)
				end

				for iter_297_0, iter_297_1 in pairs(arg_294_1.bgs_) do
					if iter_297_0 ~= "D04a" then
						iter_297_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_21 = arg_294_1.actors_["1039ui_story"].transform
			local var_297_22 = 0

			if var_297_22 < arg_294_1.time_ and arg_294_1.time_ <= var_297_22 + arg_297_0 then
				arg_294_1.var_.moveOldPos1039ui_story = var_297_21.localPosition
			end

			local var_297_23 = 0.001

			if var_297_22 <= arg_294_1.time_ and arg_294_1.time_ < var_297_22 + var_297_23 then
				local var_297_24 = (arg_294_1.time_ - var_297_22) / var_297_23
				local var_297_25 = Vector3.New(10, -1.06, -5.3)

				var_297_21.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1039ui_story, var_297_25, var_297_24)

				local var_297_26 = manager.ui.mainCamera.transform.position - var_297_21.position

				var_297_21.forward = Vector3.New(var_297_26.x, var_297_26.y, var_297_26.z)

				local var_297_27 = var_297_21.localEulerAngles

				var_297_27.z = 0
				var_297_27.x = 0
				var_297_21.localEulerAngles = var_297_27
			end

			if arg_294_1.time_ >= var_297_22 + var_297_23 and arg_294_1.time_ < var_297_22 + var_297_23 + arg_297_0 then
				var_297_21.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_297_28 = manager.ui.mainCamera.transform.position - var_297_21.position

				var_297_21.forward = Vector3.New(var_297_28.x, var_297_28.y, var_297_28.z)

				local var_297_29 = var_297_21.localEulerAngles

				var_297_29.z = 0
				var_297_29.x = 0
				var_297_21.localEulerAngles = var_297_29
			end

			local var_297_30 = arg_294_1.actors_["1027ui_story"].transform
			local var_297_31 = 0

			if var_297_31 < arg_294_1.time_ and arg_294_1.time_ <= var_297_31 + arg_297_0 then
				arg_294_1.var_.moveOldPos1027ui_story = var_297_30.localPosition
			end

			local var_297_32 = 0.001

			if var_297_31 <= arg_294_1.time_ and arg_294_1.time_ < var_297_31 + var_297_32 then
				local var_297_33 = (arg_294_1.time_ - var_297_31) / var_297_32
				local var_297_34 = Vector3.New(10, -0.922, -5.1)

				var_297_30.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1027ui_story, var_297_34, var_297_33)

				local var_297_35 = manager.ui.mainCamera.transform.position - var_297_30.position

				var_297_30.forward = Vector3.New(var_297_35.x, var_297_35.y, var_297_35.z)

				local var_297_36 = var_297_30.localEulerAngles

				var_297_36.z = 0
				var_297_36.x = 0
				var_297_30.localEulerAngles = var_297_36
			end

			if arg_294_1.time_ >= var_297_31 + var_297_32 and arg_294_1.time_ < var_297_31 + var_297_32 + arg_297_0 then
				var_297_30.localPosition = Vector3.New(10, -0.922, -5.1)

				local var_297_37 = manager.ui.mainCamera.transform.position - var_297_30.position

				var_297_30.forward = Vector3.New(var_297_37.x, var_297_37.y, var_297_37.z)

				local var_297_38 = var_297_30.localEulerAngles

				var_297_38.z = 0
				var_297_38.x = 0
				var_297_30.localEulerAngles = var_297_38
			end

			local var_297_39 = 0
			local var_297_40 = 0.825

			if var_297_39 < arg_294_1.time_ and arg_294_1.time_ <= var_297_39 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_41 = arg_294_1:GetWordFromCfg(103903073)
				local var_297_42 = arg_294_1:FormatText(var_297_41.content)

				arg_294_1.text_.text = var_297_42

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_43 = 33
				local var_297_44 = utf8.len(var_297_42)
				local var_297_45 = var_297_43 <= 0 and var_297_40 or var_297_40 * (var_297_44 / var_297_43)

				if var_297_45 > 0 and var_297_40 < var_297_45 then
					arg_294_1.talkMaxDuration = var_297_45

					if var_297_45 + var_297_39 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_45 + var_297_39
					end
				end

				arg_294_1.text_.text = var_297_42
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_46 = math.max(var_297_40, arg_294_1.talkMaxDuration)

			if var_297_39 <= arg_294_1.time_ and arg_294_1.time_ < var_297_39 + var_297_46 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_39) / var_297_46

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_39 + var_297_46 and arg_294_1.time_ < var_297_39 + var_297_46 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play103903074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 103903074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play103903075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.325

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_2 = arg_298_1:GetWordFromCfg(103903074)
				local var_301_3 = arg_298_1:FormatText(var_301_2.content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 13
				local var_301_5 = utf8.len(var_301_3)
				local var_301_6 = var_301_4 <= 0 and var_301_1 or var_301_1 * (var_301_5 / var_301_4)

				if var_301_6 > 0 and var_301_1 < var_301_6 then
					arg_298_1.talkMaxDuration = var_301_6

					if var_301_6 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_6 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_7 and arg_298_1.time_ < var_301_0 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play103903075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 103903075
		arg_302_1.duration_ = 6.33

		local var_302_0 = {
			ja = 6.233,
			ko = 4.9,
			zh = 4.9,
			en = 6.333
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play103903076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1027ui_story"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1027ui_story == nil then
				arg_302_1.var_.characterEffect1027ui_story = var_305_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.1

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.characterEffect1027ui_story and not isNil(var_305_0) then
					arg_302_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1027ui_story then
				arg_302_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_305_4 = arg_302_1.actors_["1027ui_story"].transform
			local var_305_5 = 0

			if var_305_5 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				arg_302_1.var_.moveOldPos1027ui_story = var_305_4.localPosition
			end

			local var_305_6 = 0.001

			if var_305_5 <= arg_302_1.time_ and arg_302_1.time_ < var_305_5 + var_305_6 then
				local var_305_7 = (arg_302_1.time_ - var_305_5) / var_305_6
				local var_305_8 = Vector3.New(0, -0.922, -5.1)

				var_305_4.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1027ui_story, var_305_8, var_305_7)

				local var_305_9 = manager.ui.mainCamera.transform.position - var_305_4.position

				var_305_4.forward = Vector3.New(var_305_9.x, var_305_9.y, var_305_9.z)

				local var_305_10 = var_305_4.localEulerAngles

				var_305_10.z = 0
				var_305_10.x = 0
				var_305_4.localEulerAngles = var_305_10
			end

			if arg_302_1.time_ >= var_305_5 + var_305_6 and arg_302_1.time_ < var_305_5 + var_305_6 + arg_305_0 then
				var_305_4.localPosition = Vector3.New(0, -0.922, -5.1)

				local var_305_11 = manager.ui.mainCamera.transform.position - var_305_4.position

				var_305_4.forward = Vector3.New(var_305_11.x, var_305_11.y, var_305_11.z)

				local var_305_12 = var_305_4.localEulerAngles

				var_305_12.z = 0
				var_305_12.x = 0
				var_305_4.localEulerAngles = var_305_12
			end

			local var_305_13 = 0

			if var_305_13 < arg_302_1.time_ and arg_302_1.time_ <= var_305_13 + arg_305_0 then
				arg_302_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_305_15 = 0
			local var_305_16 = 0.475

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_17 = arg_302_1:FormatText(StoryNameCfg[56].name)

				arg_302_1.leftNameTxt_.text = var_305_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_18 = arg_302_1:GetWordFromCfg(103903075)
				local var_305_19 = arg_302_1:FormatText(var_305_18.content)

				arg_302_1.text_.text = var_305_19

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_20 = 19
				local var_305_21 = utf8.len(var_305_19)
				local var_305_22 = var_305_20 <= 0 and var_305_16 or var_305_16 * (var_305_21 / var_305_20)

				if var_305_22 > 0 and var_305_16 < var_305_22 then
					arg_302_1.talkMaxDuration = var_305_22

					if var_305_22 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_22 + var_305_15
					end
				end

				arg_302_1.text_.text = var_305_19
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb") ~= 0 then
					local var_305_23 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb") / 1000

					if var_305_23 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_23 + var_305_15
					end

					if var_305_18.prefab_name ~= "" and arg_302_1.actors_[var_305_18.prefab_name] ~= nil then
						local var_305_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_18.prefab_name].transform, "story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb")

						arg_302_1:RecordAudio("103903075", var_305_24)
						arg_302_1:RecordAudio("103903075", var_305_24)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_25 = math.max(var_305_16, arg_302_1.talkMaxDuration)

			if var_305_15 <= arg_302_1.time_ and arg_302_1.time_ < var_305_15 + var_305_25 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_15) / var_305_25

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_15 + var_305_25 and arg_302_1.time_ < var_305_15 + var_305_25 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play103903076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 103903076
		arg_306_1.duration_ = 10.27

		local var_306_0 = {
			ja = 10.266,
			ko = 6.666,
			zh = 6.666,
			en = 7.5
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play103903077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_309_1 = 0
			local var_309_2 = 0.7

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_3 = arg_306_1:FormatText(StoryNameCfg[56].name)

				arg_306_1.leftNameTxt_.text = var_309_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_4 = arg_306_1:GetWordFromCfg(103903076)
				local var_309_5 = arg_306_1:FormatText(var_309_4.content)

				arg_306_1.text_.text = var_309_5

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_6 = 28
				local var_309_7 = utf8.len(var_309_5)
				local var_309_8 = var_309_6 <= 0 and var_309_2 or var_309_2 * (var_309_7 / var_309_6)

				if var_309_8 > 0 and var_309_2 < var_309_8 then
					arg_306_1.talkMaxDuration = var_309_8

					if var_309_8 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_1
					end
				end

				arg_306_1.text_.text = var_309_5
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb") ~= 0 then
					local var_309_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb") / 1000

					if var_309_9 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_9 + var_309_1
					end

					if var_309_4.prefab_name ~= "" and arg_306_1.actors_[var_309_4.prefab_name] ~= nil then
						local var_309_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_4.prefab_name].transform, "story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb")

						arg_306_1:RecordAudio("103903076", var_309_10)
						arg_306_1:RecordAudio("103903076", var_309_10)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_11 = math.max(var_309_2, arg_306_1.talkMaxDuration)

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_11 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_1) / var_309_11

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_1 + var_309_11 and arg_306_1.time_ < var_309_1 + var_309_11 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play103903077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 103903077
		arg_310_1.duration_ = 7.87

		local var_310_0 = {
			ja = 7.866,
			ko = 6.6,
			zh = 6.6,
			en = 5.633
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play103903078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_313_1 = 0
			local var_313_2 = 0.525

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_3 = arg_310_1:FormatText(StoryNameCfg[56].name)

				arg_310_1.leftNameTxt_.text = var_313_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_4 = arg_310_1:GetWordFromCfg(103903077)
				local var_313_5 = arg_310_1:FormatText(var_313_4.content)

				arg_310_1.text_.text = var_313_5

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_6 = 21
				local var_313_7 = utf8.len(var_313_5)
				local var_313_8 = var_313_6 <= 0 and var_313_2 or var_313_2 * (var_313_7 / var_313_6)

				if var_313_8 > 0 and var_313_2 < var_313_8 then
					arg_310_1.talkMaxDuration = var_313_8

					if var_313_8 + var_313_1 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_8 + var_313_1
					end
				end

				arg_310_1.text_.text = var_313_5
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb") ~= 0 then
					local var_313_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb") / 1000

					if var_313_9 + var_313_1 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_9 + var_313_1
					end

					if var_313_4.prefab_name ~= "" and arg_310_1.actors_[var_313_4.prefab_name] ~= nil then
						local var_313_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_4.prefab_name].transform, "story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb")

						arg_310_1:RecordAudio("103903077", var_313_10)
						arg_310_1:RecordAudio("103903077", var_313_10)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_11 = math.max(var_313_2, arg_310_1.talkMaxDuration)

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_11 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_1) / var_313_11

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_1 + var_313_11 and arg_310_1.time_ < var_313_1 + var_313_11 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play103903078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 103903078
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play103903079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 0.5

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_2 = arg_314_1:GetWordFromCfg(103903078)
				local var_317_3 = arg_314_1:FormatText(var_317_2.content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 20
				local var_317_5 = utf8.len(var_317_3)
				local var_317_6 = var_317_4 <= 0 and var_317_1 or var_317_1 * (var_317_5 / var_317_4)

				if var_317_6 > 0 and var_317_1 < var_317_6 then
					arg_314_1.talkMaxDuration = var_317_6

					if var_317_6 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_7 and arg_314_1.time_ < var_317_0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play103903079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 103903079
		arg_318_1.duration_ = 6.83

		local var_318_0 = {
			ja = 6.833,
			ko = 5.2,
			zh = 5.2,
			en = 6.1
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play103903080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1039ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1039ui_story == nil then
				arg_318_1.var_.characterEffect1039ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.1

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect1039ui_story and not isNil(var_321_0) then
					arg_318_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1039ui_story then
				arg_318_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_321_4 = arg_318_1.actors_["1027ui_story"]
			local var_321_5 = 0

			if var_321_5 < arg_318_1.time_ and arg_318_1.time_ <= var_321_5 + arg_321_0 and not isNil(var_321_4) and arg_318_1.var_.characterEffect1027ui_story == nil then
				arg_318_1.var_.characterEffect1027ui_story = var_321_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_6 = 0.1

			if var_321_5 <= arg_318_1.time_ and arg_318_1.time_ < var_321_5 + var_321_6 and not isNil(var_321_4) then
				local var_321_7 = (arg_318_1.time_ - var_321_5) / var_321_6

				if arg_318_1.var_.characterEffect1027ui_story and not isNil(var_321_4) then
					local var_321_8 = Mathf.Lerp(0, 0.5, var_321_7)

					arg_318_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1027ui_story.fillRatio = var_321_8
				end
			end

			if arg_318_1.time_ >= var_321_5 + var_321_6 and arg_318_1.time_ < var_321_5 + var_321_6 + arg_321_0 and not isNil(var_321_4) and arg_318_1.var_.characterEffect1027ui_story then
				local var_321_9 = 0.5

				arg_318_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1027ui_story.fillRatio = var_321_9
			end

			local var_321_10 = arg_318_1.actors_["1027ui_story"].transform
			local var_321_11 = 0

			if var_321_11 < arg_318_1.time_ and arg_318_1.time_ <= var_321_11 + arg_321_0 then
				arg_318_1.var_.moveOldPos1027ui_story = var_321_10.localPosition
			end

			local var_321_12 = 0.001

			if var_321_11 <= arg_318_1.time_ and arg_318_1.time_ < var_321_11 + var_321_12 then
				local var_321_13 = (arg_318_1.time_ - var_321_11) / var_321_12
				local var_321_14 = Vector3.New(0, -0.922, -5.1)

				var_321_10.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1027ui_story, var_321_14, var_321_13)

				local var_321_15 = manager.ui.mainCamera.transform.position - var_321_10.position

				var_321_10.forward = Vector3.New(var_321_15.x, var_321_15.y, var_321_15.z)

				local var_321_16 = var_321_10.localEulerAngles

				var_321_16.z = 0
				var_321_16.x = 0
				var_321_10.localEulerAngles = var_321_16
			end

			if arg_318_1.time_ >= var_321_11 + var_321_12 and arg_318_1.time_ < var_321_11 + var_321_12 + arg_321_0 then
				var_321_10.localPosition = Vector3.New(0, -0.922, -5.1)

				local var_321_17 = manager.ui.mainCamera.transform.position - var_321_10.position

				var_321_10.forward = Vector3.New(var_321_17.x, var_321_17.y, var_321_17.z)

				local var_321_18 = var_321_10.localEulerAngles

				var_321_18.z = 0
				var_321_18.x = 0
				var_321_10.localEulerAngles = var_321_18
			end

			local var_321_19 = arg_318_1.actors_["1027ui_story"].transform
			local var_321_20 = 0.033

			if var_321_20 < arg_318_1.time_ and arg_318_1.time_ <= var_321_20 + arg_321_0 then
				arg_318_1.var_.moveOldPos1027ui_story = var_321_19.localPosition
			end

			local var_321_21 = 0.5

			if var_321_20 <= arg_318_1.time_ and arg_318_1.time_ < var_321_20 + var_321_21 then
				local var_321_22 = (arg_318_1.time_ - var_321_20) / var_321_21
				local var_321_23 = Vector3.New(-0.92, -0.922, -5.1)

				var_321_19.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1027ui_story, var_321_23, var_321_22)

				local var_321_24 = manager.ui.mainCamera.transform.position - var_321_19.position

				var_321_19.forward = Vector3.New(var_321_24.x, var_321_24.y, var_321_24.z)

				local var_321_25 = var_321_19.localEulerAngles

				var_321_25.z = 0
				var_321_25.x = 0
				var_321_19.localEulerAngles = var_321_25
			end

			if arg_318_1.time_ >= var_321_20 + var_321_21 and arg_318_1.time_ < var_321_20 + var_321_21 + arg_321_0 then
				var_321_19.localPosition = Vector3.New(-0.92, -0.922, -5.1)

				local var_321_26 = manager.ui.mainCamera.transform.position - var_321_19.position

				var_321_19.forward = Vector3.New(var_321_26.x, var_321_26.y, var_321_26.z)

				local var_321_27 = var_321_19.localEulerAngles

				var_321_27.z = 0
				var_321_27.x = 0
				var_321_19.localEulerAngles = var_321_27
			end

			local var_321_28 = arg_318_1.actors_["1039ui_story"].transform
			local var_321_29 = 0

			if var_321_29 < arg_318_1.time_ and arg_318_1.time_ <= var_321_29 + arg_321_0 then
				arg_318_1.var_.moveOldPos1039ui_story = var_321_28.localPosition
			end

			local var_321_30 = 0.001

			if var_321_29 <= arg_318_1.time_ and arg_318_1.time_ < var_321_29 + var_321_30 then
				local var_321_31 = (arg_318_1.time_ - var_321_29) / var_321_30
				local var_321_32 = Vector3.New(0.85, -1.06, -5.3)

				var_321_28.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1039ui_story, var_321_32, var_321_31)

				local var_321_33 = manager.ui.mainCamera.transform.position - var_321_28.position

				var_321_28.forward = Vector3.New(var_321_33.x, var_321_33.y, var_321_33.z)

				local var_321_34 = var_321_28.localEulerAngles

				var_321_34.z = 0
				var_321_34.x = 0
				var_321_28.localEulerAngles = var_321_34
			end

			if arg_318_1.time_ >= var_321_29 + var_321_30 and arg_318_1.time_ < var_321_29 + var_321_30 + arg_321_0 then
				var_321_28.localPosition = Vector3.New(0.85, -1.06, -5.3)

				local var_321_35 = manager.ui.mainCamera.transform.position - var_321_28.position

				var_321_28.forward = Vector3.New(var_321_35.x, var_321_35.y, var_321_35.z)

				local var_321_36 = var_321_28.localEulerAngles

				var_321_36.z = 0
				var_321_36.x = 0
				var_321_28.localEulerAngles = var_321_36
			end

			local var_321_37 = 0

			if var_321_37 < arg_318_1.time_ and arg_318_1.time_ <= var_321_37 + arg_321_0 then
				arg_318_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			local var_321_38 = 0

			if var_321_38 < arg_318_1.time_ and arg_318_1.time_ <= var_321_38 + arg_321_0 then
				arg_318_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_321_39 = 0
			local var_321_40 = 0.55

			if var_321_39 < arg_318_1.time_ and arg_318_1.time_ <= var_321_39 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_41 = arg_318_1:FormatText(StoryNameCfg[9].name)

				arg_318_1.leftNameTxt_.text = var_321_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_42 = arg_318_1:GetWordFromCfg(103903079)
				local var_321_43 = arg_318_1:FormatText(var_321_42.content)

				arg_318_1.text_.text = var_321_43

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_44 = 22
				local var_321_45 = utf8.len(var_321_43)
				local var_321_46 = var_321_44 <= 0 and var_321_40 or var_321_40 * (var_321_45 / var_321_44)

				if var_321_46 > 0 and var_321_40 < var_321_46 then
					arg_318_1.talkMaxDuration = var_321_46

					if var_321_46 + var_321_39 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_46 + var_321_39
					end
				end

				arg_318_1.text_.text = var_321_43
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb") ~= 0 then
					local var_321_47 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb") / 1000

					if var_321_47 + var_321_39 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_47 + var_321_39
					end

					if var_321_42.prefab_name ~= "" and arg_318_1.actors_[var_321_42.prefab_name] ~= nil then
						local var_321_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_42.prefab_name].transform, "story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb")

						arg_318_1:RecordAudio("103903079", var_321_48)
						arg_318_1:RecordAudio("103903079", var_321_48)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_49 = math.max(var_321_40, arg_318_1.talkMaxDuration)

			if var_321_39 <= arg_318_1.time_ and arg_318_1.time_ < var_321_39 + var_321_49 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_39) / var_321_49

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_39 + var_321_49 and arg_318_1.time_ < var_321_39 + var_321_49 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play103903080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 103903080
		arg_322_1.duration_ = 9

		local var_322_0 = {
			ja = 9,
			ko = 7.033,
			zh = 7.033,
			en = 6.833
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play103903081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["1027ui_story"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1027ui_story == nil then
				arg_322_1.var_.characterEffect1027ui_story = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.1

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect1027ui_story and not isNil(var_325_0) then
					arg_322_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1027ui_story then
				arg_322_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_325_4 = arg_322_1.actors_["1039ui_story"]
			local var_325_5 = 0

			if var_325_5 < arg_322_1.time_ and arg_322_1.time_ <= var_325_5 + arg_325_0 and not isNil(var_325_4) and arg_322_1.var_.characterEffect1039ui_story == nil then
				arg_322_1.var_.characterEffect1039ui_story = var_325_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_6 = 0.1

			if var_325_5 <= arg_322_1.time_ and arg_322_1.time_ < var_325_5 + var_325_6 and not isNil(var_325_4) then
				local var_325_7 = (arg_322_1.time_ - var_325_5) / var_325_6

				if arg_322_1.var_.characterEffect1039ui_story and not isNil(var_325_4) then
					local var_325_8 = Mathf.Lerp(0, 0.5, var_325_7)

					arg_322_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1039ui_story.fillRatio = var_325_8
				end
			end

			if arg_322_1.time_ >= var_325_5 + var_325_6 and arg_322_1.time_ < var_325_5 + var_325_6 + arg_325_0 and not isNil(var_325_4) and arg_322_1.var_.characterEffect1039ui_story then
				local var_325_9 = 0.5

				arg_322_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1039ui_story.fillRatio = var_325_9
			end

			local var_325_10 = 0

			if var_325_10 < arg_322_1.time_ and arg_322_1.time_ <= var_325_10 + arg_325_0 then
				arg_322_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action432")
			end

			local var_325_11 = 0

			if var_325_11 < arg_322_1.time_ and arg_322_1.time_ <= var_325_11 + arg_325_0 then
				arg_322_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_325_12 = 0
			local var_325_13 = 0.575

			if var_325_12 < arg_322_1.time_ and arg_322_1.time_ <= var_325_12 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_14 = arg_322_1:FormatText(StoryNameCfg[56].name)

				arg_322_1.leftNameTxt_.text = var_325_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_15 = arg_322_1:GetWordFromCfg(103903080)
				local var_325_16 = arg_322_1:FormatText(var_325_15.content)

				arg_322_1.text_.text = var_325_16

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_17 = 23
				local var_325_18 = utf8.len(var_325_16)
				local var_325_19 = var_325_17 <= 0 and var_325_13 or var_325_13 * (var_325_18 / var_325_17)

				if var_325_19 > 0 and var_325_13 < var_325_19 then
					arg_322_1.talkMaxDuration = var_325_19

					if var_325_19 + var_325_12 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_19 + var_325_12
					end
				end

				arg_322_1.text_.text = var_325_16
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb") ~= 0 then
					local var_325_20 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb") / 1000

					if var_325_20 + var_325_12 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_20 + var_325_12
					end

					if var_325_15.prefab_name ~= "" and arg_322_1.actors_[var_325_15.prefab_name] ~= nil then
						local var_325_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_15.prefab_name].transform, "story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb")

						arg_322_1:RecordAudio("103903080", var_325_21)
						arg_322_1:RecordAudio("103903080", var_325_21)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_22 = math.max(var_325_13, arg_322_1.talkMaxDuration)

			if var_325_12 <= arg_322_1.time_ and arg_322_1.time_ < var_325_12 + var_325_22 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_12) / var_325_22

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_12 + var_325_22 and arg_322_1.time_ < var_325_12 + var_325_22 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play103903081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 103903081
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play103903082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.525

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_2 = arg_326_1:GetWordFromCfg(103903081)
				local var_329_3 = arg_326_1:FormatText(var_329_2.content)

				arg_326_1.text_.text = var_329_3

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 21
				local var_329_5 = utf8.len(var_329_3)
				local var_329_6 = var_329_4 <= 0 and var_329_1 or var_329_1 * (var_329_5 / var_329_4)

				if var_329_6 > 0 and var_329_1 < var_329_6 then
					arg_326_1.talkMaxDuration = var_329_6

					if var_329_6 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_6 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_3
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_7 and arg_326_1.time_ < var_329_0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play103903082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 103903082
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play103903083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1027ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1027ui_story == nil then
				arg_330_1.var_.characterEffect1027ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.1

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect1027ui_story and not isNil(var_333_0) then
					local var_333_4 = Mathf.Lerp(0, 0.5, var_333_3)

					arg_330_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1027ui_story.fillRatio = var_333_4
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1027ui_story then
				local var_333_5 = 0.5

				arg_330_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1027ui_story.fillRatio = var_333_5
			end

			local var_333_6 = 0
			local var_333_7 = 0.575

			if var_333_6 < arg_330_1.time_ and arg_330_1.time_ <= var_333_6 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_8 = arg_330_1:GetWordFromCfg(103903082)
				local var_333_9 = arg_330_1:FormatText(var_333_8.content)

				arg_330_1.text_.text = var_333_9

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_10 = 23
				local var_333_11 = utf8.len(var_333_9)
				local var_333_12 = var_333_10 <= 0 and var_333_7 or var_333_7 * (var_333_11 / var_333_10)

				if var_333_12 > 0 and var_333_7 < var_333_12 then
					arg_330_1.talkMaxDuration = var_333_12

					if var_333_12 + var_333_6 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_12 + var_333_6
					end
				end

				arg_330_1.text_.text = var_333_9
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_13 = math.max(var_333_7, arg_330_1.talkMaxDuration)

			if var_333_6 <= arg_330_1.time_ and arg_330_1.time_ < var_333_6 + var_333_13 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_6) / var_333_13

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_6 + var_333_13 and arg_330_1.time_ < var_333_6 + var_333_13 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play103903083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 103903083
		arg_334_1.duration_ = 7.23

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play103903084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1039ui_story"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1039ui_story == nil then
				arg_334_1.var_.characterEffect1039ui_story = var_337_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.1

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.characterEffect1039ui_story and not isNil(var_337_0) then
					arg_334_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1039ui_story then
				arg_334_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_337_4 = arg_334_1.actors_["1027ui_story"].transform
			local var_337_5 = 0

			if var_337_5 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.var_.moveOldPos1027ui_story = var_337_4.localPosition
			end

			local var_337_6 = 0.001

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_6 then
				local var_337_7 = (arg_334_1.time_ - var_337_5) / var_337_6
				local var_337_8 = Vector3.New(10, -0.922, -5.1)

				var_337_4.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1027ui_story, var_337_8, var_337_7)

				local var_337_9 = manager.ui.mainCamera.transform.position - var_337_4.position

				var_337_4.forward = Vector3.New(var_337_9.x, var_337_9.y, var_337_9.z)

				local var_337_10 = var_337_4.localEulerAngles

				var_337_10.z = 0
				var_337_10.x = 0
				var_337_4.localEulerAngles = var_337_10
			end

			if arg_334_1.time_ >= var_337_5 + var_337_6 and arg_334_1.time_ < var_337_5 + var_337_6 + arg_337_0 then
				var_337_4.localPosition = Vector3.New(10, -0.922, -5.1)

				local var_337_11 = manager.ui.mainCamera.transform.position - var_337_4.position

				var_337_4.forward = Vector3.New(var_337_11.x, var_337_11.y, var_337_11.z)

				local var_337_12 = var_337_4.localEulerAngles

				var_337_12.z = 0
				var_337_12.x = 0
				var_337_4.localEulerAngles = var_337_12
			end

			local var_337_13 = arg_334_1.actors_["1039ui_story"].transform
			local var_337_14 = 0

			if var_337_14 < arg_334_1.time_ and arg_334_1.time_ <= var_337_14 + arg_337_0 then
				arg_334_1.var_.moveOldPos1039ui_story = var_337_13.localPosition
			end

			local var_337_15 = 0.001

			if var_337_14 <= arg_334_1.time_ and arg_334_1.time_ < var_337_14 + var_337_15 then
				local var_337_16 = (arg_334_1.time_ - var_337_14) / var_337_15
				local var_337_17 = Vector3.New(0.85, -1.06, -5.3)

				var_337_13.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1039ui_story, var_337_17, var_337_16)

				local var_337_18 = manager.ui.mainCamera.transform.position - var_337_13.position

				var_337_13.forward = Vector3.New(var_337_18.x, var_337_18.y, var_337_18.z)

				local var_337_19 = var_337_13.localEulerAngles

				var_337_19.z = 0
				var_337_19.x = 0
				var_337_13.localEulerAngles = var_337_19
			end

			if arg_334_1.time_ >= var_337_14 + var_337_15 and arg_334_1.time_ < var_337_14 + var_337_15 + arg_337_0 then
				var_337_13.localPosition = Vector3.New(0.85, -1.06, -5.3)

				local var_337_20 = manager.ui.mainCamera.transform.position - var_337_13.position

				var_337_13.forward = Vector3.New(var_337_20.x, var_337_20.y, var_337_20.z)

				local var_337_21 = var_337_13.localEulerAngles

				var_337_21.z = 0
				var_337_21.x = 0
				var_337_13.localEulerAngles = var_337_21
			end

			local var_337_22 = arg_334_1.actors_["1039ui_story"].transform
			local var_337_23 = 0.033

			if var_337_23 < arg_334_1.time_ and arg_334_1.time_ <= var_337_23 + arg_337_0 then
				arg_334_1.var_.moveOldPos1039ui_story = var_337_22.localPosition
			end

			local var_337_24 = 0.5

			if var_337_23 <= arg_334_1.time_ and arg_334_1.time_ < var_337_23 + var_337_24 then
				local var_337_25 = (arg_334_1.time_ - var_337_23) / var_337_24
				local var_337_26 = Vector3.New(0, -1.06, -5.3)

				var_337_22.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1039ui_story, var_337_26, var_337_25)

				local var_337_27 = manager.ui.mainCamera.transform.position - var_337_22.position

				var_337_22.forward = Vector3.New(var_337_27.x, var_337_27.y, var_337_27.z)

				local var_337_28 = var_337_22.localEulerAngles

				var_337_28.z = 0
				var_337_28.x = 0
				var_337_22.localEulerAngles = var_337_28
			end

			if arg_334_1.time_ >= var_337_23 + var_337_24 and arg_334_1.time_ < var_337_23 + var_337_24 + arg_337_0 then
				var_337_22.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_337_29 = manager.ui.mainCamera.transform.position - var_337_22.position

				var_337_22.forward = Vector3.New(var_337_29.x, var_337_29.y, var_337_29.z)

				local var_337_30 = var_337_22.localEulerAngles

				var_337_30.z = 0
				var_337_30.x = 0
				var_337_22.localEulerAngles = var_337_30
			end

			local var_337_31 = 0

			if var_337_31 < arg_334_1.time_ and arg_334_1.time_ <= var_337_31 + arg_337_0 then
				arg_334_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action426")
			end

			local var_337_32 = 0
			local var_337_33 = 0.475

			if var_337_32 < arg_334_1.time_ and arg_334_1.time_ <= var_337_32 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_34 = arg_334_1:GetWordFromCfg(103903083)
				local var_337_35 = arg_334_1:FormatText(var_337_34.content)

				arg_334_1.text_.text = var_337_35

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_36 = 19
				local var_337_37 = utf8.len(var_337_35)
				local var_337_38 = var_337_36 <= 0 and var_337_33 or var_337_33 * (var_337_37 / var_337_36)

				if var_337_38 > 0 and var_337_33 < var_337_38 then
					arg_334_1.talkMaxDuration = var_337_38

					if var_337_38 + var_337_32 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_38 + var_337_32
					end
				end

				arg_334_1.text_.text = var_337_35
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_39 = math.max(var_337_33, arg_334_1.talkMaxDuration)

			if var_337_32 <= arg_334_1.time_ and arg_334_1.time_ < var_337_32 + var_337_39 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_32) / var_337_39

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_32 + var_337_39 and arg_334_1.time_ < var_337_32 + var_337_39 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play103903084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 103903084
		arg_338_1.duration_ = 7.53

		local var_338_0 = {
			ja = 7.533,
			ko = 4.966,
			zh = 4.966,
			en = 4.133
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play103903085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action464")
			end

			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_341_2 = 0
			local var_341_3 = 0.45

			if var_341_2 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_4 = arg_338_1:FormatText(StoryNameCfg[9].name)

				arg_338_1.leftNameTxt_.text = var_341_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_5 = arg_338_1:GetWordFromCfg(103903084)
				local var_341_6 = arg_338_1:FormatText(var_341_5.content)

				arg_338_1.text_.text = var_341_6

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_7 = 18
				local var_341_8 = utf8.len(var_341_6)
				local var_341_9 = var_341_7 <= 0 and var_341_3 or var_341_3 * (var_341_8 / var_341_7)

				if var_341_9 > 0 and var_341_3 < var_341_9 then
					arg_338_1.talkMaxDuration = var_341_9

					if var_341_9 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_9 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_6
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb") ~= 0 then
					local var_341_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb") / 1000

					if var_341_10 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_10 + var_341_2
					end

					if var_341_5.prefab_name ~= "" and arg_338_1.actors_[var_341_5.prefab_name] ~= nil then
						local var_341_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_5.prefab_name].transform, "story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb")

						arg_338_1:RecordAudio("103903084", var_341_11)
						arg_338_1:RecordAudio("103903084", var_341_11)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_12 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_12 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_12

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_12 and arg_338_1.time_ < var_341_2 + var_341_12 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play103903085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 103903085
		arg_342_1.duration_ = 5.9

		local var_342_0 = {
			ja = 5.4,
			ko = 5.9,
			zh = 5.9,
			en = 3.5
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play103903086(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_345_1 = 0
			local var_345_2 = 0.65

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_3 = arg_342_1:FormatText(StoryNameCfg[9].name)

				arg_342_1.leftNameTxt_.text = var_345_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_4 = arg_342_1:GetWordFromCfg(103903085)
				local var_345_5 = arg_342_1:FormatText(var_345_4.content)

				arg_342_1.text_.text = var_345_5

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_6 = 26
				local var_345_7 = utf8.len(var_345_5)
				local var_345_8 = var_345_6 <= 0 and var_345_2 or var_345_2 * (var_345_7 / var_345_6)

				if var_345_8 > 0 and var_345_2 < var_345_8 then
					arg_342_1.talkMaxDuration = var_345_8

					if var_345_8 + var_345_1 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_1
					end
				end

				arg_342_1.text_.text = var_345_5
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb") ~= 0 then
					local var_345_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb") / 1000

					if var_345_9 + var_345_1 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_9 + var_345_1
					end

					if var_345_4.prefab_name ~= "" and arg_342_1.actors_[var_345_4.prefab_name] ~= nil then
						local var_345_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_4.prefab_name].transform, "story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb")

						arg_342_1:RecordAudio("103903085", var_345_10)
						arg_342_1:RecordAudio("103903085", var_345_10)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_11 = math.max(var_345_2, arg_342_1.talkMaxDuration)

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_11 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_1) / var_345_11

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_1 + var_345_11 and arg_342_1.time_ < var_345_1 + var_345_11 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play103903086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 103903086
		arg_346_1.duration_ = 2

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play103903087(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1027ui_story"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1027ui_story == nil then
				arg_346_1.var_.characterEffect1027ui_story = var_349_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.1

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.characterEffect1027ui_story and not isNil(var_349_0) then
					arg_346_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1027ui_story then
				arg_346_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_349_4 = arg_346_1.actors_["1039ui_story"]
			local var_349_5 = 0

			if var_349_5 < arg_346_1.time_ and arg_346_1.time_ <= var_349_5 + arg_349_0 and not isNil(var_349_4) and arg_346_1.var_.characterEffect1039ui_story == nil then
				arg_346_1.var_.characterEffect1039ui_story = var_349_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_6 = 0.1

			if var_349_5 <= arg_346_1.time_ and arg_346_1.time_ < var_349_5 + var_349_6 and not isNil(var_349_4) then
				local var_349_7 = (arg_346_1.time_ - var_349_5) / var_349_6

				if arg_346_1.var_.characterEffect1039ui_story and not isNil(var_349_4) then
					local var_349_8 = Mathf.Lerp(0, 0.5, var_349_7)

					arg_346_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1039ui_story.fillRatio = var_349_8
				end
			end

			if arg_346_1.time_ >= var_349_5 + var_349_6 and arg_346_1.time_ < var_349_5 + var_349_6 + arg_349_0 and not isNil(var_349_4) and arg_346_1.var_.characterEffect1039ui_story then
				local var_349_9 = 0.5

				arg_346_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1039ui_story.fillRatio = var_349_9
			end

			local var_349_10 = arg_346_1.actors_["1039ui_story"].transform
			local var_349_11 = 0

			if var_349_11 < arg_346_1.time_ and arg_346_1.time_ <= var_349_11 + arg_349_0 then
				arg_346_1.var_.moveOldPos1039ui_story = var_349_10.localPosition
			end

			local var_349_12 = 0.001

			if var_349_11 <= arg_346_1.time_ and arg_346_1.time_ < var_349_11 + var_349_12 then
				local var_349_13 = (arg_346_1.time_ - var_349_11) / var_349_12
				local var_349_14 = Vector3.New(10, -1.06, -5.3)

				var_349_10.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1039ui_story, var_349_14, var_349_13)

				local var_349_15 = manager.ui.mainCamera.transform.position - var_349_10.position

				var_349_10.forward = Vector3.New(var_349_15.x, var_349_15.y, var_349_15.z)

				local var_349_16 = var_349_10.localEulerAngles

				var_349_16.z = 0
				var_349_16.x = 0
				var_349_10.localEulerAngles = var_349_16
			end

			if arg_346_1.time_ >= var_349_11 + var_349_12 and arg_346_1.time_ < var_349_11 + var_349_12 + arg_349_0 then
				var_349_10.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_349_17 = manager.ui.mainCamera.transform.position - var_349_10.position

				var_349_10.forward = Vector3.New(var_349_17.x, var_349_17.y, var_349_17.z)

				local var_349_18 = var_349_10.localEulerAngles

				var_349_18.z = 0
				var_349_18.x = 0
				var_349_10.localEulerAngles = var_349_18
			end

			local var_349_19 = arg_346_1.actors_["1027ui_story"].transform
			local var_349_20 = 0

			if var_349_20 < arg_346_1.time_ and arg_346_1.time_ <= var_349_20 + arg_349_0 then
				arg_346_1.var_.moveOldPos1027ui_story = var_349_19.localPosition
			end

			local var_349_21 = 0.001

			if var_349_20 <= arg_346_1.time_ and arg_346_1.time_ < var_349_20 + var_349_21 then
				local var_349_22 = (arg_346_1.time_ - var_349_20) / var_349_21
				local var_349_23 = Vector3.New(0, -0.922, -5.1)

				var_349_19.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1027ui_story, var_349_23, var_349_22)

				local var_349_24 = manager.ui.mainCamera.transform.position - var_349_19.position

				var_349_19.forward = Vector3.New(var_349_24.x, var_349_24.y, var_349_24.z)

				local var_349_25 = var_349_19.localEulerAngles

				var_349_25.z = 0
				var_349_25.x = 0
				var_349_19.localEulerAngles = var_349_25
			end

			if arg_346_1.time_ >= var_349_20 + var_349_21 and arg_346_1.time_ < var_349_20 + var_349_21 + arg_349_0 then
				var_349_19.localPosition = Vector3.New(0, -0.922, -5.1)

				local var_349_26 = manager.ui.mainCamera.transform.position - var_349_19.position

				var_349_19.forward = Vector3.New(var_349_26.x, var_349_26.y, var_349_26.z)

				local var_349_27 = var_349_19.localEulerAngles

				var_349_27.z = 0
				var_349_27.x = 0
				var_349_19.localEulerAngles = var_349_27
			end

			local var_349_28 = 0

			if var_349_28 < arg_346_1.time_ and arg_346_1.time_ <= var_349_28 + arg_349_0 then
				arg_346_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_349_29 = 0

			if var_349_29 < arg_346_1.time_ and arg_346_1.time_ <= var_349_29 + arg_349_0 then
				arg_346_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_349_30 = 0
			local var_349_31 = 0.05

			if var_349_30 < arg_346_1.time_ and arg_346_1.time_ <= var_349_30 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_32 = arg_346_1:FormatText(StoryNameCfg[56].name)

				arg_346_1.leftNameTxt_.text = var_349_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_33 = arg_346_1:GetWordFromCfg(103903086)
				local var_349_34 = arg_346_1:FormatText(var_349_33.content)

				arg_346_1.text_.text = var_349_34

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_35 = 2
				local var_349_36 = utf8.len(var_349_34)
				local var_349_37 = var_349_35 <= 0 and var_349_31 or var_349_31 * (var_349_36 / var_349_35)

				if var_349_37 > 0 and var_349_31 < var_349_37 then
					arg_346_1.talkMaxDuration = var_349_37

					if var_349_37 + var_349_30 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_37 + var_349_30
					end
				end

				arg_346_1.text_.text = var_349_34
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb") ~= 0 then
					local var_349_38 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb") / 1000

					if var_349_38 + var_349_30 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_38 + var_349_30
					end

					if var_349_33.prefab_name ~= "" and arg_346_1.actors_[var_349_33.prefab_name] ~= nil then
						local var_349_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_33.prefab_name].transform, "story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb")

						arg_346_1:RecordAudio("103903086", var_349_39)
						arg_346_1:RecordAudio("103903086", var_349_39)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_40 = math.max(var_349_31, arg_346_1.talkMaxDuration)

			if var_349_30 <= arg_346_1.time_ and arg_346_1.time_ < var_349_30 + var_349_40 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_30) / var_349_40

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_30 + var_349_40 and arg_346_1.time_ < var_349_30 + var_349_40 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play103903087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 103903087
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play103903088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1027ui_story"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1027ui_story == nil then
				arg_350_1.var_.characterEffect1027ui_story = var_353_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.1

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.characterEffect1027ui_story and not isNil(var_353_0) then
					local var_353_4 = Mathf.Lerp(0, 0.5, var_353_3)

					arg_350_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1027ui_story.fillRatio = var_353_4
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1027ui_story then
				local var_353_5 = 0.5

				arg_350_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1027ui_story.fillRatio = var_353_5
			end

			local var_353_6 = arg_350_1.actors_["1027ui_story"].transform
			local var_353_7 = 0

			if var_353_7 < arg_350_1.time_ and arg_350_1.time_ <= var_353_7 + arg_353_0 then
				arg_350_1.var_.moveOldPos1027ui_story = var_353_6.localPosition
			end

			local var_353_8 = 0.001

			if var_353_7 <= arg_350_1.time_ and arg_350_1.time_ < var_353_7 + var_353_8 then
				local var_353_9 = (arg_350_1.time_ - var_353_7) / var_353_8
				local var_353_10 = Vector3.New(10, -0.922, -5.1)

				var_353_6.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1027ui_story, var_353_10, var_353_9)

				local var_353_11 = manager.ui.mainCamera.transform.position - var_353_6.position

				var_353_6.forward = Vector3.New(var_353_11.x, var_353_11.y, var_353_11.z)

				local var_353_12 = var_353_6.localEulerAngles

				var_353_12.z = 0
				var_353_12.x = 0
				var_353_6.localEulerAngles = var_353_12
			end

			if arg_350_1.time_ >= var_353_7 + var_353_8 and arg_350_1.time_ < var_353_7 + var_353_8 + arg_353_0 then
				var_353_6.localPosition = Vector3.New(10, -0.922, -5.1)

				local var_353_13 = manager.ui.mainCamera.transform.position - var_353_6.position

				var_353_6.forward = Vector3.New(var_353_13.x, var_353_13.y, var_353_13.z)

				local var_353_14 = var_353_6.localEulerAngles

				var_353_14.z = 0
				var_353_14.x = 0
				var_353_6.localEulerAngles = var_353_14
			end

			local var_353_15 = 0
			local var_353_16 = 0.9

			if var_353_15 < arg_350_1.time_ and arg_350_1.time_ <= var_353_15 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_17 = arg_350_1:GetWordFromCfg(103903087)
				local var_353_18 = arg_350_1:FormatText(var_353_17.content)

				arg_350_1.text_.text = var_353_18

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_19 = 36
				local var_353_20 = utf8.len(var_353_18)
				local var_353_21 = var_353_19 <= 0 and var_353_16 or var_353_16 * (var_353_20 / var_353_19)

				if var_353_21 > 0 and var_353_16 < var_353_21 then
					arg_350_1.talkMaxDuration = var_353_21

					if var_353_21 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_21 + var_353_15
					end
				end

				arg_350_1.text_.text = var_353_18
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_22 = math.max(var_353_16, arg_350_1.talkMaxDuration)

			if var_353_15 <= arg_350_1.time_ and arg_350_1.time_ < var_353_15 + var_353_22 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_15) / var_353_22

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_15 + var_353_22 and arg_350_1.time_ < var_353_15 + var_353_22 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play103903088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 103903088
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play103903089(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0
			local var_357_1 = 1.175

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_2 = arg_354_1:GetWordFromCfg(103903088)
				local var_357_3 = arg_354_1:FormatText(var_357_2.content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_4 = 47
				local var_357_5 = utf8.len(var_357_3)
				local var_357_6 = var_357_4 <= 0 and var_357_1 or var_357_1 * (var_357_5 / var_357_4)

				if var_357_6 > 0 and var_357_1 < var_357_6 then
					arg_354_1.talkMaxDuration = var_357_6

					if var_357_6 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_6 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_7 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_7 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_7

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_7 and arg_354_1.time_ < var_357_0 + var_357_7 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play103903089 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 103903089
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play103903090(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 0.2

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[7].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(103903089)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 8
				local var_361_6 = utf8.len(var_361_4)
				local var_361_7 = var_361_5 <= 0 and var_361_1 or var_361_1 * (var_361_6 / var_361_5)

				if var_361_7 > 0 and var_361_1 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_8 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_8 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_8

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_8 and arg_358_1.time_ < var_361_0 + var_361_8 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play103903090 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 103903090
		arg_362_1.duration_ = 4.87

		local var_362_0 = {
			ja = 4.866,
			ko = 3.5,
			zh = 3.5,
			en = 4.1
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play103903091(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["1039ui_story"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect1039ui_story == nil then
				arg_362_1.var_.characterEffect1039ui_story = var_365_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.1

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.characterEffect1039ui_story and not isNil(var_365_0) then
					arg_362_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect1039ui_story then
				arg_362_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_365_4 = arg_362_1.actors_["1039ui_story"].transform
			local var_365_5 = 0

			if var_365_5 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1.var_.moveOldPos1039ui_story = var_365_4.localPosition
			end

			local var_365_6 = 0.001

			if var_365_5 <= arg_362_1.time_ and arg_362_1.time_ < var_365_5 + var_365_6 then
				local var_365_7 = (arg_362_1.time_ - var_365_5) / var_365_6
				local var_365_8 = Vector3.New(0, -1.06, -5.3)

				var_365_4.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1039ui_story, var_365_8, var_365_7)

				local var_365_9 = manager.ui.mainCamera.transform.position - var_365_4.position

				var_365_4.forward = Vector3.New(var_365_9.x, var_365_9.y, var_365_9.z)

				local var_365_10 = var_365_4.localEulerAngles

				var_365_10.z = 0
				var_365_10.x = 0
				var_365_4.localEulerAngles = var_365_10
			end

			if arg_362_1.time_ >= var_365_5 + var_365_6 and arg_362_1.time_ < var_365_5 + var_365_6 + arg_365_0 then
				var_365_4.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_365_11 = manager.ui.mainCamera.transform.position - var_365_4.position

				var_365_4.forward = Vector3.New(var_365_11.x, var_365_11.y, var_365_11.z)

				local var_365_12 = var_365_4.localEulerAngles

				var_365_12.z = 0
				var_365_12.x = 0
				var_365_4.localEulerAngles = var_365_12
			end

			local var_365_13 = 0

			if var_365_13 < arg_362_1.time_ and arg_362_1.time_ <= var_365_13 + arg_365_0 then
				arg_362_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action3_1")
			end

			local var_365_14 = 0

			if var_365_14 < arg_362_1.time_ and arg_362_1.time_ <= var_365_14 + arg_365_0 then
				arg_362_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_365_15 = 0
			local var_365_16 = 0.3

			if var_365_15 < arg_362_1.time_ and arg_362_1.time_ <= var_365_15 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_17 = arg_362_1:FormatText(StoryNameCfg[9].name)

				arg_362_1.leftNameTxt_.text = var_365_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_18 = arg_362_1:GetWordFromCfg(103903090)
				local var_365_19 = arg_362_1:FormatText(var_365_18.content)

				arg_362_1.text_.text = var_365_19

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_20 = 12
				local var_365_21 = utf8.len(var_365_19)
				local var_365_22 = var_365_20 <= 0 and var_365_16 or var_365_16 * (var_365_21 / var_365_20)

				if var_365_22 > 0 and var_365_16 < var_365_22 then
					arg_362_1.talkMaxDuration = var_365_22

					if var_365_22 + var_365_15 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_22 + var_365_15
					end
				end

				arg_362_1.text_.text = var_365_19
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb") ~= 0 then
					local var_365_23 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb") / 1000

					if var_365_23 + var_365_15 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_23 + var_365_15
					end

					if var_365_18.prefab_name ~= "" and arg_362_1.actors_[var_365_18.prefab_name] ~= nil then
						local var_365_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_18.prefab_name].transform, "story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb")

						arg_362_1:RecordAudio("103903090", var_365_24)
						arg_362_1:RecordAudio("103903090", var_365_24)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_25 = math.max(var_365_16, arg_362_1.talkMaxDuration)

			if var_365_15 <= arg_362_1.time_ and arg_362_1.time_ < var_365_15 + var_365_25 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_15) / var_365_25

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_15 + var_365_25 and arg_362_1.time_ < var_365_15 + var_365_25 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play103903091 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 103903091
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play103903092(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0
			local var_369_1 = 0.675

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_2 = arg_366_1:GetWordFromCfg(103903091)
				local var_369_3 = arg_366_1:FormatText(var_369_2.content)

				arg_366_1.text_.text = var_369_3

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_4 = 27
				local var_369_5 = utf8.len(var_369_3)
				local var_369_6 = var_369_4 <= 0 and var_369_1 or var_369_1 * (var_369_5 / var_369_4)

				if var_369_6 > 0 and var_369_1 < var_369_6 then
					arg_366_1.talkMaxDuration = var_369_6

					if var_369_6 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_6 + var_369_0
					end
				end

				arg_366_1.text_.text = var_369_3
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_7 = math.max(var_369_1, arg_366_1.talkMaxDuration)

			if var_369_0 <= arg_366_1.time_ and arg_366_1.time_ < var_369_0 + var_369_7 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_0) / var_369_7

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_0 + var_369_7 and arg_366_1.time_ < var_369_0 + var_369_7 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play103903092 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 103903092
		arg_370_1.duration_ = 2.37

		local var_370_0 = {
			ja = 2.366,
			ko = 2.3,
			zh = 2.3,
			en = 1.999999999999
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play103903093(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action432")
			end

			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_373_2 = 0
			local var_373_3 = 0.1

			if var_373_2 < arg_370_1.time_ and arg_370_1.time_ <= var_373_2 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_4 = arg_370_1:FormatText(StoryNameCfg[9].name)

				arg_370_1.leftNameTxt_.text = var_373_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_5 = arg_370_1:GetWordFromCfg(103903092)
				local var_373_6 = arg_370_1:FormatText(var_373_5.content)

				arg_370_1.text_.text = var_373_6

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_7 = 4
				local var_373_8 = utf8.len(var_373_6)
				local var_373_9 = var_373_7 <= 0 and var_373_3 or var_373_3 * (var_373_8 / var_373_7)

				if var_373_9 > 0 and var_373_3 < var_373_9 then
					arg_370_1.talkMaxDuration = var_373_9

					if var_373_9 + var_373_2 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_9 + var_373_2
					end
				end

				arg_370_1.text_.text = var_373_6
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb") ~= 0 then
					local var_373_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb") / 1000

					if var_373_10 + var_373_2 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_2
					end

					if var_373_5.prefab_name ~= "" and arg_370_1.actors_[var_373_5.prefab_name] ~= nil then
						local var_373_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_5.prefab_name].transform, "story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb")

						arg_370_1:RecordAudio("103903092", var_373_11)
						arg_370_1:RecordAudio("103903092", var_373_11)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_12 = math.max(var_373_3, arg_370_1.talkMaxDuration)

			if var_373_2 <= arg_370_1.time_ and arg_370_1.time_ < var_373_2 + var_373_12 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_2) / var_373_12

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_2 + var_373_12 and arg_370_1.time_ < var_373_2 + var_373_12 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play103903093 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 103903093
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play103903094(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 0.5

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_2 = arg_374_1:GetWordFromCfg(103903093)
				local var_377_3 = arg_374_1:FormatText(var_377_2.content)

				arg_374_1.text_.text = var_377_3

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 20
				local var_377_5 = utf8.len(var_377_3)
				local var_377_6 = var_377_4 <= 0 and var_377_1 or var_377_1 * (var_377_5 / var_377_4)

				if var_377_6 > 0 and var_377_1 < var_377_6 then
					arg_374_1.talkMaxDuration = var_377_6

					if var_377_6 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_6 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_3
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_7 and arg_374_1.time_ < var_377_0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play103903094 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 103903094
		arg_378_1.duration_ = 2.8

		local var_378_0 = {
			ja = 2.8,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.466
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play103903095(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action425")
			end

			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_381_2 = 0
			local var_381_3 = 0.175

			if var_381_2 < arg_378_1.time_ and arg_378_1.time_ <= var_381_2 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_4 = arg_378_1:FormatText(StoryNameCfg[9].name)

				arg_378_1.leftNameTxt_.text = var_381_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_5 = arg_378_1:GetWordFromCfg(103903094)
				local var_381_6 = arg_378_1:FormatText(var_381_5.content)

				arg_378_1.text_.text = var_381_6

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_7 = 7
				local var_381_8 = utf8.len(var_381_6)
				local var_381_9 = var_381_7 <= 0 and var_381_3 or var_381_3 * (var_381_8 / var_381_7)

				if var_381_9 > 0 and var_381_3 < var_381_9 then
					arg_378_1.talkMaxDuration = var_381_9

					if var_381_9 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_9 + var_381_2
					end
				end

				arg_378_1.text_.text = var_381_6
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb") ~= 0 then
					local var_381_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb") / 1000

					if var_381_10 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_10 + var_381_2
					end

					if var_381_5.prefab_name ~= "" and arg_378_1.actors_[var_381_5.prefab_name] ~= nil then
						local var_381_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_5.prefab_name].transform, "story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb")

						arg_378_1:RecordAudio("103903094", var_381_11)
						arg_378_1:RecordAudio("103903094", var_381_11)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_12 = math.max(var_381_3, arg_378_1.talkMaxDuration)

			if var_381_2 <= arg_378_1.time_ and arg_378_1.time_ < var_381_2 + var_381_12 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_2) / var_381_12

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_2 + var_381_12 and arg_378_1.time_ < var_381_2 + var_381_12 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play103903095 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 103903095
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play103903096(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1039ui_story"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1039ui_story == nil then
				arg_382_1.var_.characterEffect1039ui_story = var_385_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.1

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.characterEffect1039ui_story and not isNil(var_385_0) then
					local var_385_4 = Mathf.Lerp(0, 0.5, var_385_3)

					arg_382_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1039ui_story.fillRatio = var_385_4
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1039ui_story then
				local var_385_5 = 0.5

				arg_382_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1039ui_story.fillRatio = var_385_5
			end

			local var_385_6 = 0
			local var_385_7 = 0.725

			if var_385_6 < arg_382_1.time_ and arg_382_1.time_ <= var_385_6 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_8 = arg_382_1:GetWordFromCfg(103903095)
				local var_385_9 = arg_382_1:FormatText(var_385_8.content)

				arg_382_1.text_.text = var_385_9

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_10 = 29
				local var_385_11 = utf8.len(var_385_9)
				local var_385_12 = var_385_10 <= 0 and var_385_7 or var_385_7 * (var_385_11 / var_385_10)

				if var_385_12 > 0 and var_385_7 < var_385_12 then
					arg_382_1.talkMaxDuration = var_385_12

					if var_385_12 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_12 + var_385_6
					end
				end

				arg_382_1.text_.text = var_385_9
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_13 = math.max(var_385_7, arg_382_1.talkMaxDuration)

			if var_385_6 <= arg_382_1.time_ and arg_382_1.time_ < var_385_6 + var_385_13 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_6) / var_385_13

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_6 + var_385_13 and arg_382_1.time_ < var_385_6 + var_385_13 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play103903096 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 103903096
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play103903097(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 0.475

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_2 = arg_386_1:GetWordFromCfg(103903096)
				local var_389_3 = arg_386_1:FormatText(var_389_2.content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_4 = 19
				local var_389_5 = utf8.len(var_389_3)
				local var_389_6 = var_389_4 <= 0 and var_389_1 or var_389_1 * (var_389_5 / var_389_4)

				if var_389_6 > 0 and var_389_1 < var_389_6 then
					arg_386_1.talkMaxDuration = var_389_6

					if var_389_6 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_6 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_7 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_7 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_7

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_7 and arg_386_1.time_ < var_389_0 + var_389_7 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play103903097 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 103903097
		arg_390_1.duration_ = 4.6

		local var_390_0 = {
			ja = 4.6,
			ko = 2.5,
			zh = 2.5,
			en = 2.066
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play103903098(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1027ui_story"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect1027ui_story == nil then
				arg_390_1.var_.characterEffect1027ui_story = var_393_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_2 = 0.1

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.characterEffect1027ui_story and not isNil(var_393_0) then
					arg_390_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect1027ui_story then
				arg_390_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_393_4 = arg_390_1.actors_["1039ui_story"].transform
			local var_393_5 = 0

			if var_393_5 < arg_390_1.time_ and arg_390_1.time_ <= var_393_5 + arg_393_0 then
				arg_390_1.var_.moveOldPos1039ui_story = var_393_4.localPosition
			end

			local var_393_6 = 0.001

			if var_393_5 <= arg_390_1.time_ and arg_390_1.time_ < var_393_5 + var_393_6 then
				local var_393_7 = (arg_390_1.time_ - var_393_5) / var_393_6
				local var_393_8 = Vector3.New(10, -1.06, -5.3)

				var_393_4.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1039ui_story, var_393_8, var_393_7)

				local var_393_9 = manager.ui.mainCamera.transform.position - var_393_4.position

				var_393_4.forward = Vector3.New(var_393_9.x, var_393_9.y, var_393_9.z)

				local var_393_10 = var_393_4.localEulerAngles

				var_393_10.z = 0
				var_393_10.x = 0
				var_393_4.localEulerAngles = var_393_10
			end

			if arg_390_1.time_ >= var_393_5 + var_393_6 and arg_390_1.time_ < var_393_5 + var_393_6 + arg_393_0 then
				var_393_4.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_393_11 = manager.ui.mainCamera.transform.position - var_393_4.position

				var_393_4.forward = Vector3.New(var_393_11.x, var_393_11.y, var_393_11.z)

				local var_393_12 = var_393_4.localEulerAngles

				var_393_12.z = 0
				var_393_12.x = 0
				var_393_4.localEulerAngles = var_393_12
			end

			local var_393_13 = arg_390_1.actors_["1027ui_story"].transform
			local var_393_14 = 0

			if var_393_14 < arg_390_1.time_ and arg_390_1.time_ <= var_393_14 + arg_393_0 then
				arg_390_1.var_.moveOldPos1027ui_story = var_393_13.localPosition
			end

			local var_393_15 = 0.001

			if var_393_14 <= arg_390_1.time_ and arg_390_1.time_ < var_393_14 + var_393_15 then
				local var_393_16 = (arg_390_1.time_ - var_393_14) / var_393_15
				local var_393_17 = Vector3.New(0, -0.922, -5.1)

				var_393_13.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1027ui_story, var_393_17, var_393_16)

				local var_393_18 = manager.ui.mainCamera.transform.position - var_393_13.position

				var_393_13.forward = Vector3.New(var_393_18.x, var_393_18.y, var_393_18.z)

				local var_393_19 = var_393_13.localEulerAngles

				var_393_19.z = 0
				var_393_19.x = 0
				var_393_13.localEulerAngles = var_393_19
			end

			if arg_390_1.time_ >= var_393_14 + var_393_15 and arg_390_1.time_ < var_393_14 + var_393_15 + arg_393_0 then
				var_393_13.localPosition = Vector3.New(0, -0.922, -5.1)

				local var_393_20 = manager.ui.mainCamera.transform.position - var_393_13.position

				var_393_13.forward = Vector3.New(var_393_20.x, var_393_20.y, var_393_20.z)

				local var_393_21 = var_393_13.localEulerAngles

				var_393_21.z = 0
				var_393_21.x = 0
				var_393_13.localEulerAngles = var_393_21
			end

			local var_393_22 = 0

			if var_393_22 < arg_390_1.time_ and arg_390_1.time_ <= var_393_22 + arg_393_0 then
				arg_390_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_393_23 = 0

			if var_393_23 < arg_390_1.time_ and arg_390_1.time_ <= var_393_23 + arg_393_0 then
				arg_390_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_393_24 = 0
			local var_393_25 = 0.1

			if var_393_24 < arg_390_1.time_ and arg_390_1.time_ <= var_393_24 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_26 = arg_390_1:FormatText(StoryNameCfg[56].name)

				arg_390_1.leftNameTxt_.text = var_393_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_27 = arg_390_1:GetWordFromCfg(103903097)
				local var_393_28 = arg_390_1:FormatText(var_393_27.content)

				arg_390_1.text_.text = var_393_28

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_29 = 4
				local var_393_30 = utf8.len(var_393_28)
				local var_393_31 = var_393_29 <= 0 and var_393_25 or var_393_25 * (var_393_30 / var_393_29)

				if var_393_31 > 0 and var_393_25 < var_393_31 then
					arg_390_1.talkMaxDuration = var_393_31

					if var_393_31 + var_393_24 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_31 + var_393_24
					end
				end

				arg_390_1.text_.text = var_393_28
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb") ~= 0 then
					local var_393_32 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb") / 1000

					if var_393_32 + var_393_24 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_32 + var_393_24
					end

					if var_393_27.prefab_name ~= "" and arg_390_1.actors_[var_393_27.prefab_name] ~= nil then
						local var_393_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_27.prefab_name].transform, "story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb")

						arg_390_1:RecordAudio("103903097", var_393_33)
						arg_390_1:RecordAudio("103903097", var_393_33)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_34 = math.max(var_393_25, arg_390_1.talkMaxDuration)

			if var_393_24 <= arg_390_1.time_ and arg_390_1.time_ < var_393_24 + var_393_34 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_24) / var_393_34

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_24 + var_393_34 and arg_390_1.time_ < var_393_24 + var_393_34 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play103903098 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 103903098
		arg_394_1.duration_ = 6.92

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play103903099(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 1

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				local var_397_2 = "play"
				local var_397_3 = "music"

				arg_394_1:AudioAction(var_397_2, var_397_3, "ui_battle", "ui_battle_resumebgm", "")

				local var_397_4 = ""
				local var_397_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_resumebgm")

				if var_397_5 ~= "" then
					if arg_394_1.bgmTxt_.text ~= var_397_5 and arg_394_1.bgmTxt_.text ~= "" then
						if arg_394_1.bgmTxt2_.text ~= "" then
							arg_394_1.bgmTxt_.text = arg_394_1.bgmTxt2_.text
						end

						arg_394_1.bgmTxt2_.text = var_397_5

						arg_394_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_394_1.bgmTxt_.text = var_397_5
						arg_394_1.bgmTxt2_.text = var_397_5
					end

					if arg_394_1.bgmTimer then
						arg_394_1.bgmTimer:Stop()

						arg_394_1.bgmTimer = nil
					end

					if arg_394_1.settingData.show_music_name == 1 then
						arg_394_1.musicController:SetSelectedState("show")
						arg_394_1.musicAnimator_:Play("open", 0, 0)

						if arg_394_1.settingData.music_time ~= 0 then
							arg_394_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_394_1.settingData.music_time), function()
								if arg_394_1 == nil or isNil(arg_394_1.bgmTxt_) then
									return
								end

								arg_394_1.musicController:SetSelectedState("hide")
								arg_394_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_397_6 = 0

			if var_397_6 < arg_394_1.time_ and arg_394_1.time_ <= var_397_6 + arg_397_0 then
				arg_394_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action427")
			end

			local var_397_7 = 0
			local var_397_8 = 0.975

			if var_397_7 < arg_394_1.time_ and arg_394_1.time_ <= var_397_7 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_9 = arg_394_1:GetWordFromCfg(103903098)
				local var_397_10 = arg_394_1:FormatText(var_397_9.content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_11 = 39
				local var_397_12 = utf8.len(var_397_10)
				local var_397_13 = var_397_11 <= 0 and var_397_8 or var_397_8 * (var_397_12 / var_397_11)

				if var_397_13 > 0 and var_397_8 < var_397_13 then
					arg_394_1.talkMaxDuration = var_397_13

					if var_397_13 + var_397_7 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_7
					end
				end

				arg_394_1.text_.text = var_397_10
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_14 = math.max(var_397_8, arg_394_1.talkMaxDuration)

			if var_397_7 <= arg_394_1.time_ and arg_394_1.time_ < var_397_7 + var_397_14 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_7) / var_397_14

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_7 + var_397_14 and arg_394_1.time_ < var_397_7 + var_397_14 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play103903099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 103903099
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play103903100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1027ui_story"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1027ui_story == nil then
				arg_399_1.var_.characterEffect1027ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.1

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.characterEffect1027ui_story and not isNil(var_402_0) then
					local var_402_4 = Mathf.Lerp(0, 0.5, var_402_3)

					arg_399_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1027ui_story.fillRatio = var_402_4
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1027ui_story then
				local var_402_5 = 0.5

				arg_399_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1027ui_story.fillRatio = var_402_5
			end

			local var_402_6 = arg_399_1.actors_["1027ui_story"].transform
			local var_402_7 = 0

			if var_402_7 < arg_399_1.time_ and arg_399_1.time_ <= var_402_7 + arg_402_0 then
				arg_399_1.var_.moveOldPos1027ui_story = var_402_6.localPosition
			end

			local var_402_8 = 0.001

			if var_402_7 <= arg_399_1.time_ and arg_399_1.time_ < var_402_7 + var_402_8 then
				local var_402_9 = (arg_399_1.time_ - var_402_7) / var_402_8
				local var_402_10 = Vector3.New(10, -0.922, -5.1)

				var_402_6.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1027ui_story, var_402_10, var_402_9)

				local var_402_11 = manager.ui.mainCamera.transform.position - var_402_6.position

				var_402_6.forward = Vector3.New(var_402_11.x, var_402_11.y, var_402_11.z)

				local var_402_12 = var_402_6.localEulerAngles

				var_402_12.z = 0
				var_402_12.x = 0
				var_402_6.localEulerAngles = var_402_12
			end

			if arg_399_1.time_ >= var_402_7 + var_402_8 and arg_399_1.time_ < var_402_7 + var_402_8 + arg_402_0 then
				var_402_6.localPosition = Vector3.New(10, -0.922, -5.1)

				local var_402_13 = manager.ui.mainCamera.transform.position - var_402_6.position

				var_402_6.forward = Vector3.New(var_402_13.x, var_402_13.y, var_402_13.z)

				local var_402_14 = var_402_6.localEulerAngles

				var_402_14.z = 0
				var_402_14.x = 0
				var_402_6.localEulerAngles = var_402_14
			end

			local var_402_15 = 0
			local var_402_16 = 0.825

			if var_402_15 < arg_399_1.time_ and arg_399_1.time_ <= var_402_15 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_17 = arg_399_1:GetWordFromCfg(103903099)
				local var_402_18 = arg_399_1:FormatText(var_402_17.content)

				arg_399_1.text_.text = var_402_18

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_19 = 33
				local var_402_20 = utf8.len(var_402_18)
				local var_402_21 = var_402_19 <= 0 and var_402_16 or var_402_16 * (var_402_20 / var_402_19)

				if var_402_21 > 0 and var_402_16 < var_402_21 then
					arg_399_1.talkMaxDuration = var_402_21

					if var_402_21 + var_402_15 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_21 + var_402_15
					end
				end

				arg_399_1.text_.text = var_402_18
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_22 = math.max(var_402_16, arg_399_1.talkMaxDuration)

			if var_402_15 <= arg_399_1.time_ and arg_399_1.time_ < var_402_15 + var_402_22 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_15) / var_402_22

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_15 + var_402_22 and arg_399_1.time_ < var_402_15 + var_402_22 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play103903100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 103903100
		arg_403_1.duration_ = 6.23

		local var_403_0 = {
			ja = 6.233,
			ko = 4.6,
			zh = 4.6,
			en = 6
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play103903101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1039ui_story"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1039ui_story == nil then
				arg_403_1.var_.characterEffect1039ui_story = var_406_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.1

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 and not isNil(var_406_0) then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2

				if arg_403_1.var_.characterEffect1039ui_story and not isNil(var_406_0) then
					arg_403_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1039ui_story then
				arg_403_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_406_4 = arg_403_1.actors_["1039ui_story"].transform
			local var_406_5 = 0

			if var_406_5 < arg_403_1.time_ and arg_403_1.time_ <= var_406_5 + arg_406_0 then
				arg_403_1.var_.moveOldPos1039ui_story = var_406_4.localPosition
			end

			local var_406_6 = 0.001

			if var_406_5 <= arg_403_1.time_ and arg_403_1.time_ < var_406_5 + var_406_6 then
				local var_406_7 = (arg_403_1.time_ - var_406_5) / var_406_6
				local var_406_8 = Vector3.New(0, -1.06, -5.3)

				var_406_4.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1039ui_story, var_406_8, var_406_7)

				local var_406_9 = manager.ui.mainCamera.transform.position - var_406_4.position

				var_406_4.forward = Vector3.New(var_406_9.x, var_406_9.y, var_406_9.z)

				local var_406_10 = var_406_4.localEulerAngles

				var_406_10.z = 0
				var_406_10.x = 0
				var_406_4.localEulerAngles = var_406_10
			end

			if arg_403_1.time_ >= var_406_5 + var_406_6 and arg_403_1.time_ < var_406_5 + var_406_6 + arg_406_0 then
				var_406_4.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_406_11 = manager.ui.mainCamera.transform.position - var_406_4.position

				var_406_4.forward = Vector3.New(var_406_11.x, var_406_11.y, var_406_11.z)

				local var_406_12 = var_406_4.localEulerAngles

				var_406_12.z = 0
				var_406_12.x = 0
				var_406_4.localEulerAngles = var_406_12
			end

			local var_406_13 = 0

			if var_406_13 < arg_403_1.time_ and arg_403_1.time_ <= var_406_13 + arg_406_0 then
				arg_403_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			local var_406_14 = 0

			if var_406_14 < arg_403_1.time_ and arg_403_1.time_ <= var_406_14 + arg_406_0 then
				arg_403_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_406_15 = 0
			local var_406_16 = 0.55

			if var_406_15 < arg_403_1.time_ and arg_403_1.time_ <= var_406_15 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_17 = arg_403_1:FormatText(StoryNameCfg[9].name)

				arg_403_1.leftNameTxt_.text = var_406_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_18 = arg_403_1:GetWordFromCfg(103903100)
				local var_406_19 = arg_403_1:FormatText(var_406_18.content)

				arg_403_1.text_.text = var_406_19

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_20 = 22
				local var_406_21 = utf8.len(var_406_19)
				local var_406_22 = var_406_20 <= 0 and var_406_16 or var_406_16 * (var_406_21 / var_406_20)

				if var_406_22 > 0 and var_406_16 < var_406_22 then
					arg_403_1.talkMaxDuration = var_406_22

					if var_406_22 + var_406_15 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_22 + var_406_15
					end
				end

				arg_403_1.text_.text = var_406_19
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb") ~= 0 then
					local var_406_23 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb") / 1000

					if var_406_23 + var_406_15 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_23 + var_406_15
					end

					if var_406_18.prefab_name ~= "" and arg_403_1.actors_[var_406_18.prefab_name] ~= nil then
						local var_406_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_18.prefab_name].transform, "story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb")

						arg_403_1:RecordAudio("103903100", var_406_24)
						arg_403_1:RecordAudio("103903100", var_406_24)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_25 = math.max(var_406_16, arg_403_1.talkMaxDuration)

			if var_406_15 <= arg_403_1.time_ and arg_403_1.time_ < var_406_15 + var_406_25 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_15) / var_406_25

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_15 + var_406_25 and arg_403_1.time_ < var_406_15 + var_406_25 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play103903101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 103903101
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play103903102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1039ui_story"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1039ui_story == nil then
				arg_407_1.var_.characterEffect1039ui_story = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.1

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.characterEffect1039ui_story and not isNil(var_410_0) then
					local var_410_4 = Mathf.Lerp(0, 0.5, var_410_3)

					arg_407_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1039ui_story.fillRatio = var_410_4
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1039ui_story then
				local var_410_5 = 0.5

				arg_407_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1039ui_story.fillRatio = var_410_5
			end

			local var_410_6 = 0
			local var_410_7 = 0.3

			if var_410_6 < arg_407_1.time_ and arg_407_1.time_ <= var_410_6 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_8 = arg_407_1:FormatText(StoryNameCfg[7].name)

				arg_407_1.leftNameTxt_.text = var_410_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_9 = arg_407_1:GetWordFromCfg(103903101)
				local var_410_10 = arg_407_1:FormatText(var_410_9.content)

				arg_407_1.text_.text = var_410_10

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_11 = 12
				local var_410_12 = utf8.len(var_410_10)
				local var_410_13 = var_410_11 <= 0 and var_410_7 or var_410_7 * (var_410_12 / var_410_11)

				if var_410_13 > 0 and var_410_7 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_6
					end
				end

				arg_407_1.text_.text = var_410_10
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_14 = math.max(var_410_7, arg_407_1.talkMaxDuration)

			if var_410_6 <= arg_407_1.time_ and arg_407_1.time_ < var_410_6 + var_410_14 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_6) / var_410_14

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_6 + var_410_14 and arg_407_1.time_ < var_410_6 + var_410_14 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play103903102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 103903102
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play103903103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1039ui_story"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos1039ui_story = var_414_0.localPosition
			end

			local var_414_2 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2
				local var_414_4 = Vector3.New(10, -1.06, -5.3)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1039ui_story, var_414_4, var_414_3)

				local var_414_5 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_5.x, var_414_5.y, var_414_5.z)

				local var_414_6 = var_414_0.localEulerAngles

				var_414_6.z = 0
				var_414_6.x = 0
				var_414_0.localEulerAngles = var_414_6
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_414_7 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_7.x, var_414_7.y, var_414_7.z)

				local var_414_8 = var_414_0.localEulerAngles

				var_414_8.z = 0
				var_414_8.x = 0
				var_414_0.localEulerAngles = var_414_8
			end

			local var_414_9 = 0
			local var_414_10 = 0.425

			if var_414_9 < arg_411_1.time_ and arg_411_1.time_ <= var_414_9 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_11 = arg_411_1:GetWordFromCfg(103903102)
				local var_414_12 = arg_411_1:FormatText(var_414_11.content)

				arg_411_1.text_.text = var_414_12

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_13 = 17
				local var_414_14 = utf8.len(var_414_12)
				local var_414_15 = var_414_13 <= 0 and var_414_10 or var_414_10 * (var_414_14 / var_414_13)

				if var_414_15 > 0 and var_414_10 < var_414_15 then
					arg_411_1.talkMaxDuration = var_414_15

					if var_414_15 + var_414_9 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_15 + var_414_9
					end
				end

				arg_411_1.text_.text = var_414_12
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_16 = math.max(var_414_10, arg_411_1.talkMaxDuration)

			if var_414_9 <= arg_411_1.time_ and arg_411_1.time_ < var_414_9 + var_414_16 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_9) / var_414_16

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_9 + var_414_16 and arg_411_1.time_ < var_414_9 + var_414_16 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play103903103 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 103903103
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play103903104(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0
			local var_418_1 = 0.1

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_2 = arg_415_1:FormatText(StoryNameCfg[7].name)

				arg_415_1.leftNameTxt_.text = var_418_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_3 = arg_415_1:GetWordFromCfg(103903103)
				local var_418_4 = arg_415_1:FormatText(var_418_3.content)

				arg_415_1.text_.text = var_418_4

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 4
				local var_418_6 = utf8.len(var_418_4)
				local var_418_7 = var_418_5 <= 0 and var_418_1 or var_418_1 * (var_418_6 / var_418_5)

				if var_418_7 > 0 and var_418_1 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_4
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_8 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_8 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_8

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_8 and arg_415_1.time_ < var_418_0 + var_418_8 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play103903104 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 103903104
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play103903105(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.425

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_2 = arg_419_1:GetWordFromCfg(103903104)
				local var_422_3 = arg_419_1:FormatText(var_422_2.content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 17
				local var_422_5 = utf8.len(var_422_3)
				local var_422_6 = var_422_4 <= 0 and var_422_1 or var_422_1 * (var_422_5 / var_422_4)

				if var_422_6 > 0 and var_422_1 < var_422_6 then
					arg_419_1.talkMaxDuration = var_422_6

					if var_422_6 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_6 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_7 and arg_419_1.time_ < var_422_0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play103903105 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 103903105
		arg_423_1.duration_ = 2.3

		local var_423_0 = {
			ja = 2.3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play103903106(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1039ui_story"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1039ui_story == nil then
				arg_423_1.var_.characterEffect1039ui_story = var_426_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.1

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.characterEffect1039ui_story and not isNil(var_426_0) then
					arg_423_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1039ui_story then
				arg_423_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_426_4 = arg_423_1.actors_["1039ui_story"].transform
			local var_426_5 = 0

			if var_426_5 < arg_423_1.time_ and arg_423_1.time_ <= var_426_5 + arg_426_0 then
				arg_423_1.var_.moveOldPos1039ui_story = var_426_4.localPosition
			end

			local var_426_6 = 0.001

			if var_426_5 <= arg_423_1.time_ and arg_423_1.time_ < var_426_5 + var_426_6 then
				local var_426_7 = (arg_423_1.time_ - var_426_5) / var_426_6
				local var_426_8 = Vector3.New(0, -1.06, -5.3)

				var_426_4.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1039ui_story, var_426_8, var_426_7)

				local var_426_9 = manager.ui.mainCamera.transform.position - var_426_4.position

				var_426_4.forward = Vector3.New(var_426_9.x, var_426_9.y, var_426_9.z)

				local var_426_10 = var_426_4.localEulerAngles

				var_426_10.z = 0
				var_426_10.x = 0
				var_426_4.localEulerAngles = var_426_10
			end

			if arg_423_1.time_ >= var_426_5 + var_426_6 and arg_423_1.time_ < var_426_5 + var_426_6 + arg_426_0 then
				var_426_4.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_426_11 = manager.ui.mainCamera.transform.position - var_426_4.position

				var_426_4.forward = Vector3.New(var_426_11.x, var_426_11.y, var_426_11.z)

				local var_426_12 = var_426_4.localEulerAngles

				var_426_12.z = 0
				var_426_12.x = 0
				var_426_4.localEulerAngles = var_426_12
			end

			local var_426_13 = 0

			if var_426_13 < arg_423_1.time_ and arg_423_1.time_ <= var_426_13 + arg_426_0 then
				arg_423_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			local var_426_14 = 0

			if var_426_14 < arg_423_1.time_ and arg_423_1.time_ <= var_426_14 + arg_426_0 then
				arg_423_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_426_15 = 0
			local var_426_16 = 0.1

			if var_426_15 < arg_423_1.time_ and arg_423_1.time_ <= var_426_15 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_17 = arg_423_1:FormatText(StoryNameCfg[9].name)

				arg_423_1.leftNameTxt_.text = var_426_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_18 = arg_423_1:GetWordFromCfg(103903105)
				local var_426_19 = arg_423_1:FormatText(var_426_18.content)

				arg_423_1.text_.text = var_426_19

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_20 = 4
				local var_426_21 = utf8.len(var_426_19)
				local var_426_22 = var_426_20 <= 0 and var_426_16 or var_426_16 * (var_426_21 / var_426_20)

				if var_426_22 > 0 and var_426_16 < var_426_22 then
					arg_423_1.talkMaxDuration = var_426_22

					if var_426_22 + var_426_15 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_22 + var_426_15
					end
				end

				arg_423_1.text_.text = var_426_19
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb") ~= 0 then
					local var_426_23 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb") / 1000

					if var_426_23 + var_426_15 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_23 + var_426_15
					end

					if var_426_18.prefab_name ~= "" and arg_423_1.actors_[var_426_18.prefab_name] ~= nil then
						local var_426_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_18.prefab_name].transform, "story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb")

						arg_423_1:RecordAudio("103903105", var_426_24)
						arg_423_1:RecordAudio("103903105", var_426_24)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_25 = math.max(var_426_16, arg_423_1.talkMaxDuration)

			if var_426_15 <= arg_423_1.time_ and arg_423_1.time_ < var_426_15 + var_426_25 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_15) / var_426_25

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_15 + var_426_25 and arg_423_1.time_ < var_426_15 + var_426_25 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play103903106 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 103903106
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play103903107(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 0.8

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_2 = arg_427_1:GetWordFromCfg(103903106)
				local var_430_3 = arg_427_1:FormatText(var_430_2.content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_4 = 31
				local var_430_5 = utf8.len(var_430_3)
				local var_430_6 = var_430_4 <= 0 and var_430_1 or var_430_1 * (var_430_5 / var_430_4)

				if var_430_6 > 0 and var_430_1 < var_430_6 then
					arg_427_1.talkMaxDuration = var_430_6

					if var_430_6 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_6 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_7 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_7 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_7

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_7 and arg_427_1.time_ < var_430_0 + var_430_7 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play103903107 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 103903107
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play103903108(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 0.3

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_2 = arg_431_1:GetWordFromCfg(103903107)
				local var_434_3 = arg_431_1:FormatText(var_434_2.content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_4 = 12
				local var_434_5 = utf8.len(var_434_3)
				local var_434_6 = var_434_4 <= 0 and var_434_1 or var_434_1 * (var_434_5 / var_434_4)

				if var_434_6 > 0 and var_434_1 < var_434_6 then
					arg_431_1.talkMaxDuration = var_434_6

					if var_434_6 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_6 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_7 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_7 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_7

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_7 and arg_431_1.time_ < var_434_0 + var_434_7 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play103903108 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 103903108
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play103903109(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1039ui_story"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1039ui_story == nil then
				arg_435_1.var_.characterEffect1039ui_story = var_438_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.1

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.characterEffect1039ui_story and not isNil(var_438_0) then
					local var_438_4 = Mathf.Lerp(0, 0.5, var_438_3)

					arg_435_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1039ui_story.fillRatio = var_438_4
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1039ui_story then
				local var_438_5 = 0.5

				arg_435_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1039ui_story.fillRatio = var_438_5
			end

			local var_438_6 = 0
			local var_438_7 = 0.4

			if var_438_6 < arg_435_1.time_ and arg_435_1.time_ <= var_438_6 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_8 = arg_435_1:FormatText(StoryNameCfg[7].name)

				arg_435_1.leftNameTxt_.text = var_438_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_9 = arg_435_1:GetWordFromCfg(103903108)
				local var_438_10 = arg_435_1:FormatText(var_438_9.content)

				arg_435_1.text_.text = var_438_10

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_11 = 16
				local var_438_12 = utf8.len(var_438_10)
				local var_438_13 = var_438_11 <= 0 and var_438_7 or var_438_7 * (var_438_12 / var_438_11)

				if var_438_13 > 0 and var_438_7 < var_438_13 then
					arg_435_1.talkMaxDuration = var_438_13

					if var_438_13 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_13 + var_438_6
					end
				end

				arg_435_1.text_.text = var_438_10
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_14 = math.max(var_438_7, arg_435_1.talkMaxDuration)

			if var_438_6 <= arg_435_1.time_ and arg_435_1.time_ < var_438_6 + var_438_14 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_6) / var_438_14

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_6 + var_438_14 and arg_435_1.time_ < var_438_6 + var_438_14 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play103903109 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 103903109
		arg_439_1.duration_ = 1.93

		local var_439_0 = {
			ja = 1.8,
			ko = 1.133,
			zh = 1.133,
			en = 1.933
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play103903110(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 1

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				local var_442_2 = "play"
				local var_442_3 = "music"

				arg_439_1:AudioAction(var_442_2, var_442_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_442_4 = ""
				local var_442_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_442_5 ~= "" then
					if arg_439_1.bgmTxt_.text ~= var_442_5 and arg_439_1.bgmTxt_.text ~= "" then
						if arg_439_1.bgmTxt2_.text ~= "" then
							arg_439_1.bgmTxt_.text = arg_439_1.bgmTxt2_.text
						end

						arg_439_1.bgmTxt2_.text = var_442_5

						arg_439_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_439_1.bgmTxt_.text = var_442_5
						arg_439_1.bgmTxt2_.text = var_442_5
					end

					if arg_439_1.bgmTimer then
						arg_439_1.bgmTimer:Stop()

						arg_439_1.bgmTimer = nil
					end

					if arg_439_1.settingData.show_music_name == 1 then
						arg_439_1.musicController:SetSelectedState("show")
						arg_439_1.musicAnimator_:Play("open", 0, 0)

						if arg_439_1.settingData.music_time ~= 0 then
							arg_439_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_439_1.settingData.music_time), function()
								if arg_439_1 == nil or isNil(arg_439_1.bgmTxt_) then
									return
								end

								arg_439_1.musicController:SetSelectedState("hide")
								arg_439_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_442_6 = arg_439_1.actors_["1039ui_story"]
			local var_442_7 = 0

			if var_442_7 < arg_439_1.time_ and arg_439_1.time_ <= var_442_7 + arg_442_0 and not isNil(var_442_6) and arg_439_1.var_.characterEffect1039ui_story == nil then
				arg_439_1.var_.characterEffect1039ui_story = var_442_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_8 = 0.1

			if var_442_7 <= arg_439_1.time_ and arg_439_1.time_ < var_442_7 + var_442_8 and not isNil(var_442_6) then
				local var_442_9 = (arg_439_1.time_ - var_442_7) / var_442_8

				if arg_439_1.var_.characterEffect1039ui_story and not isNil(var_442_6) then
					arg_439_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= var_442_7 + var_442_8 and arg_439_1.time_ < var_442_7 + var_442_8 + arg_442_0 and not isNil(var_442_6) and arg_439_1.var_.characterEffect1039ui_story then
				arg_439_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_442_10 = 0

			if var_442_10 < arg_439_1.time_ and arg_439_1.time_ <= var_442_10 + arg_442_0 then
				arg_439_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_442_11 = 0
			local var_442_12 = 0.05

			if var_442_11 < arg_439_1.time_ and arg_439_1.time_ <= var_442_11 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_13 = arg_439_1:FormatText(StoryNameCfg[9].name)

				arg_439_1.leftNameTxt_.text = var_442_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_14 = arg_439_1:GetWordFromCfg(103903109)
				local var_442_15 = arg_439_1:FormatText(var_442_14.content)

				arg_439_1.text_.text = var_442_15

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_16 = 2
				local var_442_17 = utf8.len(var_442_15)
				local var_442_18 = var_442_16 <= 0 and var_442_12 or var_442_12 * (var_442_17 / var_442_16)

				if var_442_18 > 0 and var_442_12 < var_442_18 then
					arg_439_1.talkMaxDuration = var_442_18

					if var_442_18 + var_442_11 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_18 + var_442_11
					end
				end

				arg_439_1.text_.text = var_442_15
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb") ~= 0 then
					local var_442_19 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb") / 1000

					if var_442_19 + var_442_11 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_19 + var_442_11
					end

					if var_442_14.prefab_name ~= "" and arg_439_1.actors_[var_442_14.prefab_name] ~= nil then
						local var_442_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_14.prefab_name].transform, "story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb")

						arg_439_1:RecordAudio("103903109", var_442_20)
						arg_439_1:RecordAudio("103903109", var_442_20)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_21 = math.max(var_442_12, arg_439_1.talkMaxDuration)

			if var_442_11 <= arg_439_1.time_ and arg_439_1.time_ < var_442_11 + var_442_21 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_11) / var_442_21

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_11 + var_442_21 and arg_439_1.time_ < var_442_11 + var_442_21 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play103903110 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 103903110
		arg_444_1.duration_ = 2.63

		local var_444_0 = {
			ja = 2.333,
			ko = 2.633,
			zh = 2.633,
			en = 2.466
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play103903111(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0
			local var_447_1 = 1

			if var_447_0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				local var_447_2 = "play"
				local var_447_3 = "music"

				arg_444_1:AudioAction(var_447_2, var_447_3, "bgm_story_mood_warm", "bgm_story_mood_warm", "bgm_story_mood_warm")

				local var_447_4 = ""
				local var_447_5 = manager.audio:GetAudioName("bgm_story_mood_warm", "bgm_story_mood_warm")

				if var_447_5 ~= "" then
					if arg_444_1.bgmTxt_.text ~= var_447_5 and arg_444_1.bgmTxt_.text ~= "" then
						if arg_444_1.bgmTxt2_.text ~= "" then
							arg_444_1.bgmTxt_.text = arg_444_1.bgmTxt2_.text
						end

						arg_444_1.bgmTxt2_.text = var_447_5

						arg_444_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_444_1.bgmTxt_.text = var_447_5
						arg_444_1.bgmTxt2_.text = var_447_5
					end

					if arg_444_1.bgmTimer then
						arg_444_1.bgmTimer:Stop()

						arg_444_1.bgmTimer = nil
					end

					if arg_444_1.settingData.show_music_name == 1 then
						arg_444_1.musicController:SetSelectedState("show")
						arg_444_1.musicAnimator_:Play("open", 0, 0)

						if arg_444_1.settingData.music_time ~= 0 then
							arg_444_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_444_1.settingData.music_time), function()
								if arg_444_1 == nil or isNil(arg_444_1.bgmTxt_) then
									return
								end

								arg_444_1.musicController:SetSelectedState("hide")
								arg_444_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_447_6 = 0

			if var_447_6 < arg_444_1.time_ and arg_444_1.time_ <= var_447_6 + arg_447_0 then
				arg_444_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action426")
			end

			local var_447_7 = 0

			if var_447_7 < arg_444_1.time_ and arg_444_1.time_ <= var_447_7 + arg_447_0 then
				arg_444_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_447_8 = 0
			local var_447_9 = 0.2

			if var_447_8 < arg_444_1.time_ and arg_444_1.time_ <= var_447_8 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_10 = arg_444_1:FormatText(StoryNameCfg[9].name)

				arg_444_1.leftNameTxt_.text = var_447_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_11 = arg_444_1:GetWordFromCfg(103903110)
				local var_447_12 = arg_444_1:FormatText(var_447_11.content)

				arg_444_1.text_.text = var_447_12

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_13 = 8
				local var_447_14 = utf8.len(var_447_12)
				local var_447_15 = var_447_13 <= 0 and var_447_9 or var_447_9 * (var_447_14 / var_447_13)

				if var_447_15 > 0 and var_447_9 < var_447_15 then
					arg_444_1.talkMaxDuration = var_447_15

					if var_447_15 + var_447_8 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_15 + var_447_8
					end
				end

				arg_444_1.text_.text = var_447_12
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb") ~= 0 then
					local var_447_16 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb") / 1000

					if var_447_16 + var_447_8 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_16 + var_447_8
					end

					if var_447_11.prefab_name ~= "" and arg_444_1.actors_[var_447_11.prefab_name] ~= nil then
						local var_447_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_11.prefab_name].transform, "story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb")

						arg_444_1:RecordAudio("103903110", var_447_17)
						arg_444_1:RecordAudio("103903110", var_447_17)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_18 = math.max(var_447_9, arg_444_1.talkMaxDuration)

			if var_447_8 <= arg_444_1.time_ and arg_444_1.time_ < var_447_8 + var_447_18 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_8) / var_447_18

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_8 + var_447_18 and arg_444_1.time_ < var_447_8 + var_447_18 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play103903111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 103903111
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play103903112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["1039ui_story"]
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.characterEffect1039ui_story == nil then
				arg_449_1.var_.characterEffect1039ui_story = var_452_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.1

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 and not isNil(var_452_0) then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2

				if arg_449_1.var_.characterEffect1039ui_story and not isNil(var_452_0) then
					local var_452_4 = Mathf.Lerp(0, 0.5, var_452_3)

					arg_449_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1039ui_story.fillRatio = var_452_4
				end
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.characterEffect1039ui_story then
				local var_452_5 = 0.5

				arg_449_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1039ui_story.fillRatio = var_452_5
			end

			local var_452_6 = 0
			local var_452_7 = 0.275

			if var_452_6 < arg_449_1.time_ and arg_449_1.time_ <= var_452_6 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_8 = arg_449_1:FormatText(StoryNameCfg[7].name)

				arg_449_1.leftNameTxt_.text = var_452_8

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

				local var_452_9 = arg_449_1:GetWordFromCfg(103903111)
				local var_452_10 = arg_449_1:FormatText(var_452_9.content)

				arg_449_1.text_.text = var_452_10

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_11 = 11
				local var_452_12 = utf8.len(var_452_10)
				local var_452_13 = var_452_11 <= 0 and var_452_7 or var_452_7 * (var_452_12 / var_452_11)

				if var_452_13 > 0 and var_452_7 < var_452_13 then
					arg_449_1.talkMaxDuration = var_452_13

					if var_452_13 + var_452_6 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_13 + var_452_6
					end
				end

				arg_449_1.text_.text = var_452_10
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_14 = math.max(var_452_7, arg_449_1.talkMaxDuration)

			if var_452_6 <= arg_449_1.time_ and arg_449_1.time_ < var_452_6 + var_452_14 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_6) / var_452_14

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_6 + var_452_14 and arg_449_1.time_ < var_452_6 + var_452_14 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play103903112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 103903112
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play103903113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.bgs_.D04a.transform
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.var_.moveOldPosD04a = var_456_0.localPosition
			end

			local var_456_2 = 0.001

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2
				local var_456_4 = Vector3.New(0, -100, 10)

				var_456_0.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPosD04a, var_456_4, var_456_3)
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 then
				var_456_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_456_5 = "ST01"

			if arg_453_1.bgs_[var_456_5] == nil then
				local var_456_6 = Object.Instantiate(arg_453_1.paintGo_)

				var_456_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_456_5)
				var_456_6.name = var_456_5
				var_456_6.transform.parent = arg_453_1.stage_.transform
				var_456_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_453_1.bgs_[var_456_5] = var_456_6
			end

			local var_456_7 = 0

			if var_456_7 < arg_453_1.time_ and arg_453_1.time_ <= var_456_7 + arg_456_0 then
				local var_456_8 = manager.ui.mainCamera.transform.localPosition
				local var_456_9 = Vector3.New(0, 0, 10) + Vector3.New(var_456_8.x, var_456_8.y, 0)
				local var_456_10 = arg_453_1.bgs_.ST01

				var_456_10.transform.localPosition = var_456_9
				var_456_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_456_11 = var_456_10:GetComponent("SpriteRenderer")

				if var_456_11 and var_456_11.sprite then
					local var_456_12 = (var_456_10.transform.localPosition - var_456_8).z
					local var_456_13 = manager.ui.mainCameraCom_
					local var_456_14 = 2 * var_456_12 * Mathf.Tan(var_456_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_456_15 = var_456_14 * var_456_13.aspect
					local var_456_16 = var_456_11.sprite.bounds.size.x
					local var_456_17 = var_456_11.sprite.bounds.size.y
					local var_456_18 = var_456_15 / var_456_16
					local var_456_19 = var_456_14 / var_456_17
					local var_456_20 = var_456_19 < var_456_18 and var_456_18 or var_456_19

					var_456_10.transform.localScale = Vector3.New(var_456_20, var_456_20, 0)
				end

				for iter_456_0, iter_456_1 in pairs(arg_453_1.bgs_) do
					if iter_456_0 ~= "ST01" then
						iter_456_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_456_21 = arg_453_1.actors_["1039ui_story"].transform
			local var_456_22 = 0

			if var_456_22 < arg_453_1.time_ and arg_453_1.time_ <= var_456_22 + arg_456_0 then
				arg_453_1.var_.moveOldPos1039ui_story = var_456_21.localPosition
			end

			local var_456_23 = 0.001

			if var_456_22 <= arg_453_1.time_ and arg_453_1.time_ < var_456_22 + var_456_23 then
				local var_456_24 = (arg_453_1.time_ - var_456_22) / var_456_23
				local var_456_25 = Vector3.New(10, -1.06, -5.3)

				var_456_21.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1039ui_story, var_456_25, var_456_24)

				local var_456_26 = manager.ui.mainCamera.transform.position - var_456_21.position

				var_456_21.forward = Vector3.New(var_456_26.x, var_456_26.y, var_456_26.z)

				local var_456_27 = var_456_21.localEulerAngles

				var_456_27.z = 0
				var_456_27.x = 0
				var_456_21.localEulerAngles = var_456_27
			end

			if arg_453_1.time_ >= var_456_22 + var_456_23 and arg_453_1.time_ < var_456_22 + var_456_23 + arg_456_0 then
				var_456_21.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_456_28 = manager.ui.mainCamera.transform.position - var_456_21.position

				var_456_21.forward = Vector3.New(var_456_28.x, var_456_28.y, var_456_28.z)

				local var_456_29 = var_456_21.localEulerAngles

				var_456_29.z = 0
				var_456_29.x = 0
				var_456_21.localEulerAngles = var_456_29
			end

			local var_456_30 = 0
			local var_456_31 = 0.125

			if var_456_30 < arg_453_1.time_ and arg_453_1.time_ <= var_456_30 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_32 = arg_453_1:FormatText(StoryNameCfg[7].name)

				arg_453_1.leftNameTxt_.text = var_456_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_33 = arg_453_1:GetWordFromCfg(103903112)
				local var_456_34 = arg_453_1:FormatText(var_456_33.content)

				arg_453_1.text_.text = var_456_34

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_35 = 5
				local var_456_36 = utf8.len(var_456_34)
				local var_456_37 = var_456_35 <= 0 and var_456_31 or var_456_31 * (var_456_36 / var_456_35)

				if var_456_37 > 0 and var_456_31 < var_456_37 then
					arg_453_1.talkMaxDuration = var_456_37

					if var_456_37 + var_456_30 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_37 + var_456_30
					end
				end

				arg_453_1.text_.text = var_456_34
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_38 = math.max(var_456_31, arg_453_1.talkMaxDuration)

			if var_456_30 <= arg_453_1.time_ and arg_453_1.time_ < var_456_30 + var_456_38 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_30) / var_456_38

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_30 + var_456_38 and arg_453_1.time_ < var_456_30 + var_456_38 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "D04a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play103903113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 103903113
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play103903114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 1.25

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_2 = arg_457_1:GetWordFromCfg(103903113)
				local var_460_3 = arg_457_1:FormatText(var_460_2.content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 50
				local var_460_5 = utf8.len(var_460_3)
				local var_460_6 = var_460_4 <= 0 and var_460_1 or var_460_1 * (var_460_5 / var_460_4)

				if var_460_6 > 0 and var_460_1 < var_460_6 then
					arg_457_1.talkMaxDuration = var_460_6

					if var_460_6 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_6 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_7 and arg_457_1.time_ < var_460_0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play103903114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 103903114
		arg_461_1.duration_ = 6.23

		local var_461_0 = {
			ja = 6.233,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.333
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
				arg_461_0:Play103903115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["1039ui_story"]
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.characterEffect1039ui_story == nil then
				arg_461_1.var_.characterEffect1039ui_story = var_464_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.1

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 and not isNil(var_464_0) then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2

				if arg_461_1.var_.characterEffect1039ui_story and not isNil(var_464_0) then
					arg_461_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.characterEffect1039ui_story then
				arg_461_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_464_4 = arg_461_1.actors_["1039ui_story"].transform
			local var_464_5 = 0

			if var_464_5 < arg_461_1.time_ and arg_461_1.time_ <= var_464_5 + arg_464_0 then
				arg_461_1.var_.moveOldPos1039ui_story = var_464_4.localPosition
			end

			local var_464_6 = 0.001

			if var_464_5 <= arg_461_1.time_ and arg_461_1.time_ < var_464_5 + var_464_6 then
				local var_464_7 = (arg_461_1.time_ - var_464_5) / var_464_6
				local var_464_8 = Vector3.New(0, -1.06, -5.3)

				var_464_4.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1039ui_story, var_464_8, var_464_7)

				local var_464_9 = manager.ui.mainCamera.transform.position - var_464_4.position

				var_464_4.forward = Vector3.New(var_464_9.x, var_464_9.y, var_464_9.z)

				local var_464_10 = var_464_4.localEulerAngles

				var_464_10.z = 0
				var_464_10.x = 0
				var_464_4.localEulerAngles = var_464_10
			end

			if arg_461_1.time_ >= var_464_5 + var_464_6 and arg_461_1.time_ < var_464_5 + var_464_6 + arg_464_0 then
				var_464_4.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_464_11 = manager.ui.mainCamera.transform.position - var_464_4.position

				var_464_4.forward = Vector3.New(var_464_11.x, var_464_11.y, var_464_11.z)

				local var_464_12 = var_464_4.localEulerAngles

				var_464_12.z = 0
				var_464_12.x = 0
				var_464_4.localEulerAngles = var_464_12
			end

			local var_464_13 = 0

			if var_464_13 < arg_461_1.time_ and arg_461_1.time_ <= var_464_13 + arg_464_0 then
				arg_461_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			local var_464_14 = 0

			if var_464_14 < arg_461_1.time_ and arg_461_1.time_ <= var_464_14 + arg_464_0 then
				arg_461_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_464_15 = 0
			local var_464_16 = 0.175

			if var_464_15 < arg_461_1.time_ and arg_461_1.time_ <= var_464_15 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_17 = arg_461_1:FormatText(StoryNameCfg[9].name)

				arg_461_1.leftNameTxt_.text = var_464_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_18 = arg_461_1:GetWordFromCfg(103903114)
				local var_464_19 = arg_461_1:FormatText(var_464_18.content)

				arg_461_1.text_.text = var_464_19

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_20 = 7
				local var_464_21 = utf8.len(var_464_19)
				local var_464_22 = var_464_20 <= 0 and var_464_16 or var_464_16 * (var_464_21 / var_464_20)

				if var_464_22 > 0 and var_464_16 < var_464_22 then
					arg_461_1.talkMaxDuration = var_464_22

					if var_464_22 + var_464_15 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_22 + var_464_15
					end
				end

				arg_461_1.text_.text = var_464_19
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb") ~= 0 then
					local var_464_23 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb") / 1000

					if var_464_23 + var_464_15 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_23 + var_464_15
					end

					if var_464_18.prefab_name ~= "" and arg_461_1.actors_[var_464_18.prefab_name] ~= nil then
						local var_464_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_18.prefab_name].transform, "story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb")

						arg_461_1:RecordAudio("103903114", var_464_24)
						arg_461_1:RecordAudio("103903114", var_464_24)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_25 = math.max(var_464_16, arg_461_1.talkMaxDuration)

			if var_464_15 <= arg_461_1.time_ and arg_461_1.time_ < var_464_15 + var_464_25 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_15) / var_464_25

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_15 + var_464_25 and arg_461_1.time_ < var_464_15 + var_464_25 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play103903115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 103903115
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play103903116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 0.7

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_2 = arg_465_1:GetWordFromCfg(103903115)
				local var_468_3 = arg_465_1:FormatText(var_468_2.content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 28
				local var_468_5 = utf8.len(var_468_3)
				local var_468_6 = var_468_4 <= 0 and var_468_1 or var_468_1 * (var_468_5 / var_468_4)

				if var_468_6 > 0 and var_468_1 < var_468_6 then
					arg_465_1.talkMaxDuration = var_468_6

					if var_468_6 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_6 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_7 and arg_465_1.time_ < var_468_0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play103903116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 103903116
		arg_469_1.duration_ = 4.23

		local var_469_0 = {
			ja = 4.033,
			ko = 3.666,
			zh = 3.666,
			en = 4.233
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
				arg_469_0:Play103903117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_472_2 = 0
			local var_472_3 = 0.225

			if var_472_2 < arg_469_1.time_ and arg_469_1.time_ <= var_472_2 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_4 = arg_469_1:FormatText(StoryNameCfg[9].name)

				arg_469_1.leftNameTxt_.text = var_472_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_5 = arg_469_1:GetWordFromCfg(103903116)
				local var_472_6 = arg_469_1:FormatText(var_472_5.content)

				arg_469_1.text_.text = var_472_6

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_7 = 9
				local var_472_8 = utf8.len(var_472_6)
				local var_472_9 = var_472_7 <= 0 and var_472_3 or var_472_3 * (var_472_8 / var_472_7)

				if var_472_9 > 0 and var_472_3 < var_472_9 then
					arg_469_1.talkMaxDuration = var_472_9

					if var_472_9 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_9 + var_472_2
					end
				end

				arg_469_1.text_.text = var_472_6
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb") ~= 0 then
					local var_472_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb") / 1000

					if var_472_10 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_10 + var_472_2
					end

					if var_472_5.prefab_name ~= "" and arg_469_1.actors_[var_472_5.prefab_name] ~= nil then
						local var_472_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_5.prefab_name].transform, "story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb")

						arg_469_1:RecordAudio("103903116", var_472_11)
						arg_469_1:RecordAudio("103903116", var_472_11)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_12 = math.max(var_472_3, arg_469_1.talkMaxDuration)

			if var_472_2 <= arg_469_1.time_ and arg_469_1.time_ < var_472_2 + var_472_12 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_2) / var_472_12

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_2 + var_472_12 and arg_469_1.time_ < var_472_2 + var_472_12 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play103903117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 103903117
		arg_473_1.duration_ = 17

		local var_473_0 = {
			ja = 14,
			ko = 13.8,
			zh = 13.8,
			en = 17
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play103903118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_476_1 = 0
			local var_476_2 = 1.425

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_3 = arg_473_1:FormatText(StoryNameCfg[9].name)

				arg_473_1.leftNameTxt_.text = var_476_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_4 = arg_473_1:GetWordFromCfg(103903117)
				local var_476_5 = arg_473_1:FormatText(var_476_4.content)

				arg_473_1.text_.text = var_476_5

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_6 = 57
				local var_476_7 = utf8.len(var_476_5)
				local var_476_8 = var_476_6 <= 0 and var_476_2 or var_476_2 * (var_476_7 / var_476_6)

				if var_476_8 > 0 and var_476_2 < var_476_8 then
					arg_473_1.talkMaxDuration = var_476_8

					if var_476_8 + var_476_1 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_1
					end
				end

				arg_473_1.text_.text = var_476_5
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb") ~= 0 then
					local var_476_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb") / 1000

					if var_476_9 + var_476_1 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_9 + var_476_1
					end

					if var_476_4.prefab_name ~= "" and arg_473_1.actors_[var_476_4.prefab_name] ~= nil then
						local var_476_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_4.prefab_name].transform, "story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb")

						arg_473_1:RecordAudio("103903117", var_476_10)
						arg_473_1:RecordAudio("103903117", var_476_10)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_11 = math.max(var_476_2, arg_473_1.talkMaxDuration)

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_11 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_1) / var_476_11

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_1 + var_476_11 and arg_473_1.time_ < var_476_1 + var_476_11 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play103903118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 103903118
		arg_477_1.duration_ = 10.9

		local var_477_0 = {
			ja = 10.9,
			ko = 8.8,
			zh = 8.8,
			en = 10.233
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
				arg_477_0:Play103903119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action445")
			end

			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_480_2 = 0
			local var_480_3 = 1.1

			if var_480_2 < arg_477_1.time_ and arg_477_1.time_ <= var_480_2 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_4 = arg_477_1:FormatText(StoryNameCfg[9].name)

				arg_477_1.leftNameTxt_.text = var_480_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_5 = arg_477_1:GetWordFromCfg(103903118)
				local var_480_6 = arg_477_1:FormatText(var_480_5.content)

				arg_477_1.text_.text = var_480_6

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_7 = 43
				local var_480_8 = utf8.len(var_480_6)
				local var_480_9 = var_480_7 <= 0 and var_480_3 or var_480_3 * (var_480_8 / var_480_7)

				if var_480_9 > 0 and var_480_3 < var_480_9 then
					arg_477_1.talkMaxDuration = var_480_9

					if var_480_9 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_9 + var_480_2
					end
				end

				arg_477_1.text_.text = var_480_6
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb") ~= 0 then
					local var_480_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb") / 1000

					if var_480_10 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_10 + var_480_2
					end

					if var_480_5.prefab_name ~= "" and arg_477_1.actors_[var_480_5.prefab_name] ~= nil then
						local var_480_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_5.prefab_name].transform, "story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb")

						arg_477_1:RecordAudio("103903118", var_480_11)
						arg_477_1:RecordAudio("103903118", var_480_11)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_12 = math.max(var_480_3, arg_477_1.talkMaxDuration)

			if var_480_2 <= arg_477_1.time_ and arg_477_1.time_ < var_480_2 + var_480_12 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_2) / var_480_12

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_2 + var_480_12 and arg_477_1.time_ < var_480_2 + var_480_12 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play103903119 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 103903119
		arg_481_1.duration_ = 8.17

		local var_481_0 = {
			ja = 8.166,
			ko = 7.8,
			zh = 7.8,
			en = 8.066
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play103903120(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_484_1 = 0
			local var_484_2 = 0.825

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_3 = arg_481_1:FormatText(StoryNameCfg[9].name)

				arg_481_1.leftNameTxt_.text = var_484_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_4 = arg_481_1:GetWordFromCfg(103903119)
				local var_484_5 = arg_481_1:FormatText(var_484_4.content)

				arg_481_1.text_.text = var_484_5

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_6 = 33
				local var_484_7 = utf8.len(var_484_5)
				local var_484_8 = var_484_6 <= 0 and var_484_2 or var_484_2 * (var_484_7 / var_484_6)

				if var_484_8 > 0 and var_484_2 < var_484_8 then
					arg_481_1.talkMaxDuration = var_484_8

					if var_484_8 + var_484_1 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_8 + var_484_1
					end
				end

				arg_481_1.text_.text = var_484_5
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb") ~= 0 then
					local var_484_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb") / 1000

					if var_484_9 + var_484_1 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_9 + var_484_1
					end

					if var_484_4.prefab_name ~= "" and arg_481_1.actors_[var_484_4.prefab_name] ~= nil then
						local var_484_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_4.prefab_name].transform, "story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb")

						arg_481_1:RecordAudio("103903119", var_484_10)
						arg_481_1:RecordAudio("103903119", var_484_10)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_11 = math.max(var_484_2, arg_481_1.talkMaxDuration)

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_11 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_1) / var_484_11

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_1 + var_484_11 and arg_481_1.time_ < var_484_1 + var_484_11 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play103903120 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 103903120
		arg_485_1.duration_ = 8.53

		local var_485_0 = {
			ja = 8.533,
			ko = 4.366,
			zh = 4.366,
			en = 3.866
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play103903121(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action472")
			end

			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_488_2 = 0
			local var_488_3 = 0.55

			if var_488_2 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_4 = arg_485_1:FormatText(StoryNameCfg[9].name)

				arg_485_1.leftNameTxt_.text = var_488_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_5 = arg_485_1:GetWordFromCfg(103903120)
				local var_488_6 = arg_485_1:FormatText(var_488_5.content)

				arg_485_1.text_.text = var_488_6

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 22
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

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb") ~= 0 then
					local var_488_10 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb") / 1000

					if var_488_10 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_10 + var_488_2
					end

					if var_488_5.prefab_name ~= "" and arg_485_1.actors_[var_488_5.prefab_name] ~= nil then
						local var_488_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_5.prefab_name].transform, "story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb")

						arg_485_1:RecordAudio("103903120", var_488_11)
						arg_485_1:RecordAudio("103903120", var_488_11)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb")
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
	Play103903121 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 103903121
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play103903122(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["1039ui_story"]
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1039ui_story == nil then
				arg_489_1.var_.characterEffect1039ui_story = var_492_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_2 = 0.1

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 and not isNil(var_492_0) then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2

				if arg_489_1.var_.characterEffect1039ui_story and not isNil(var_492_0) then
					local var_492_4 = Mathf.Lerp(0, 0.5, var_492_3)

					arg_489_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1039ui_story.fillRatio = var_492_4
				end
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1039ui_story then
				local var_492_5 = 0.5

				arg_489_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1039ui_story.fillRatio = var_492_5
			end

			local var_492_6 = arg_489_1.bgs_.ST01.transform
			local var_492_7 = 0

			if var_492_7 < arg_489_1.time_ and arg_489_1.time_ <= var_492_7 + arg_492_0 then
				arg_489_1.var_.moveOldPosST01 = var_492_6.localPosition
			end

			local var_492_8 = 0.001

			if var_492_7 <= arg_489_1.time_ and arg_489_1.time_ < var_492_7 + var_492_8 then
				local var_492_9 = (arg_489_1.time_ - var_492_7) / var_492_8
				local var_492_10 = Vector3.New(0, -100, 10)

				var_492_6.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPosST01, var_492_10, var_492_9)
			end

			if arg_489_1.time_ >= var_492_7 + var_492_8 and arg_489_1.time_ < var_492_7 + var_492_8 + arg_492_0 then
				var_492_6.localPosition = Vector3.New(0, -100, 10)
			end

			local var_492_11 = 0

			if var_492_11 < arg_489_1.time_ and arg_489_1.time_ <= var_492_11 + arg_492_0 then
				local var_492_12 = manager.ui.mainCamera.transform.localPosition
				local var_492_13 = Vector3.New(0, 0, 10) + Vector3.New(var_492_12.x, var_492_12.y, 0)
				local var_492_14 = arg_489_1.bgs_.D04a

				var_492_14.transform.localPosition = var_492_13
				var_492_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_492_15 = var_492_14:GetComponent("SpriteRenderer")

				if var_492_15 and var_492_15.sprite then
					local var_492_16 = (var_492_14.transform.localPosition - var_492_12).z
					local var_492_17 = manager.ui.mainCameraCom_
					local var_492_18 = 2 * var_492_16 * Mathf.Tan(var_492_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_492_19 = var_492_18 * var_492_17.aspect
					local var_492_20 = var_492_15.sprite.bounds.size.x
					local var_492_21 = var_492_15.sprite.bounds.size.y
					local var_492_22 = var_492_19 / var_492_20
					local var_492_23 = var_492_18 / var_492_21
					local var_492_24 = var_492_23 < var_492_22 and var_492_22 or var_492_23

					var_492_14.transform.localScale = Vector3.New(var_492_24, var_492_24, 0)
				end

				for iter_492_0, iter_492_1 in pairs(arg_489_1.bgs_) do
					if iter_492_0 ~= "D04a" then
						iter_492_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_492_25 = arg_489_1.actors_["1039ui_story"].transform
			local var_492_26 = 0

			if var_492_26 < arg_489_1.time_ and arg_489_1.time_ <= var_492_26 + arg_492_0 then
				arg_489_1.var_.moveOldPos1039ui_story = var_492_25.localPosition
			end

			local var_492_27 = 0.001

			if var_492_26 <= arg_489_1.time_ and arg_489_1.time_ < var_492_26 + var_492_27 then
				local var_492_28 = (arg_489_1.time_ - var_492_26) / var_492_27
				local var_492_29 = Vector3.New(10, -1.06, -5.3)

				var_492_25.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1039ui_story, var_492_29, var_492_28)

				local var_492_30 = manager.ui.mainCamera.transform.position - var_492_25.position

				var_492_25.forward = Vector3.New(var_492_30.x, var_492_30.y, var_492_30.z)

				local var_492_31 = var_492_25.localEulerAngles

				var_492_31.z = 0
				var_492_31.x = 0
				var_492_25.localEulerAngles = var_492_31
			end

			if arg_489_1.time_ >= var_492_26 + var_492_27 and arg_489_1.time_ < var_492_26 + var_492_27 + arg_492_0 then
				var_492_25.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_492_32 = manager.ui.mainCamera.transform.position - var_492_25.position

				var_492_25.forward = Vector3.New(var_492_32.x, var_492_32.y, var_492_32.z)

				local var_492_33 = var_492_25.localEulerAngles

				var_492_33.z = 0
				var_492_33.x = 0
				var_492_25.localEulerAngles = var_492_33
			end

			local var_492_34 = 0
			local var_492_35 = 0.65

			if var_492_34 < arg_489_1.time_ and arg_489_1.time_ <= var_492_34 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_36 = arg_489_1:FormatText(StoryNameCfg[7].name)

				arg_489_1.leftNameTxt_.text = var_492_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_37 = arg_489_1:GetWordFromCfg(103903121)
				local var_492_38 = arg_489_1:FormatText(var_492_37.content)

				arg_489_1.text_.text = var_492_38

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_39 = 26
				local var_492_40 = utf8.len(var_492_38)
				local var_492_41 = var_492_39 <= 0 and var_492_35 or var_492_35 * (var_492_40 / var_492_39)

				if var_492_41 > 0 and var_492_35 < var_492_41 then
					arg_489_1.talkMaxDuration = var_492_41

					if var_492_41 + var_492_34 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_41 + var_492_34
					end
				end

				arg_489_1.text_.text = var_492_38
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_42 = math.max(var_492_35, arg_489_1.talkMaxDuration)

			if var_492_34 <= arg_489_1.time_ and arg_489_1.time_ < var_492_34 + var_492_42 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_34) / var_492_42

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_34 + var_492_42 and arg_489_1.time_ < var_492_34 + var_492_42 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST01",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play103903122 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 103903122
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play103903123(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0
			local var_496_1 = 0.575

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_2 = arg_493_1:FormatText(StoryNameCfg[7].name)

				arg_493_1.leftNameTxt_.text = var_496_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_3 = arg_493_1:GetWordFromCfg(103903122)
				local var_496_4 = arg_493_1:FormatText(var_496_3.content)

				arg_493_1.text_.text = var_496_4

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_5 = 23
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
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_8 = math.max(var_496_1, arg_493_1.talkMaxDuration)

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_8 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_0) / var_496_8

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_0 + var_496_8 and arg_493_1.time_ < var_496_0 + var_496_8 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play103903123 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 103903123
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play103903124(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0
			local var_500_1 = 0.2

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_2 = arg_497_1:GetWordFromCfg(103903123)
				local var_500_3 = arg_497_1:FormatText(var_500_2.content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_4 = 8
				local var_500_5 = utf8.len(var_500_3)
				local var_500_6 = var_500_4 <= 0 and var_500_1 or var_500_1 * (var_500_5 / var_500_4)

				if var_500_6 > 0 and var_500_1 < var_500_6 then
					arg_497_1.talkMaxDuration = var_500_6

					if var_500_6 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_6 + var_500_0
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_7 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_0 <= arg_497_1.time_ and arg_497_1.time_ < var_500_0 + var_500_7 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_0) / var_500_7

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_0 + var_500_7 and arg_497_1.time_ < var_500_0 + var_500_7 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play103903124 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 103903124
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play103903125(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["1039ui_story"]
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect1039ui_story == nil then
				arg_501_1.var_.characterEffect1039ui_story = var_504_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.1

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 and not isNil(var_504_0) then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2

				if arg_501_1.var_.characterEffect1039ui_story and not isNil(var_504_0) then
					arg_501_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect1039ui_story then
				arg_501_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_504_4 = 0
			local var_504_5 = 0.7

			if var_504_4 < arg_501_1.time_ and arg_501_1.time_ <= var_504_4 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_6 = arg_501_1:GetWordFromCfg(103903124)
				local var_504_7 = arg_501_1:FormatText(var_504_6.content)

				arg_501_1.text_.text = var_504_7

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_8 = 28
				local var_504_9 = utf8.len(var_504_7)
				local var_504_10 = var_504_8 <= 0 and var_504_5 or var_504_5 * (var_504_9 / var_504_8)

				if var_504_10 > 0 and var_504_5 < var_504_10 then
					arg_501_1.talkMaxDuration = var_504_10

					if var_504_10 + var_504_4 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_10 + var_504_4
					end
				end

				arg_501_1.text_.text = var_504_7
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_11 = math.max(var_504_5, arg_501_1.talkMaxDuration)

			if var_504_4 <= arg_501_1.time_ and arg_501_1.time_ < var_504_4 + var_504_11 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_4) / var_504_11

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_4 + var_504_11 and arg_501_1.time_ < var_504_4 + var_504_11 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play103903125 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 103903125
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play103903126(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["1039ui_story"]
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1039ui_story == nil then
				arg_505_1.var_.characterEffect1039ui_story = var_508_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_2 = 0.1

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 and not isNil(var_508_0) then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2

				if arg_505_1.var_.characterEffect1039ui_story and not isNil(var_508_0) then
					local var_508_4 = Mathf.Lerp(0, 0.5, var_508_3)

					arg_505_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_505_1.var_.characterEffect1039ui_story.fillRatio = var_508_4
				end
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1039ui_story then
				local var_508_5 = 0.5

				arg_505_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_505_1.var_.characterEffect1039ui_story.fillRatio = var_508_5
			end

			local var_508_6 = 0
			local var_508_7 = 0.525

			if var_508_6 < arg_505_1.time_ and arg_505_1.time_ <= var_508_6 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_8 = arg_505_1:GetWordFromCfg(103903125)
				local var_508_9 = arg_505_1:FormatText(var_508_8.content)

				arg_505_1.text_.text = var_508_9

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_10 = 21
				local var_508_11 = utf8.len(var_508_9)
				local var_508_12 = var_508_10 <= 0 and var_508_7 or var_508_7 * (var_508_11 / var_508_10)

				if var_508_12 > 0 and var_508_7 < var_508_12 then
					arg_505_1.talkMaxDuration = var_508_12

					if var_508_12 + var_508_6 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_12 + var_508_6
					end
				end

				arg_505_1.text_.text = var_508_9
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_13 = math.max(var_508_7, arg_505_1.talkMaxDuration)

			if var_508_6 <= arg_505_1.time_ and arg_505_1.time_ < var_508_6 + var_508_13 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_6) / var_508_13

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_6 + var_508_13 and arg_505_1.time_ < var_508_6 + var_508_13 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play103903126 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 103903126
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play103903127(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0
			local var_512_1 = 1.1

			if var_512_0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_2 = arg_509_1:GetWordFromCfg(103903126)
				local var_512_3 = arg_509_1:FormatText(var_512_2.content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_4 = 39
				local var_512_5 = utf8.len(var_512_3)
				local var_512_6 = var_512_4 <= 0 and var_512_1 or var_512_1 * (var_512_5 / var_512_4)

				if var_512_6 > 0 and var_512_1 < var_512_6 then
					arg_509_1.talkMaxDuration = var_512_6

					if var_512_6 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_6 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_7 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_7 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_7

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_7 and arg_509_1.time_ < var_512_0 + var_512_7 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play103903127 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 103903127
		arg_513_1.duration_ = 6.93

		local var_513_0 = {
			ja = 6.933,
			ko = 4.366,
			zh = 4.366,
			en = 4.933
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play103903128(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = arg_513_1.actors_["1039ui_story"]
			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect1039ui_story == nil then
				arg_513_1.var_.characterEffect1039ui_story = var_516_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_2 = 0.1

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_2 and not isNil(var_516_0) then
				local var_516_3 = (arg_513_1.time_ - var_516_1) / var_516_2

				if arg_513_1.var_.characterEffect1039ui_story and not isNil(var_516_0) then
					arg_513_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= var_516_1 + var_516_2 and arg_513_1.time_ < var_516_1 + var_516_2 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.characterEffect1039ui_story then
				arg_513_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_516_4 = arg_513_1.actors_["1039ui_story"].transform
			local var_516_5 = 0

			if var_516_5 < arg_513_1.time_ and arg_513_1.time_ <= var_516_5 + arg_516_0 then
				arg_513_1.var_.moveOldPos1039ui_story = var_516_4.localPosition
			end

			local var_516_6 = 0.001

			if var_516_5 <= arg_513_1.time_ and arg_513_1.time_ < var_516_5 + var_516_6 then
				local var_516_7 = (arg_513_1.time_ - var_516_5) / var_516_6
				local var_516_8 = Vector3.New(0, -1.06, -5.3)

				var_516_4.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos1039ui_story, var_516_8, var_516_7)

				local var_516_9 = manager.ui.mainCamera.transform.position - var_516_4.position

				var_516_4.forward = Vector3.New(var_516_9.x, var_516_9.y, var_516_9.z)

				local var_516_10 = var_516_4.localEulerAngles

				var_516_10.z = 0
				var_516_10.x = 0
				var_516_4.localEulerAngles = var_516_10
			end

			if arg_513_1.time_ >= var_516_5 + var_516_6 and arg_513_1.time_ < var_516_5 + var_516_6 + arg_516_0 then
				var_516_4.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_516_11 = manager.ui.mainCamera.transform.position - var_516_4.position

				var_516_4.forward = Vector3.New(var_516_11.x, var_516_11.y, var_516_11.z)

				local var_516_12 = var_516_4.localEulerAngles

				var_516_12.z = 0
				var_516_12.x = 0
				var_516_4.localEulerAngles = var_516_12
			end

			local var_516_13 = 0

			if var_516_13 < arg_513_1.time_ and arg_513_1.time_ <= var_516_13 + arg_516_0 then
				arg_513_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_516_14 = 0

			if var_516_14 < arg_513_1.time_ and arg_513_1.time_ <= var_516_14 + arg_516_0 then
				arg_513_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_516_15 = 0
			local var_516_16 = 0.575

			if var_516_15 < arg_513_1.time_ and arg_513_1.time_ <= var_516_15 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_17 = arg_513_1:FormatText(StoryNameCfg[9].name)

				arg_513_1.leftNameTxt_.text = var_516_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_18 = arg_513_1:GetWordFromCfg(103903127)
				local var_516_19 = arg_513_1:FormatText(var_516_18.content)

				arg_513_1.text_.text = var_516_19

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_20 = 23
				local var_516_21 = utf8.len(var_516_19)
				local var_516_22 = var_516_20 <= 0 and var_516_16 or var_516_16 * (var_516_21 / var_516_20)

				if var_516_22 > 0 and var_516_16 < var_516_22 then
					arg_513_1.talkMaxDuration = var_516_22

					if var_516_22 + var_516_15 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_22 + var_516_15
					end
				end

				arg_513_1.text_.text = var_516_19
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb") ~= 0 then
					local var_516_23 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb") / 1000

					if var_516_23 + var_516_15 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_23 + var_516_15
					end

					if var_516_18.prefab_name ~= "" and arg_513_1.actors_[var_516_18.prefab_name] ~= nil then
						local var_516_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_18.prefab_name].transform, "story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb")

						arg_513_1:RecordAudio("103903127", var_516_24)
						arg_513_1:RecordAudio("103903127", var_516_24)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_25 = math.max(var_516_16, arg_513_1.talkMaxDuration)

			if var_516_15 <= arg_513_1.time_ and arg_513_1.time_ < var_516_15 + var_516_25 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_15) / var_516_25

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_15 + var_516_25 and arg_513_1.time_ < var_516_15 + var_516_25 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_513_1:InitPlayNodeList()
	end,
	Play103903128 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 103903128
		arg_517_1.duration_ = 9.3

		local var_517_0 = {
			ja = 9.3,
			ko = 7.166,
			zh = 7.166,
			en = 5.333
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play103903129(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_520_1 = 0
			local var_520_2 = 0.925

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_3 = arg_517_1:FormatText(StoryNameCfg[9].name)

				arg_517_1.leftNameTxt_.text = var_520_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_4 = arg_517_1:GetWordFromCfg(103903128)
				local var_520_5 = arg_517_1:FormatText(var_520_4.content)

				arg_517_1.text_.text = var_520_5

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_6 = 37
				local var_520_7 = utf8.len(var_520_5)
				local var_520_8 = var_520_6 <= 0 and var_520_2 or var_520_2 * (var_520_7 / var_520_6)

				if var_520_8 > 0 and var_520_2 < var_520_8 then
					arg_517_1.talkMaxDuration = var_520_8

					if var_520_8 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_8 + var_520_1
					end
				end

				arg_517_1.text_.text = var_520_5
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb") ~= 0 then
					local var_520_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb") / 1000

					if var_520_9 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_9 + var_520_1
					end

					if var_520_4.prefab_name ~= "" and arg_517_1.actors_[var_520_4.prefab_name] ~= nil then
						local var_520_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_4.prefab_name].transform, "story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb")

						arg_517_1:RecordAudio("103903128", var_520_10)
						arg_517_1:RecordAudio("103903128", var_520_10)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_11 = math.max(var_520_2, arg_517_1.talkMaxDuration)

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_11 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_1) / var_520_11

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_1 + var_520_11 and arg_517_1.time_ < var_520_1 + var_520_11 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play103903129 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 103903129
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play103903130(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["1039ui_story"]
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect1039ui_story == nil then
				arg_521_1.var_.characterEffect1039ui_story = var_524_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.1

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 and not isNil(var_524_0) then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2

				if arg_521_1.var_.characterEffect1039ui_story and not isNil(var_524_0) then
					local var_524_4 = Mathf.Lerp(0, 0.5, var_524_3)

					arg_521_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1039ui_story.fillRatio = var_524_4
				end
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect1039ui_story then
				local var_524_5 = 0.5

				arg_521_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1039ui_story.fillRatio = var_524_5
			end

			local var_524_6 = 0
			local var_524_7 = 0.9

			if var_524_6 < arg_521_1.time_ and arg_521_1.time_ <= var_524_6 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_8 = arg_521_1:FormatText(StoryNameCfg[7].name)

				arg_521_1.leftNameTxt_.text = var_524_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_9 = arg_521_1:GetWordFromCfg(103903129)
				local var_524_10 = arg_521_1:FormatText(var_524_9.content)

				arg_521_1.text_.text = var_524_10

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_11 = 36
				local var_524_12 = utf8.len(var_524_10)
				local var_524_13 = var_524_11 <= 0 and var_524_7 or var_524_7 * (var_524_12 / var_524_11)

				if var_524_13 > 0 and var_524_7 < var_524_13 then
					arg_521_1.talkMaxDuration = var_524_13

					if var_524_13 + var_524_6 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_13 + var_524_6
					end
				end

				arg_521_1.text_.text = var_524_10
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_14 = math.max(var_524_7, arg_521_1.talkMaxDuration)

			if var_524_6 <= arg_521_1.time_ and arg_521_1.time_ < var_524_6 + var_524_14 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_6) / var_524_14

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_6 + var_524_14 and arg_521_1.time_ < var_524_6 + var_524_14 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play103903130 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 103903130
		arg_525_1.duration_ = 7.07

		local var_525_0 = {
			ja = 7.066,
			ko = 4.366,
			zh = 4.366,
			en = 6.166
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play103903131(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["1039ui_story"]
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect1039ui_story == nil then
				arg_525_1.var_.characterEffect1039ui_story = var_528_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_2 = 0.1

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_2 and not isNil(var_528_0) then
				local var_528_3 = (arg_525_1.time_ - var_528_1) / var_528_2

				if arg_525_1.var_.characterEffect1039ui_story and not isNil(var_528_0) then
					arg_525_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= var_528_1 + var_528_2 and arg_525_1.time_ < var_528_1 + var_528_2 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect1039ui_story then
				arg_525_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_528_4 = 0

			if var_528_4 < arg_525_1.time_ and arg_525_1.time_ <= var_528_4 + arg_528_0 then
				arg_525_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			local var_528_5 = 0

			if var_528_5 < arg_525_1.time_ and arg_525_1.time_ <= var_528_5 + arg_528_0 then
				arg_525_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_528_6 = 0
			local var_528_7 = 0.425

			if var_528_6 < arg_525_1.time_ and arg_525_1.time_ <= var_528_6 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_8 = arg_525_1:FormatText(StoryNameCfg[9].name)

				arg_525_1.leftNameTxt_.text = var_528_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_9 = arg_525_1:GetWordFromCfg(103903130)
				local var_528_10 = arg_525_1:FormatText(var_528_9.content)

				arg_525_1.text_.text = var_528_10

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_11 = 17
				local var_528_12 = utf8.len(var_528_10)
				local var_528_13 = var_528_11 <= 0 and var_528_7 or var_528_7 * (var_528_12 / var_528_11)

				if var_528_13 > 0 and var_528_7 < var_528_13 then
					arg_525_1.talkMaxDuration = var_528_13

					if var_528_13 + var_528_6 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_13 + var_528_6
					end
				end

				arg_525_1.text_.text = var_528_10
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb") ~= 0 then
					local var_528_14 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb") / 1000

					if var_528_14 + var_528_6 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_14 + var_528_6
					end

					if var_528_9.prefab_name ~= "" and arg_525_1.actors_[var_528_9.prefab_name] ~= nil then
						local var_528_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_9.prefab_name].transform, "story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb")

						arg_525_1:RecordAudio("103903130", var_528_15)
						arg_525_1:RecordAudio("103903130", var_528_15)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_16 = math.max(var_528_7, arg_525_1.talkMaxDuration)

			if var_528_6 <= arg_525_1.time_ and arg_525_1.time_ < var_528_6 + var_528_16 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_6) / var_528_16

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_6 + var_528_16 and arg_525_1.time_ < var_528_6 + var_528_16 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play103903131 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 103903131
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play103903132(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0
			local var_532_1 = 0.275

			if var_532_0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_2 = arg_529_1:GetWordFromCfg(103903131)
				local var_532_3 = arg_529_1:FormatText(var_532_2.content)

				arg_529_1.text_.text = var_532_3

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_4 = 11
				local var_532_5 = utf8.len(var_532_3)
				local var_532_6 = var_532_4 <= 0 and var_532_1 or var_532_1 * (var_532_5 / var_532_4)

				if var_532_6 > 0 and var_532_1 < var_532_6 then
					arg_529_1.talkMaxDuration = var_532_6

					if var_532_6 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_6 + var_532_0
					end
				end

				arg_529_1.text_.text = var_532_3
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_7 = math.max(var_532_1, arg_529_1.talkMaxDuration)

			if var_532_0 <= arg_529_1.time_ and arg_529_1.time_ < var_532_0 + var_532_7 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_0) / var_532_7

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_0 + var_532_7 and arg_529_1.time_ < var_532_0 + var_532_7 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play103903132 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 103903132
		arg_533_1.duration_ = 5.37

		local var_533_0 = {
			ja = 5.366,
			ko = 3.4,
			zh = 3.4,
			en = 1.5
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play103903133(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0

			if var_536_0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				arg_533_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_536_1 = 0
			local var_536_2 = 0.275

			if var_536_1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_3 = arg_533_1:FormatText(StoryNameCfg[9].name)

				arg_533_1.leftNameTxt_.text = var_536_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_4 = arg_533_1:GetWordFromCfg(103903132)
				local var_536_5 = arg_533_1:FormatText(var_536_4.content)

				arg_533_1.text_.text = var_536_5

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_6 = 11
				local var_536_7 = utf8.len(var_536_5)
				local var_536_8 = var_536_6 <= 0 and var_536_2 or var_536_2 * (var_536_7 / var_536_6)

				if var_536_8 > 0 and var_536_2 < var_536_8 then
					arg_533_1.talkMaxDuration = var_536_8

					if var_536_8 + var_536_1 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_8 + var_536_1
					end
				end

				arg_533_1.text_.text = var_536_5
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb") ~= 0 then
					local var_536_9 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb") / 1000

					if var_536_9 + var_536_1 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_9 + var_536_1
					end

					if var_536_4.prefab_name ~= "" and arg_533_1.actors_[var_536_4.prefab_name] ~= nil then
						local var_536_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_4.prefab_name].transform, "story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb")

						arg_533_1:RecordAudio("103903132", var_536_10)
						arg_533_1:RecordAudio("103903132", var_536_10)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_11 = math.max(var_536_2, arg_533_1.talkMaxDuration)

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_11 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_1) / var_536_11

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_1 + var_536_11 and arg_533_1.time_ < var_536_1 + var_536_11 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play103903133 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 103903133
		arg_537_1.duration_ = 0.1

		SetActive(arg_537_1.tipsGo_, true)

		arg_537_1.tipsText_.text = StoryTipsCfg[103901].name

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"

			SetActive(arg_537_1.choicesGo_, true)

			for iter_538_0, iter_538_1 in ipairs(arg_537_1.choices_) do
				local var_538_0 = iter_538_0 <= 2

				SetActive(iter_538_1.go, var_538_0)
			end

			arg_537_1.choices_[1].txt.text = arg_537_1:FormatText(StoryChoiceCfg[76].name)
			arg_537_1.choices_[2].txt.text = arg_537_1:FormatText(StoryChoiceCfg[77].name)
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				PlayerAction.UseStoryTrigger(1039012, 210390103, 103903133, 1)
				arg_537_0:Play103903134(arg_537_1)
			end

			if arg_539_0 == 2 then
				arg_537_0:Play103903137(arg_537_1)
			end

			arg_537_1:RecordChoiceLog(103903133, 76, 77)
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = arg_537_1.actors_["1039ui_story"]
			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.characterEffect1039ui_story == nil then
				arg_537_1.var_.characterEffect1039ui_story = var_540_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_2 = 0.1

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_2 and not isNil(var_540_0) then
				local var_540_3 = (arg_537_1.time_ - var_540_1) / var_540_2

				if arg_537_1.var_.characterEffect1039ui_story and not isNil(var_540_0) then
					local var_540_4 = Mathf.Lerp(0, 0.5, var_540_3)

					arg_537_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_537_1.var_.characterEffect1039ui_story.fillRatio = var_540_4
				end
			end

			if arg_537_1.time_ >= var_540_1 + var_540_2 and arg_537_1.time_ < var_540_1 + var_540_2 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.characterEffect1039ui_story then
				local var_540_5 = 0.5

				arg_537_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_537_1.var_.characterEffect1039ui_story.fillRatio = var_540_5
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play103903134 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 103903134
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play103903135(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["1039ui_story"].transform
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.var_.moveOldPos1039ui_story = var_544_0.localPosition
			end

			local var_544_2 = 0.001

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_2 then
				local var_544_3 = (arg_541_1.time_ - var_544_1) / var_544_2
				local var_544_4 = Vector3.New(10, -1.06, -5.3)

				var_544_0.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1039ui_story, var_544_4, var_544_3)

				local var_544_5 = manager.ui.mainCamera.transform.position - var_544_0.position

				var_544_0.forward = Vector3.New(var_544_5.x, var_544_5.y, var_544_5.z)

				local var_544_6 = var_544_0.localEulerAngles

				var_544_6.z = 0
				var_544_6.x = 0
				var_544_0.localEulerAngles = var_544_6
			end

			if arg_541_1.time_ >= var_544_1 + var_544_2 and arg_541_1.time_ < var_544_1 + var_544_2 + arg_544_0 then
				var_544_0.localPosition = Vector3.New(10, -1.06, -5.3)

				local var_544_7 = manager.ui.mainCamera.transform.position - var_544_0.position

				var_544_0.forward = Vector3.New(var_544_7.x, var_544_7.y, var_544_7.z)

				local var_544_8 = var_544_0.localEulerAngles

				var_544_8.z = 0
				var_544_8.x = 0
				var_544_0.localEulerAngles = var_544_8
			end

			local var_544_9 = 0
			local var_544_10 = 0.225

			if var_544_9 < arg_541_1.time_ and arg_541_1.time_ <= var_544_9 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_11 = arg_541_1:GetWordFromCfg(103903134)
				local var_544_12 = arg_541_1:FormatText(var_544_11.content)

				arg_541_1.text_.text = var_544_12

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_13 = 9
				local var_544_14 = utf8.len(var_544_12)
				local var_544_15 = var_544_13 <= 0 and var_544_10 or var_544_10 * (var_544_14 / var_544_13)

				if var_544_15 > 0 and var_544_10 < var_544_15 then
					arg_541_1.talkMaxDuration = var_544_15

					if var_544_15 + var_544_9 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_15 + var_544_9
					end
				end

				arg_541_1.text_.text = var_544_12
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_16 = math.max(var_544_10, arg_541_1.talkMaxDuration)

			if var_544_9 <= arg_541_1.time_ and arg_541_1.time_ < var_544_9 + var_544_16 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_9) / var_544_16

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_9 + var_544_16 and arg_541_1.time_ < var_544_9 + var_544_16 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play103903135 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 103903135
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play103903136(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0
			local var_548_1 = 0.825

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_2 = arg_545_1:GetWordFromCfg(103903135)
				local var_548_3 = arg_545_1:FormatText(var_548_2.content)

				arg_545_1.text_.text = var_548_3

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_4 = 33
				local var_548_5 = utf8.len(var_548_3)
				local var_548_6 = var_548_4 <= 0 and var_548_1 or var_548_1 * (var_548_5 / var_548_4)

				if var_548_6 > 0 and var_548_1 < var_548_6 then
					arg_545_1.talkMaxDuration = var_548_6

					if var_548_6 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_6 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_3
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_7 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_7 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_7

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_7 and arg_545_1.time_ < var_548_0 + var_548_7 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play103903136 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 103903136
		arg_549_1.duration_ = 7.15

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play103903142(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action468")
			end

			local var_552_1 = 0
			local var_552_2 = 0.325

			if var_552_1 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_3 = arg_549_1:FormatText(StoryNameCfg[7].name)

				arg_549_1.leftNameTxt_.text = var_552_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_4 = arg_549_1:GetWordFromCfg(103903136)
				local var_552_5 = arg_549_1:FormatText(var_552_4.content)

				arg_549_1.text_.text = var_552_5

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_6 = 13
				local var_552_7 = utf8.len(var_552_5)
				local var_552_8 = var_552_6 <= 0 and var_552_2 or var_552_2 * (var_552_7 / var_552_6)

				if var_552_8 > 0 and var_552_2 < var_552_8 then
					arg_549_1.talkMaxDuration = var_552_8

					if var_552_8 + var_552_1 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_8 + var_552_1
					end
				end

				arg_549_1.text_.text = var_552_5
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_9 = math.max(var_552_2, arg_549_1.talkMaxDuration)

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_9 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_1) / var_552_9

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_1 + var_552_9 and arg_549_1.time_ < var_552_1 + var_552_9 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play103903142 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 103903142
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play103903143(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["1039ui_story"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1039ui_story == nil then
				arg_553_1.var_.characterEffect1039ui_story = var_556_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.1

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.characterEffect1039ui_story and not isNil(var_556_0) then
					local var_556_4 = Mathf.Lerp(0, 0.5, var_556_3)

					arg_553_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1039ui_story.fillRatio = var_556_4
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1039ui_story then
				local var_556_5 = 0.5

				arg_553_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1039ui_story.fillRatio = var_556_5
			end

			local var_556_6 = 0
			local var_556_7 = 0.7

			if var_556_6 < arg_553_1.time_ and arg_553_1.time_ <= var_556_6 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_8 = arg_553_1:FormatText(StoryNameCfg[7].name)

				arg_553_1.leftNameTxt_.text = var_556_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_9 = arg_553_1:GetWordFromCfg(103903142)
				local var_556_10 = arg_553_1:FormatText(var_556_9.content)

				arg_553_1.text_.text = var_556_10

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_11 = 28
				local var_556_12 = utf8.len(var_556_10)
				local var_556_13 = var_556_11 <= 0 and var_556_7 or var_556_7 * (var_556_12 / var_556_11)

				if var_556_13 > 0 and var_556_7 < var_556_13 then
					arg_553_1.talkMaxDuration = var_556_13

					if var_556_13 + var_556_6 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_13 + var_556_6
					end
				end

				arg_553_1.text_.text = var_556_10
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_14 = math.max(var_556_7, arg_553_1.talkMaxDuration)

			if var_556_6 <= arg_553_1.time_ and arg_553_1.time_ < var_556_6 + var_556_14 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_6) / var_556_14

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_6 + var_556_14 and arg_553_1.time_ < var_556_6 + var_556_14 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play103903143 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 103903143
		arg_557_1.duration_ = 7.5

		local var_557_0 = {
			ja = 7.5,
			ko = 3.466,
			zh = 3.466,
			en = 4.133
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play103903144(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["1039ui_story"]
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1039ui_story == nil then
				arg_557_1.var_.characterEffect1039ui_story = var_560_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_2 = 0.1

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 and not isNil(var_560_0) then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2

				if arg_557_1.var_.characterEffect1039ui_story and not isNil(var_560_0) then
					arg_557_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1039ui_story then
				arg_557_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_560_4 = arg_557_1.actors_["1039ui_story"].transform
			local var_560_5 = 0

			if var_560_5 < arg_557_1.time_ and arg_557_1.time_ <= var_560_5 + arg_560_0 then
				arg_557_1.var_.moveOldPos1039ui_story = var_560_4.localPosition
			end

			local var_560_6 = 0.001

			if var_560_5 <= arg_557_1.time_ and arg_557_1.time_ < var_560_5 + var_560_6 then
				local var_560_7 = (arg_557_1.time_ - var_560_5) / var_560_6
				local var_560_8 = Vector3.New(0, -1.06, -5.3)

				var_560_4.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1039ui_story, var_560_8, var_560_7)

				local var_560_9 = manager.ui.mainCamera.transform.position - var_560_4.position

				var_560_4.forward = Vector3.New(var_560_9.x, var_560_9.y, var_560_9.z)

				local var_560_10 = var_560_4.localEulerAngles

				var_560_10.z = 0
				var_560_10.x = 0
				var_560_4.localEulerAngles = var_560_10
			end

			if arg_557_1.time_ >= var_560_5 + var_560_6 and arg_557_1.time_ < var_560_5 + var_560_6 + arg_560_0 then
				var_560_4.localPosition = Vector3.New(0, -1.06, -5.3)

				local var_560_11 = manager.ui.mainCamera.transform.position - var_560_4.position

				var_560_4.forward = Vector3.New(var_560_11.x, var_560_11.y, var_560_11.z)

				local var_560_12 = var_560_4.localEulerAngles

				var_560_12.z = 0
				var_560_12.x = 0
				var_560_4.localEulerAngles = var_560_12
			end

			local var_560_13 = 0

			if var_560_13 < arg_557_1.time_ and arg_557_1.time_ <= var_560_13 + arg_560_0 then
				arg_557_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action484")
			end

			local var_560_14 = 0

			if var_560_14 < arg_557_1.time_ and arg_557_1.time_ <= var_560_14 + arg_560_0 then
				arg_557_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_560_15 = 0
			local var_560_16 = 0.45

			if var_560_15 < arg_557_1.time_ and arg_557_1.time_ <= var_560_15 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_17 = arg_557_1:FormatText(StoryNameCfg[9].name)

				arg_557_1.leftNameTxt_.text = var_560_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_18 = arg_557_1:GetWordFromCfg(103903143)
				local var_560_19 = arg_557_1:FormatText(var_560_18.content)

				arg_557_1.text_.text = var_560_19

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_20 = 18
				local var_560_21 = utf8.len(var_560_19)
				local var_560_22 = var_560_20 <= 0 and var_560_16 or var_560_16 * (var_560_21 / var_560_20)

				if var_560_22 > 0 and var_560_16 < var_560_22 then
					arg_557_1.talkMaxDuration = var_560_22

					if var_560_22 + var_560_15 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_22 + var_560_15
					end
				end

				arg_557_1.text_.text = var_560_19
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb") ~= 0 then
					local var_560_23 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb") / 1000

					if var_560_23 + var_560_15 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_23 + var_560_15
					end

					if var_560_18.prefab_name ~= "" and arg_557_1.actors_[var_560_18.prefab_name] ~= nil then
						local var_560_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_18.prefab_name].transform, "story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb")

						arg_557_1:RecordAudio("103903143", var_560_24)
						arg_557_1:RecordAudio("103903143", var_560_24)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_25 = math.max(var_560_16, arg_557_1.talkMaxDuration)

			if var_560_15 <= arg_557_1.time_ and arg_557_1.time_ < var_560_15 + var_560_25 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_15) / var_560_25

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_15 + var_560_25 and arg_557_1.time_ < var_560_15 + var_560_25 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play103903144 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 103903144
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play103903145(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0
			local var_564_1 = 0.475

			if var_564_0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_2 = arg_561_1:GetWordFromCfg(103903144)
				local var_564_3 = arg_561_1:FormatText(var_564_2.content)

				arg_561_1.text_.text = var_564_3

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_4 = 19
				local var_564_5 = utf8.len(var_564_3)
				local var_564_6 = var_564_4 <= 0 and var_564_1 or var_564_1 * (var_564_5 / var_564_4)

				if var_564_6 > 0 and var_564_1 < var_564_6 then
					arg_561_1.talkMaxDuration = var_564_6

					if var_564_6 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_6 + var_564_0
					end
				end

				arg_561_1.text_.text = var_564_3
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_7 = math.max(var_564_1, arg_561_1.talkMaxDuration)

			if var_564_0 <= arg_561_1.time_ and arg_561_1.time_ < var_564_0 + var_564_7 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_0) / var_564_7

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_0 + var_564_7 and arg_561_1.time_ < var_564_0 + var_564_7 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play103903145 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 103903145
		arg_565_1.duration_ = 4.83

		local var_565_0 = {
			ja = 4.833,
			ko = 3.733,
			zh = 3.733,
			en = 4.666
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
			arg_565_1.auto_ = false
		end

		function arg_565_1.playNext_(arg_567_0)
			arg_565_1.onStoryFinished_()
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0
			local var_568_1 = 1

			if var_568_0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_0 + arg_568_0 then
				local var_568_2 = "play"
				local var_568_3 = "music"

				arg_565_1:AudioAction(var_568_2, var_568_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_568_4 = ""
				local var_568_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_568_5 ~= "" then
					if arg_565_1.bgmTxt_.text ~= var_568_5 and arg_565_1.bgmTxt_.text ~= "" then
						if arg_565_1.bgmTxt2_.text ~= "" then
							arg_565_1.bgmTxt_.text = arg_565_1.bgmTxt2_.text
						end

						arg_565_1.bgmTxt2_.text = var_568_5

						arg_565_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_565_1.bgmTxt_.text = var_568_5
						arg_565_1.bgmTxt2_.text = var_568_5
					end

					if arg_565_1.bgmTimer then
						arg_565_1.bgmTimer:Stop()

						arg_565_1.bgmTimer = nil
					end

					if arg_565_1.settingData.show_music_name == 1 then
						arg_565_1.musicController:SetSelectedState("show")
						arg_565_1.musicAnimator_:Play("open", 0, 0)

						if arg_565_1.settingData.music_time ~= 0 then
							arg_565_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_565_1.settingData.music_time), function()
								if arg_565_1 == nil or isNil(arg_565_1.bgmTxt_) then
									return
								end

								arg_565_1.musicController:SetSelectedState("hide")
								arg_565_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_568_6 = 0

			if var_568_6 < arg_565_1.time_ and arg_565_1.time_ <= var_568_6 + arg_568_0 then
				arg_565_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action442")
			end

			local var_568_7 = 0

			if var_568_7 < arg_565_1.time_ and arg_565_1.time_ <= var_568_7 + arg_568_0 then
				arg_565_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_568_8 = 0
			local var_568_9 = 0.425

			if var_568_8 < arg_565_1.time_ and arg_565_1.time_ <= var_568_8 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_10 = arg_565_1:FormatText(StoryNameCfg[9].name)

				arg_565_1.leftNameTxt_.text = var_568_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_11 = arg_565_1:GetWordFromCfg(103903145)
				local var_568_12 = arg_565_1:FormatText(var_568_11.content)

				arg_565_1.text_.text = var_568_12

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_13 = 17
				local var_568_14 = utf8.len(var_568_12)
				local var_568_15 = var_568_13 <= 0 and var_568_9 or var_568_9 * (var_568_14 / var_568_13)

				if var_568_15 > 0 and var_568_9 < var_568_15 then
					arg_565_1.talkMaxDuration = var_568_15

					if var_568_15 + var_568_8 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_15 + var_568_8
					end
				end

				arg_565_1.text_.text = var_568_12
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb") ~= 0 then
					local var_568_16 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb") / 1000

					if var_568_16 + var_568_8 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_16 + var_568_8
					end

					if var_568_11.prefab_name ~= "" and arg_565_1.actors_[var_568_11.prefab_name] ~= nil then
						local var_568_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_11.prefab_name].transform, "story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb")

						arg_565_1:RecordAudio("103903145", var_568_17)
						arg_565_1:RecordAudio("103903145", var_568_17)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_18 = math.max(var_568_9, arg_565_1.talkMaxDuration)

			if var_568_8 <= arg_565_1.time_ and arg_565_1.time_ < var_568_8 + var_568_18 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_8) / var_568_18

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_8 + var_568_18 and arg_565_1.time_ < var_568_8 + var_568_18 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play103903137 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 103903137
		arg_570_1.duration_ = 3.6

		local var_570_0 = {
			ja = 2.266,
			ko = 2.533,
			zh = 2.533,
			en = 3.6
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play103903138(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = arg_570_1.actors_["1039ui_story"]
			local var_573_1 = 0

			if var_573_1 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1039ui_story == nil then
				arg_570_1.var_.characterEffect1039ui_story = var_573_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_2 = 0.1

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_2 and not isNil(var_573_0) then
				local var_573_3 = (arg_570_1.time_ - var_573_1) / var_573_2

				if arg_570_1.var_.characterEffect1039ui_story and not isNil(var_573_0) then
					arg_570_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_570_1.time_ >= var_573_1 + var_573_2 and arg_570_1.time_ < var_573_1 + var_573_2 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1039ui_story then
				arg_570_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_573_4 = "1039ui_story"

			if arg_570_1.actors_[var_573_4] == nil then
				local var_573_5 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_573_5) then
					local var_573_6 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_570_1.stage_.transform)

					var_573_6.name = var_573_4
					var_573_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_570_1.actors_[var_573_4] = var_573_6

					local var_573_7 = var_573_6:GetComponentInChildren(typeof(CharacterEffect))

					var_573_7.enabled = true

					local var_573_8 = GameObjectTools.GetOrAddComponent(var_573_6, typeof(DynamicBoneHelper))

					if var_573_8 then
						var_573_8:EnableDynamicBone(false)
					end

					arg_570_1:ShowWeapon(var_573_7.transform, false)

					arg_570_1.var_[var_573_4 .. "Animator"] = var_573_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_570_1.var_[var_573_4 .. "Animator"].applyRootMotion = true
					arg_570_1.var_[var_573_4 .. "LipSync"] = var_573_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_573_9 = 0

			if var_573_9 < arg_570_1.time_ and arg_570_1.time_ <= var_573_9 + arg_573_0 then
				arg_570_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action463")
			end

			local var_573_10 = "1039ui_story"

			if arg_570_1.actors_[var_573_10] == nil then
				local var_573_11 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_573_11) then
					local var_573_12 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_570_1.stage_.transform)

					var_573_12.name = var_573_10
					var_573_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_570_1.actors_[var_573_10] = var_573_12

					local var_573_13 = var_573_12:GetComponentInChildren(typeof(CharacterEffect))

					var_573_13.enabled = true

					local var_573_14 = GameObjectTools.GetOrAddComponent(var_573_12, typeof(DynamicBoneHelper))

					if var_573_14 then
						var_573_14:EnableDynamicBone(false)
					end

					arg_570_1:ShowWeapon(var_573_13.transform, false)

					arg_570_1.var_[var_573_10 .. "Animator"] = var_573_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_570_1.var_[var_573_10 .. "Animator"].applyRootMotion = true
					arg_570_1.var_[var_573_10 .. "LipSync"] = var_573_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_573_15 = 0

			if var_573_15 < arg_570_1.time_ and arg_570_1.time_ <= var_573_15 + arg_573_0 then
				arg_570_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_573_16 = 0
			local var_573_17 = 0.2

			if var_573_16 < arg_570_1.time_ and arg_570_1.time_ <= var_573_16 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_18 = arg_570_1:FormatText(StoryNameCfg[9].name)

				arg_570_1.leftNameTxt_.text = var_573_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_19 = arg_570_1:GetWordFromCfg(103903137)
				local var_573_20 = arg_570_1:FormatText(var_573_19.content)

				arg_570_1.text_.text = var_573_20

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_21 = 8
				local var_573_22 = utf8.len(var_573_20)
				local var_573_23 = var_573_21 <= 0 and var_573_17 or var_573_17 * (var_573_22 / var_573_21)

				if var_573_23 > 0 and var_573_17 < var_573_23 then
					arg_570_1.talkMaxDuration = var_573_23

					if var_573_23 + var_573_16 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_23 + var_573_16
					end
				end

				arg_570_1.text_.text = var_573_20
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb") ~= 0 then
					local var_573_24 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb") / 1000

					if var_573_24 + var_573_16 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_24 + var_573_16
					end

					if var_573_19.prefab_name ~= "" and arg_570_1.actors_[var_573_19.prefab_name] ~= nil then
						local var_573_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_19.prefab_name].transform, "story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb")

						arg_570_1:RecordAudio("103903137", var_573_25)
						arg_570_1:RecordAudio("103903137", var_573_25)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_26 = math.max(var_573_17, arg_570_1.talkMaxDuration)

			if var_573_16 <= arg_570_1.time_ and arg_570_1.time_ < var_573_16 + var_573_26 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_16) / var_573_26

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_16 + var_573_26 and arg_570_1.time_ < var_573_16 + var_573_26 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play103903138 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 103903138
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play103903139(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = 0
			local var_577_1 = 1.025

			if var_577_0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_0 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, false)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_2 = arg_574_1:GetWordFromCfg(103903138)
				local var_577_3 = arg_574_1:FormatText(var_577_2.content)

				arg_574_1.text_.text = var_577_3

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_4 = 41
				local var_577_5 = utf8.len(var_577_3)
				local var_577_6 = var_577_4 <= 0 and var_577_1 or var_577_1 * (var_577_5 / var_577_4)

				if var_577_6 > 0 and var_577_1 < var_577_6 then
					arg_574_1.talkMaxDuration = var_577_6

					if var_577_6 + var_577_0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_6 + var_577_0
					end
				end

				arg_574_1.text_.text = var_577_3
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_7 = math.max(var_577_1, arg_574_1.talkMaxDuration)

			if var_577_0 <= arg_574_1.time_ and arg_574_1.time_ < var_577_0 + var_577_7 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_0) / var_577_7

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_0 + var_577_7 and arg_574_1.time_ < var_577_0 + var_577_7 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play103903139 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 103903139
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play103903140(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = arg_578_1.actors_["1039ui_story"]
			local var_581_1 = 0

			if var_581_1 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect1039ui_story == nil then
				arg_578_1.var_.characterEffect1039ui_story = var_581_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_2 = 0.1

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_2 and not isNil(var_581_0) then
				local var_581_3 = (arg_578_1.time_ - var_581_1) / var_581_2

				if arg_578_1.var_.characterEffect1039ui_story and not isNil(var_581_0) then
					local var_581_4 = Mathf.Lerp(0, 0.5, var_581_3)

					arg_578_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_578_1.var_.characterEffect1039ui_story.fillRatio = var_581_4
				end
			end

			if arg_578_1.time_ >= var_581_1 + var_581_2 and arg_578_1.time_ < var_581_1 + var_581_2 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect1039ui_story then
				local var_581_5 = 0.5

				arg_578_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_578_1.var_.characterEffect1039ui_story.fillRatio = var_581_5
			end

			local var_581_6 = 0
			local var_581_7 = 0.4

			if var_581_6 < arg_578_1.time_ and arg_578_1.time_ <= var_581_6 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				local var_581_8 = arg_578_1:FormatText(StoryNameCfg[7].name)

				arg_578_1.leftNameTxt_.text = var_581_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, true)
				arg_578_1.iconController_:SetSelectedState("hero")

				arg_578_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_578_1.callingController_:SetSelectedState("normal")

				arg_578_1.keyicon_.color = Color.New(1, 1, 1)
				arg_578_1.icon_.color = Color.New(1, 1, 1)

				local var_581_9 = arg_578_1:GetWordFromCfg(103903139)
				local var_581_10 = arg_578_1:FormatText(var_581_9.content)

				arg_578_1.text_.text = var_581_10

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_11 = 16
				local var_581_12 = utf8.len(var_581_10)
				local var_581_13 = var_581_11 <= 0 and var_581_7 or var_581_7 * (var_581_12 / var_581_11)

				if var_581_13 > 0 and var_581_7 < var_581_13 then
					arg_578_1.talkMaxDuration = var_581_13

					if var_581_13 + var_581_6 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_13 + var_581_6
					end
				end

				arg_578_1.text_.text = var_581_10
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_14 = math.max(var_581_7, arg_578_1.talkMaxDuration)

			if var_581_6 <= arg_578_1.time_ and arg_578_1.time_ < var_581_6 + var_581_14 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_6) / var_581_14

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_6 + var_581_14 and arg_578_1.time_ < var_581_6 + var_581_14 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play103903140 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 103903140
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play103903141(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = 0
			local var_585_1 = 0.275

			if var_585_0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_0 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, false)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_2 = arg_582_1:GetWordFromCfg(103903140)
				local var_585_3 = arg_582_1:FormatText(var_585_2.content)

				arg_582_1.text_.text = var_585_3

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_4 = 11
				local var_585_5 = utf8.len(var_585_3)
				local var_585_6 = var_585_4 <= 0 and var_585_1 or var_585_1 * (var_585_5 / var_585_4)

				if var_585_6 > 0 and var_585_1 < var_585_6 then
					arg_582_1.talkMaxDuration = var_585_6

					if var_585_6 + var_585_0 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_6 + var_585_0
					end
				end

				arg_582_1.text_.text = var_585_3
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_7 = math.max(var_585_1, arg_582_1.talkMaxDuration)

			if var_585_0 <= arg_582_1.time_ and arg_582_1.time_ < var_585_0 + var_585_7 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_0) / var_585_7

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_0 + var_585_7 and arg_582_1.time_ < var_585_0 + var_585_7 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play103903141 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 103903141
		arg_586_1.duration_ = 5.37

		local var_586_0 = {
			ja = 5.366,
			ko = 3.933,
			zh = 3.933,
			en = 3.433
		}
		local var_586_1 = manager.audio:GetLocalizationFlag()

		if var_586_0[var_586_1] ~= nil then
			arg_586_1.duration_ = var_586_0[var_586_1]
		end

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play103903142(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = arg_586_1.actors_["1039ui_story"]
			local var_589_1 = 0

			if var_589_1 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect1039ui_story == nil then
				arg_586_1.var_.characterEffect1039ui_story = var_589_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_2 = 0.1

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_2 and not isNil(var_589_0) then
				local var_589_3 = (arg_586_1.time_ - var_589_1) / var_589_2

				if arg_586_1.var_.characterEffect1039ui_story and not isNil(var_589_0) then
					arg_586_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_586_1.time_ >= var_589_1 + var_589_2 and arg_586_1.time_ < var_589_1 + var_589_2 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect1039ui_story then
				arg_586_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_589_4 = 0

			if var_589_4 < arg_586_1.time_ and arg_586_1.time_ <= var_589_4 + arg_589_0 then
				arg_586_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action438")
			end

			local var_589_5 = 0

			if var_589_5 < arg_586_1.time_ and arg_586_1.time_ <= var_589_5 + arg_589_0 then
				arg_586_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_589_6 = 0
			local var_589_7 = 0.275

			if var_589_6 < arg_586_1.time_ and arg_586_1.time_ <= var_589_6 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				local var_589_8 = arg_586_1:FormatText(StoryNameCfg[9].name)

				arg_586_1.leftNameTxt_.text = var_589_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_9 = arg_586_1:GetWordFromCfg(103903141)
				local var_589_10 = arg_586_1:FormatText(var_589_9.content)

				arg_586_1.text_.text = var_589_10

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_11 = 11
				local var_589_12 = utf8.len(var_589_10)
				local var_589_13 = var_589_11 <= 0 and var_589_7 or var_589_7 * (var_589_12 / var_589_11)

				if var_589_13 > 0 and var_589_7 < var_589_13 then
					arg_586_1.talkMaxDuration = var_589_13

					if var_589_13 + var_589_6 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_13 + var_589_6
					end
				end

				arg_586_1.text_.text = var_589_10
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb") ~= 0 then
					local var_589_14 = manager.audio:GetVoiceLength("story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb") / 1000

					if var_589_14 + var_589_6 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_14 + var_589_6
					end

					if var_589_9.prefab_name ~= "" and arg_586_1.actors_[var_589_9.prefab_name] ~= nil then
						local var_589_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_9.prefab_name].transform, "story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb")

						arg_586_1:RecordAudio("103903141", var_589_15)
						arg_586_1:RecordAudio("103903141", var_589_15)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_16 = math.max(var_589_7, arg_586_1.talkMaxDuration)

			if var_589_6 <= arg_586_1.time_ and arg_586_1.time_ < var_589_6 + var_589_16 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_6) / var_589_16

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_6 + var_589_16 and arg_586_1.time_ < var_589_6 + var_589_16 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/D04a",
		"TextureConfig/Background/ST01"
	},
	voices = {
		"story_v_side_old_103903.awb"
	}
}
