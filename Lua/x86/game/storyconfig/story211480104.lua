return {
	Play114804001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114804001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114804002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B13a"

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
				local var_4_5 = arg_1_1.bgs_.B13a

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
					if iter_4_0 ~= "B13a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.B13a
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueB13a = var_4_18.color.a
					arg_1_1.var_.alphaMatValueB13a = var_4_18
				end

				arg_1_1.var_.alphaOldValueB13a = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB13a, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueB13a then
					local var_4_22 = arg_1_1.var_.alphaMatValueB13a.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueB13a.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueB13a then
				local var_4_23 = arg_1_1.var_.alphaMatValueB13a
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_30 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_30 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_30

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_30
						arg_1_1.bgmTxt2_.text = var_4_30
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

			local var_4_31 = 2
			local var_4_32 = 3

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				local var_4_33 = "play"
				local var_4_34 = "music"

				arg_1_1:AudioAction(var_4_33, var_4_34, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_35 = ""
				local var_4_36 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_4_36 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_36 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_36

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_36
						arg_1_1.bgmTxt2_.text = var_4_36
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

			local var_4_37 = 2
			local var_4_38 = 0.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_39 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_39:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_40 = arg_1_1:GetWordFromCfg(114804001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 32
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_38 or var_4_38 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_38 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_37 = var_4_37 + 0.3

					if var_4_44 + var_4_37 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_37
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_37 + 0.3
			local var_4_46 = math.max(var_4_38, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play114804002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114804002
		arg_9_1.duration_ = 5.27

		local var_9_0 = {
			ja = 4.233,
			ko = 5.266,
			zh = 4.4,
			en = 3.733
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
				arg_9_0:Play114804003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1019ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1019ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1019ui_story = var_12_5.localPosition

				local var_12_7 = "1019ui_story"

				arg_9_1:ShowWeapon(arg_9_1.var_[var_12_7 .. "Animator"].transform, false)
			end

			local var_12_8 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_6) / var_12_8
				local var_12_10 = Vector3.New(-0.2, -1.08, -5.9)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1019ui_story, var_12_10, var_12_9)

				local var_12_11 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_11.x, var_12_11.y, var_12_11.z)

				local var_12_12 = var_12_5.localEulerAngles

				var_12_12.z = 0
				var_12_12.x = 0
				var_12_5.localEulerAngles = var_12_12
			end

			if arg_9_1.time_ >= var_12_6 + var_12_8 and arg_9_1.time_ < var_12_6 + var_12_8 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_12_13 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_13.x, var_12_13.y, var_12_13.z)

				local var_12_14 = var_12_5.localEulerAngles

				var_12_14.z = 0
				var_12_14.x = 0
				var_12_5.localEulerAngles = var_12_14
			end

			local var_12_15 = arg_9_1.actors_["1019ui_story"]
			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect1019ui_story == nil then
				arg_9_1.var_.characterEffect1019ui_story = var_12_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_17 = 0.2

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 and not isNil(var_12_15) then
				local var_12_18 = (arg_9_1.time_ - var_12_16) / var_12_17

				if arg_9_1.var_.characterEffect1019ui_story and not isNil(var_12_15) then
					arg_9_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect1019ui_story then
				arg_9_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_12_19 = 0.0166666666666667

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_12_20 = 0.0166666666666667

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_12_21 = 0
			local var_12_22 = 0.475

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_23 = arg_9_1:FormatText(StoryNameCfg[13].name)

				arg_9_1.leftNameTxt_.text = var_12_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_24 = arg_9_1:GetWordFromCfg(114804002)
				local var_12_25 = arg_9_1:FormatText(var_12_24.content)

				arg_9_1.text_.text = var_12_25

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_26 = 19
				local var_12_27 = utf8.len(var_12_25)
				local var_12_28 = var_12_26 <= 0 and var_12_22 or var_12_22 * (var_12_27 / var_12_26)

				if var_12_28 > 0 and var_12_22 < var_12_28 then
					arg_9_1.talkMaxDuration = var_12_28

					if var_12_28 + var_12_21 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_21
					end
				end

				arg_9_1.text_.text = var_12_25
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804002", "story_v_side_old_114804.awb") ~= 0 then
					local var_12_29 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804002", "story_v_side_old_114804.awb") / 1000

					if var_12_29 + var_12_21 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_29 + var_12_21
					end

					if var_12_24.prefab_name ~= "" and arg_9_1.actors_[var_12_24.prefab_name] ~= nil then
						local var_12_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_24.prefab_name].transform, "story_v_side_old_114804", "114804002", "story_v_side_old_114804.awb")

						arg_9_1:RecordAudio("114804002", var_12_30)
						arg_9_1:RecordAudio("114804002", var_12_30)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804002", "story_v_side_old_114804.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804002", "story_v_side_old_114804.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_31 = math.max(var_12_22, arg_9_1.talkMaxDuration)

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_31 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_21) / var_12_31

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_21 + var_12_31 and arg_9_1.time_ < var_12_21 + var_12_31 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play114804003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114804003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114804004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1019ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1019ui_story == nil then
				arg_13_1.var_.characterEffect1019ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1019ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1019ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1019ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1019ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_16_7 = 0
			local var_16_8 = 0.35

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_9 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_10 = arg_13_1:GetWordFromCfg(114804003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 14
				local var_16_13 = utf8.len(var_16_11)
				local var_16_14 = var_16_12 <= 0 and var_16_8 or var_16_8 * (var_16_13 / var_16_12)

				if var_16_14 > 0 and var_16_8 < var_16_14 then
					arg_13_1.talkMaxDuration = var_16_14

					if var_16_14 + var_16_7 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_7
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_15 = math.max(var_16_8, arg_13_1.talkMaxDuration)

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_15 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_7) / var_16_15

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_7 + var_16_15 and arg_13_1.time_ < var_16_7 + var_16_15 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play114804004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114804004
		arg_17_1.duration_ = 3.77

		local var_17_0 = {
			ja = 3.766,
			ko = 3.266,
			zh = 2.633,
			en = 2.4
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
				arg_17_0:Play114804005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1019ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1019ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1019ui_story then
				arg_17_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_20_4 = 0

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_6 = 0
			local var_20_7 = 0.275

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[13].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_9 = arg_17_1:GetWordFromCfg(114804004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 11
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

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804004", "story_v_side_old_114804.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804004", "story_v_side_old_114804.awb") / 1000

					if var_20_14 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_6
					end

					if var_20_9.prefab_name ~= "" and arg_17_1.actors_[var_20_9.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_9.prefab_name].transform, "story_v_side_old_114804", "114804004", "story_v_side_old_114804.awb")

						arg_17_1:RecordAudio("114804004", var_20_15)
						arg_17_1:RecordAudio("114804004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804004", "story_v_side_old_114804.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804004", "story_v_side_old_114804.awb")
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
	Play114804005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114804005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play114804006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1019ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1019ui_story == nil then
				arg_21_1.var_.characterEffect1019ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1019ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1019ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1019ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1019ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_24_7 = 0
			local var_24_8 = 1.575

			if var_24_7 < arg_21_1.time_ and arg_21_1.time_ <= var_24_7 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:GetWordFromCfg(114804005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 63
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_8 or var_24_8 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_8 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_7 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_7
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_8, arg_21_1.talkMaxDuration)

			if var_24_7 <= arg_21_1.time_ and arg_21_1.time_ < var_24_7 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_7) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_7 + var_24_14 and arg_21_1.time_ < var_24_7 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114804006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114804006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play114804007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_28_1 = 0
			local var_28_2 = 0.6

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(114804006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 24
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_2 or var_28_2 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_2 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_8 and arg_25_1.time_ < var_28_1 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114804007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114804007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play114804008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_32_1 = 0
			local var_32_2 = 0.225

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_3 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_4 = arg_29_1:GetWordFromCfg(114804007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 9
				local var_32_7 = utf8.len(var_32_5)
				local var_32_8 = var_32_6 <= 0 and var_32_2 or var_32_2 * (var_32_7 / var_32_6)

				if var_32_8 > 0 and var_32_2 < var_32_8 then
					arg_29_1.talkMaxDuration = var_32_8

					if var_32_8 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_9 and arg_29_1.time_ < var_32_1 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114804008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114804008
		arg_33_1.duration_ = 7.77

		local var_33_0 = {
			ja = 7.766,
			ko = 6.033,
			zh = 5.7,
			en = 4.733
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
				arg_33_0:Play114804009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1019ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1019ui_story == nil then
				arg_33_1.var_.characterEffect1019ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1019ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1019ui_story then
				arg_33_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action454")
			end

			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_36_6 = 0
			local var_36_7 = 0.525

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[13].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:GetWordFromCfg(114804008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 21
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804008", "story_v_side_old_114804.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804008", "story_v_side_old_114804.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_side_old_114804", "114804008", "story_v_side_old_114804.awb")

						arg_33_1:RecordAudio("114804008", var_36_15)
						arg_33_1:RecordAudio("114804008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804008", "story_v_side_old_114804.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804008", "story_v_side_old_114804.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114804009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114804009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play114804010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1019ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1019ui_story == nil then
				arg_37_1.var_.characterEffect1019ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1019ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1019ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1019ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1019ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_40_7 = 0
			local var_40_8 = 0.35

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_9 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_9

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

				local var_40_10 = arg_37_1:GetWordFromCfg(114804009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_12 = 14
				local var_40_13 = utf8.len(var_40_11)
				local var_40_14 = var_40_12 <= 0 and var_40_8 or var_40_8 * (var_40_13 / var_40_12)

				if var_40_14 > 0 and var_40_8 < var_40_14 then
					arg_37_1.talkMaxDuration = var_40_14

					if var_40_14 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_7
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_15 = math.max(var_40_8, arg_37_1.talkMaxDuration)

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_15 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_7) / var_40_15

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_7 + var_40_15 and arg_37_1.time_ < var_40_7 + var_40_15 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114804010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114804010
		arg_41_1.duration_ = 10.43

		local var_41_0 = {
			ja = 10.433,
			ko = 7.6,
			zh = 6.2,
			en = 7.966
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
				arg_41_0:Play114804011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1019ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1019ui_story == nil then
				arg_41_1.var_.characterEffect1019ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1019ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1019ui_story then
				arg_41_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action442")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_44_6 = 0
			local var_44_7 = 0.725

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[13].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(114804010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 29
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

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804010", "story_v_side_old_114804.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804010", "story_v_side_old_114804.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_side_old_114804", "114804010", "story_v_side_old_114804.awb")

						arg_41_1:RecordAudio("114804010", var_44_15)
						arg_41_1:RecordAudio("114804010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804010", "story_v_side_old_114804.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804010", "story_v_side_old_114804.awb")
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
	Play114804011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114804011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play114804012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1019ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1019ui_story == nil then
				arg_45_1.var_.characterEffect1019ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1019ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1019ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1019ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1019ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_48_7 = 0
			local var_48_8 = 0.275

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_9 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_9

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

				local var_48_10 = arg_45_1:GetWordFromCfg(114804011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 11
				local var_48_13 = utf8.len(var_48_11)
				local var_48_14 = var_48_12 <= 0 and var_48_8 or var_48_8 * (var_48_13 / var_48_12)

				if var_48_14 > 0 and var_48_8 < var_48_14 then
					arg_45_1.talkMaxDuration = var_48_14

					if var_48_14 + var_48_7 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_7
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_15 = math.max(var_48_8, arg_45_1.talkMaxDuration)

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_15 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_7) / var_48_15

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_7 + var_48_15 and arg_45_1.time_ < var_48_7 + var_48_15 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114804012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114804012
		arg_49_1.duration_ = 4.2

		local var_49_0 = {
			ja = 4.2,
			ko = 3.266,
			zh = 3.366,
			en = 3.3
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play114804013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1019ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1019ui_story == nil then
				arg_49_1.var_.characterEffect1019ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1019ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1019ui_story then
				arg_49_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action426")
			end

			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_52_6 = 0
			local var_52_7 = 0.325

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[13].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(114804012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 13
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804012", "story_v_side_old_114804.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804012", "story_v_side_old_114804.awb") / 1000

					if var_52_14 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_6
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_side_old_114804", "114804012", "story_v_side_old_114804.awb")

						arg_49_1:RecordAudio("114804012", var_52_15)
						arg_49_1:RecordAudio("114804012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804012", "story_v_side_old_114804.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804012", "story_v_side_old_114804.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_16 and arg_49_1.time_ < var_52_6 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114804013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114804013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play114804014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1019ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1019ui_story == nil then
				arg_53_1.var_.characterEffect1019ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1019ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1019ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1019ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1019ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_56_7 = 0
			local var_56_8 = 0.75

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_9 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_10 = arg_53_1:GetWordFromCfg(114804013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_12 = 30
				local var_56_13 = utf8.len(var_56_11)
				local var_56_14 = var_56_12 <= 0 and var_56_8 or var_56_8 * (var_56_13 / var_56_12)

				if var_56_14 > 0 and var_56_8 < var_56_14 then
					arg_53_1.talkMaxDuration = var_56_14

					if var_56_14 + var_56_7 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_7
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_15 = math.max(var_56_8, arg_53_1.talkMaxDuration)

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_15 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_7) / var_56_15

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_7 + var_56_15 and arg_53_1.time_ < var_56_7 + var_56_15 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114804014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114804014
		arg_57_1.duration_ = 5.73

		local var_57_0 = {
			ja = 5.733,
			ko = 4.033,
			zh = 3.533,
			en = 4.2
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
				arg_57_0:Play114804015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1019ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1019ui_story == nil then
				arg_57_1.var_.characterEffect1019ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1019ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1019ui_story then
				arg_57_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_60_4 = 0

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_60_6 = 0
			local var_60_7 = 0.475

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[13].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_9 = arg_57_1:GetWordFromCfg(114804014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 19
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

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804014", "story_v_side_old_114804.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804014", "story_v_side_old_114804.awb") / 1000

					if var_60_14 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_6
					end

					if var_60_9.prefab_name ~= "" and arg_57_1.actors_[var_60_9.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_9.prefab_name].transform, "story_v_side_old_114804", "114804014", "story_v_side_old_114804.awb")

						arg_57_1:RecordAudio("114804014", var_60_15)
						arg_57_1:RecordAudio("114804014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804014", "story_v_side_old_114804.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804014", "story_v_side_old_114804.awb")
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
	Play114804015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114804015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play114804016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1019ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1019ui_story == nil then
				arg_61_1.var_.characterEffect1019ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1019ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1019ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1019ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1019ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_64_7 = 0
			local var_64_8 = 0.05

			if var_64_7 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_9 = arg_61_1:FormatText(StoryNameCfg[7].name)

				arg_61_1.leftNameTxt_.text = var_64_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_10 = arg_61_1:GetWordFromCfg(114804015)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_12 = 2
				local var_64_13 = utf8.len(var_64_11)
				local var_64_14 = var_64_12 <= 0 and var_64_8 or var_64_8 * (var_64_13 / var_64_12)

				if var_64_14 > 0 and var_64_8 < var_64_14 then
					arg_61_1.talkMaxDuration = var_64_14

					if var_64_14 + var_64_7 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_7
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_15 = math.max(var_64_8, arg_61_1.talkMaxDuration)

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_15 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_7) / var_64_15

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_7 + var_64_15 and arg_61_1.time_ < var_64_7 + var_64_15 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play114804016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114804016
		arg_65_1.duration_ = 13.73

		local var_65_0 = {
			ja = 13.733,
			ko = 9.833,
			zh = 8.766,
			en = 9.933
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
				arg_65_0:Play114804017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1019ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1019ui_story == nil then
				arg_65_1.var_.characterEffect1019ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1019ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1019ui_story then
				arg_65_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_68_4 = 0

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action453")
			end

			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_68_6 = 0
			local var_68_7 = 1.025

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[13].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_9 = arg_65_1:GetWordFromCfg(114804016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 41
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

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804016", "story_v_side_old_114804.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804016", "story_v_side_old_114804.awb") / 1000

					if var_68_14 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_6
					end

					if var_68_9.prefab_name ~= "" and arg_65_1.actors_[var_68_9.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_9.prefab_name].transform, "story_v_side_old_114804", "114804016", "story_v_side_old_114804.awb")

						arg_65_1:RecordAudio("114804016", var_68_15)
						arg_65_1:RecordAudio("114804016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804016", "story_v_side_old_114804.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804016", "story_v_side_old_114804.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_16 and arg_65_1.time_ < var_68_6 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114804017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114804017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play114804018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1019ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1019ui_story == nil then
				arg_69_1.var_.characterEffect1019ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1019ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1019ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1019ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1019ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_72_7 = 0
			local var_72_8 = 0.15

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_9 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_10 = arg_69_1:GetWordFromCfg(114804017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_12 = 6
				local var_72_13 = utf8.len(var_72_11)
				local var_72_14 = var_72_12 <= 0 and var_72_8 or var_72_8 * (var_72_13 / var_72_12)

				if var_72_14 > 0 and var_72_8 < var_72_14 then
					arg_69_1.talkMaxDuration = var_72_14

					if var_72_14 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_7
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_15 = math.max(var_72_8, arg_69_1.talkMaxDuration)

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_15 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_7) / var_72_15

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_7 + var_72_15 and arg_69_1.time_ < var_72_7 + var_72_15 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114804018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114804018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play114804019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action435")
			end

			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_76_2 = 0
			local var_76_3 = 0.875

			if var_76_2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(114804018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 35
				local var_76_7 = utf8.len(var_76_5)
				local var_76_8 = var_76_6 <= 0 and var_76_3 or var_76_3 * (var_76_7 / var_76_6)

				if var_76_8 > 0 and var_76_3 < var_76_8 then
					arg_73_1.talkMaxDuration = var_76_8

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_9 and arg_73_1.time_ < var_76_2 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114804019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114804019
		arg_77_1.duration_ = 6.03

		local var_77_0 = {
			ja = 6.033,
			ko = 4.366,
			zh = 5.666,
			en = 5.133
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
				arg_77_0:Play114804020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1019ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1019ui_story == nil then
				arg_77_1.var_.characterEffect1019ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1019ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1019ui_story then
				arg_77_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_80_4 = 0

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_80_5 = 0
			local var_80_6 = 0.425

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_7 = arg_77_1:FormatText(StoryNameCfg[13].name)

				arg_77_1.leftNameTxt_.text = var_80_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(114804019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 17
				local var_80_11 = utf8.len(var_80_9)
				local var_80_12 = var_80_10 <= 0 and var_80_6 or var_80_6 * (var_80_11 / var_80_10)

				if var_80_12 > 0 and var_80_6 < var_80_12 then
					arg_77_1.talkMaxDuration = var_80_12

					if var_80_12 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804019", "story_v_side_old_114804.awb") ~= 0 then
					local var_80_13 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804019", "story_v_side_old_114804.awb") / 1000

					if var_80_13 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_5
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_side_old_114804", "114804019", "story_v_side_old_114804.awb")

						arg_77_1:RecordAudio("114804019", var_80_14)
						arg_77_1:RecordAudio("114804019", var_80_14)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804019", "story_v_side_old_114804.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804019", "story_v_side_old_114804.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_15 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_15 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_15

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_15 and arg_77_1.time_ < var_80_5 + var_80_15 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play114804020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114804020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play114804021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1019ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1019ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, 100, 0)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1019ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, 100, 0)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = 0
			local var_84_10 = 1.375

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_11 = arg_81_1:GetWordFromCfg(114804020)
				local var_84_12 = arg_81_1:FormatText(var_84_11.content)

				arg_81_1.text_.text = var_84_12

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 55
				local var_84_14 = utf8.len(var_84_12)
				local var_84_15 = var_84_13 <= 0 and var_84_10 or var_84_10 * (var_84_14 / var_84_13)

				if var_84_15 > 0 and var_84_10 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_9 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_9
					end
				end

				arg_81_1.text_.text = var_84_12
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_10, arg_81_1.talkMaxDuration)

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_9) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_9 + var_84_16 and arg_81_1.time_ < var_84_9 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play114804021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114804021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114804022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = "1148ui_story"

			if arg_85_1.actors_[var_88_0] == nil then
				local var_88_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_88_1) then
					local var_88_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_85_1.stage_.transform)

					var_88_2.name = var_88_0
					var_88_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_85_1.actors_[var_88_0] = var_88_2

					local var_88_3 = var_88_2:GetComponentInChildren(typeof(CharacterEffect))

					var_88_3.enabled = true

					local var_88_4 = GameObjectTools.GetOrAddComponent(var_88_2, typeof(DynamicBoneHelper))

					if var_88_4 then
						var_88_4:EnableDynamicBone(false)
					end

					arg_85_1:ShowWeapon(var_88_3.transform, false)

					arg_85_1.var_[var_88_0 .. "Animator"] = var_88_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_85_1.var_[var_88_0 .. "Animator"].applyRootMotion = true
					arg_85_1.var_[var_88_0 .. "LipSync"] = var_88_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_88_5 = arg_85_1.actors_["1148ui_story"].transform
			local var_88_6 = 0

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.var_.moveOldPos1148ui_story = var_88_5.localPosition

				local var_88_7 = "1148ui_story"

				arg_85_1:ShowWeapon(arg_85_1.var_[var_88_7 .. "Animator"].transform, false)
			end

			local var_88_8 = 0.001

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_8 then
				local var_88_9 = (arg_85_1.time_ - var_88_6) / var_88_8
				local var_88_10 = Vector3.New(0, -0.8, -6.2)

				var_88_5.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1148ui_story, var_88_10, var_88_9)

				local var_88_11 = manager.ui.mainCamera.transform.position - var_88_5.position

				var_88_5.forward = Vector3.New(var_88_11.x, var_88_11.y, var_88_11.z)

				local var_88_12 = var_88_5.localEulerAngles

				var_88_12.z = 0
				var_88_12.x = 0
				var_88_5.localEulerAngles = var_88_12
			end

			if arg_85_1.time_ >= var_88_6 + var_88_8 and arg_85_1.time_ < var_88_6 + var_88_8 + arg_88_0 then
				var_88_5.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_88_13 = manager.ui.mainCamera.transform.position - var_88_5.position

				var_88_5.forward = Vector3.New(var_88_13.x, var_88_13.y, var_88_13.z)

				local var_88_14 = var_88_5.localEulerAngles

				var_88_14.z = 0
				var_88_14.x = 0
				var_88_5.localEulerAngles = var_88_14
			end

			local var_88_15 = 0.0166666666666667

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			local var_88_16 = 0.0166666666666667

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_88_17 = 0
			local var_88_18 = 0.725

			if var_88_17 < arg_85_1.time_ and arg_85_1.time_ <= var_88_17 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_19 = arg_85_1:GetWordFromCfg(114804021)
				local var_88_20 = arg_85_1:FormatText(var_88_19.content)

				arg_85_1.text_.text = var_88_20

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_21 = 29
				local var_88_22 = utf8.len(var_88_20)
				local var_88_23 = var_88_21 <= 0 and var_88_18 or var_88_18 * (var_88_22 / var_88_21)

				if var_88_23 > 0 and var_88_18 < var_88_23 then
					arg_85_1.talkMaxDuration = var_88_23

					if var_88_23 + var_88_17 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_17
					end
				end

				arg_85_1.text_.text = var_88_20
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_24 = math.max(var_88_18, arg_85_1.talkMaxDuration)

			if var_88_17 <= arg_85_1.time_ and arg_85_1.time_ < var_88_17 + var_88_24 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_17) / var_88_24

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_17 + var_88_24 and arg_85_1.time_ < var_88_17 + var_88_24 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play114804022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114804022
		arg_89_1.duration_ = 9.07

		local var_89_0 = {
			ja = 9.066,
			ko = 7.233,
			zh = 6.266,
			en = 8.366
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
				arg_89_0:Play114804023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1148ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1148ui_story == nil then
				arg_89_1.var_.characterEffect1148ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1148ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1148ui_story then
				arg_89_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_92_4 = 0

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_92_5 = 0

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_92_6 = 0
			local var_92_7 = 0.775

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_8 = arg_89_1:FormatText(StoryNameCfg[8].name)

				arg_89_1.leftNameTxt_.text = var_92_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_9 = arg_89_1:GetWordFromCfg(114804022)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 31
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

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804022", "story_v_side_old_114804.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804022", "story_v_side_old_114804.awb") / 1000

					if var_92_14 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_6
					end

					if var_92_9.prefab_name ~= "" and arg_89_1.actors_[var_92_9.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_9.prefab_name].transform, "story_v_side_old_114804", "114804022", "story_v_side_old_114804.awb")

						arg_89_1:RecordAudio("114804022", var_92_15)
						arg_89_1:RecordAudio("114804022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804022", "story_v_side_old_114804.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804022", "story_v_side_old_114804.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_16 and arg_89_1.time_ < var_92_6 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114804023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114804023
		arg_93_1.duration_ = 6.33

		local var_93_0 = {
			ja = 4.733,
			ko = 4,
			zh = 4.1,
			en = 6.333
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
				arg_93_0:Play114804024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_96_1 = 0
			local var_96_2 = 0.45

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_3 = arg_93_1:FormatText(StoryNameCfg[8].name)

				arg_93_1.leftNameTxt_.text = var_96_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(114804023)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 18
				local var_96_7 = utf8.len(var_96_5)
				local var_96_8 = var_96_6 <= 0 and var_96_2 or var_96_2 * (var_96_7 / var_96_6)

				if var_96_8 > 0 and var_96_2 < var_96_8 then
					arg_93_1.talkMaxDuration = var_96_8

					if var_96_8 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804023", "story_v_side_old_114804.awb") ~= 0 then
					local var_96_9 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804023", "story_v_side_old_114804.awb") / 1000

					if var_96_9 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_1
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_side_old_114804", "114804023", "story_v_side_old_114804.awb")

						arg_93_1:RecordAudio("114804023", var_96_10)
						arg_93_1:RecordAudio("114804023", var_96_10)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804023", "story_v_side_old_114804.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804023", "story_v_side_old_114804.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_11 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_11 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_11

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_11 and arg_93_1.time_ < var_96_1 + var_96_11 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114804024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114804024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play114804025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1148ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1148ui_story == nil then
				arg_97_1.var_.characterEffect1148ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1148ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1148ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1148ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1148ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_100_7 = 0
			local var_100_8 = 0.65

			if var_100_7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_9 = arg_97_1:GetWordFromCfg(114804024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 26
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_8 or var_100_8 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_8 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_7 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_7
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_8, arg_97_1.talkMaxDuration)

			if var_100_7 <= arg_97_1.time_ and arg_97_1.time_ < var_100_7 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_7) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_7 + var_100_14 and arg_97_1.time_ < var_100_7 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114804025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114804025
		arg_101_1.duration_ = 8.5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play114804026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "ST02"

			if arg_101_1.bgs_[var_104_0] == nil then
				local var_104_1 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_104_0)
				var_104_1.name = var_104_0
				var_104_1.transform.parent = arg_101_1.stage_.transform
				var_104_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_[var_104_0] = var_104_1
			end

			local var_104_2 = 1.5

			if var_104_2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				local var_104_3 = manager.ui.mainCamera.transform.localPosition
				local var_104_4 = Vector3.New(0, 0, 10) + Vector3.New(var_104_3.x, var_104_3.y, 0)
				local var_104_5 = arg_101_1.bgs_.ST02

				var_104_5.transform.localPosition = var_104_4
				var_104_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_6 = var_104_5:GetComponent("SpriteRenderer")

				if var_104_6 and var_104_6.sprite then
					local var_104_7 = (var_104_5.transform.localPosition - var_104_3).z
					local var_104_8 = manager.ui.mainCameraCom_
					local var_104_9 = 2 * var_104_7 * Mathf.Tan(var_104_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_104_10 = var_104_9 * var_104_8.aspect
					local var_104_11 = var_104_6.sprite.bounds.size.x
					local var_104_12 = var_104_6.sprite.bounds.size.y
					local var_104_13 = var_104_10 / var_104_11
					local var_104_14 = var_104_9 / var_104_12
					local var_104_15 = var_104_14 < var_104_13 and var_104_13 or var_104_14

					var_104_5.transform.localScale = Vector3.New(var_104_15, var_104_15, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "ST02" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_16 = arg_101_1.actors_["1148ui_story"].transform
			local var_104_17 = 0

			if var_104_17 < arg_101_1.time_ and arg_101_1.time_ <= var_104_17 + arg_104_0 then
				arg_101_1.var_.moveOldPos1148ui_story = var_104_16.localPosition
			end

			local var_104_18 = 0.001

			if var_104_17 <= arg_101_1.time_ and arg_101_1.time_ < var_104_17 + var_104_18 then
				local var_104_19 = (arg_101_1.time_ - var_104_17) / var_104_18
				local var_104_20 = Vector3.New(0, 100, 0)

				var_104_16.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1148ui_story, var_104_20, var_104_19)

				local var_104_21 = manager.ui.mainCamera.transform.position - var_104_16.position

				var_104_16.forward = Vector3.New(var_104_21.x, var_104_21.y, var_104_21.z)

				local var_104_22 = var_104_16.localEulerAngles

				var_104_22.z = 0
				var_104_22.x = 0
				var_104_16.localEulerAngles = var_104_22
			end

			if arg_101_1.time_ >= var_104_17 + var_104_18 and arg_101_1.time_ < var_104_17 + var_104_18 + arg_104_0 then
				var_104_16.localPosition = Vector3.New(0, 100, 0)

				local var_104_23 = manager.ui.mainCamera.transform.position - var_104_16.position

				var_104_16.forward = Vector3.New(var_104_23.x, var_104_23.y, var_104_23.z)

				local var_104_24 = var_104_16.localEulerAngles

				var_104_24.z = 0
				var_104_24.x = 0
				var_104_16.localEulerAngles = var_104_24
			end

			local var_104_25 = arg_101_1.bgs_.B13a
			local var_104_26 = 0

			if var_104_26 < arg_101_1.time_ and arg_101_1.time_ <= var_104_26 + arg_104_0 then
				local var_104_27 = var_104_25:GetComponent("SpriteRenderer")

				if var_104_27 then
					arg_101_1.var_.alphaOldValueB13a = var_104_27.color.a
					arg_101_1.var_.alphaMatValueB13a = var_104_27
				end

				arg_101_1.var_.alphaOldValueB13a = 1
			end

			local var_104_28 = 1.5

			if var_104_26 <= arg_101_1.time_ and arg_101_1.time_ < var_104_26 + var_104_28 then
				local var_104_29 = (arg_101_1.time_ - var_104_26) / var_104_28
				local var_104_30 = Mathf.Lerp(arg_101_1.var_.alphaOldValueB13a, 0, var_104_29)

				if arg_101_1.var_.alphaMatValueB13a then
					local var_104_31 = arg_101_1.var_.alphaMatValueB13a.color

					var_104_31.a = var_104_30
					arg_101_1.var_.alphaMatValueB13a.color = var_104_31
				end
			end

			if arg_101_1.time_ >= var_104_26 + var_104_28 and arg_101_1.time_ < var_104_26 + var_104_28 + arg_104_0 and arg_101_1.var_.alphaMatValueB13a then
				local var_104_32 = arg_101_1.var_.alphaMatValueB13a
				local var_104_33 = var_104_32.color

				var_104_33.a = 0
				var_104_32.color = var_104_33
			end

			local var_104_34 = arg_101_1.bgs_.ST02
			local var_104_35 = 1.5

			if var_104_35 < arg_101_1.time_ and arg_101_1.time_ <= var_104_35 + arg_104_0 then
				local var_104_36 = var_104_34:GetComponent("SpriteRenderer")

				if var_104_36 then
					arg_101_1.var_.alphaOldValueST02 = var_104_36.color.a
					arg_101_1.var_.alphaMatValueST02 = var_104_36
				end

				arg_101_1.var_.alphaOldValueST02 = 0
			end

			local var_104_37 = 1.5

			if var_104_35 <= arg_101_1.time_ and arg_101_1.time_ < var_104_35 + var_104_37 then
				local var_104_38 = (arg_101_1.time_ - var_104_35) / var_104_37
				local var_104_39 = Mathf.Lerp(arg_101_1.var_.alphaOldValueST02, 1, var_104_38)

				if arg_101_1.var_.alphaMatValueST02 then
					local var_104_40 = arg_101_1.var_.alphaMatValueST02.color

					var_104_40.a = var_104_39
					arg_101_1.var_.alphaMatValueST02.color = var_104_40
				end
			end

			if arg_101_1.time_ >= var_104_35 + var_104_37 and arg_101_1.time_ < var_104_35 + var_104_37 + arg_104_0 and arg_101_1.var_.alphaMatValueST02 then
				local var_104_41 = arg_101_1.var_.alphaMatValueST02
				local var_104_42 = var_104_41.color

				var_104_42.a = 1
				var_104_41.color = var_104_42
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_43 = 3.5
			local var_104_44 = 1.025

			if var_104_43 < arg_101_1.time_ and arg_101_1.time_ <= var_104_43 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_45 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_45:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_46 = arg_101_1:GetWordFromCfg(114804025)
				local var_104_47 = arg_101_1:FormatText(var_104_46.content)

				arg_101_1.text_.text = var_104_47

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_48 = 41
				local var_104_49 = utf8.len(var_104_47)
				local var_104_50 = var_104_48 <= 0 and var_104_44 or var_104_44 * (var_104_49 / var_104_48)

				if var_104_50 > 0 and var_104_44 < var_104_50 then
					arg_101_1.talkMaxDuration = var_104_50
					var_104_43 = var_104_43 + 0.3

					if var_104_50 + var_104_43 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_50 + var_104_43
					end
				end

				arg_101_1.text_.text = var_104_47
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_51 = var_104_43 + 0.3
			local var_104_52 = math.max(var_104_44, arg_101_1.talkMaxDuration)

			if var_104_51 <= arg_101_1.time_ and arg_101_1.time_ < var_104_51 + var_104_52 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_51) / var_104_52

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_51 + var_104_52 and arg_101_1.time_ < var_104_51 + var_104_52 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play114804026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114804026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play114804027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.7

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(114804026)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 28
				local var_110_5 = utf8.len(var_110_3)
				local var_110_6 = var_110_4 <= 0 and var_110_1 or var_110_1 * (var_110_5 / var_110_4)

				if var_110_6 > 0 and var_110_1 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_7 and arg_107_1.time_ < var_110_0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114804027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114804027
		arg_111_1.duration_ = 6.3

		local var_111_0 = {
			ja = 5.133,
			ko = 5.7,
			zh = 6.3,
			en = 5.4
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
				arg_111_0:Play114804028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1148ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1148ui_story = var_114_0.localPosition

				local var_114_2 = "1148ui_story"

				arg_111_1:ShowWeapon(arg_111_1.var_[var_114_2 .. "Animator"].transform, false)
			end

			local var_114_3 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_3 then
				local var_114_4 = (arg_111_1.time_ - var_114_1) / var_114_3
				local var_114_5 = Vector3.New(0, -0.8, -6.2)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1148ui_story, var_114_5, var_114_4)

				local var_114_6 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_6.x, var_114_6.y, var_114_6.z)

				local var_114_7 = var_114_0.localEulerAngles

				var_114_7.z = 0
				var_114_7.x = 0
				var_114_0.localEulerAngles = var_114_7
			end

			if arg_111_1.time_ >= var_114_1 + var_114_3 and arg_111_1.time_ < var_114_1 + var_114_3 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_114_8 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_8.x, var_114_8.y, var_114_8.z)

				local var_114_9 = var_114_0.localEulerAngles

				var_114_9.z = 0
				var_114_9.x = 0
				var_114_0.localEulerAngles = var_114_9
			end

			local var_114_10 = arg_111_1.actors_["1148ui_story"]
			local var_114_11 = 0

			if var_114_11 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 and not isNil(var_114_10) and arg_111_1.var_.characterEffect1148ui_story == nil then
				arg_111_1.var_.characterEffect1148ui_story = var_114_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_12 = 0.2

			if var_114_11 <= arg_111_1.time_ and arg_111_1.time_ < var_114_11 + var_114_12 and not isNil(var_114_10) then
				local var_114_13 = (arg_111_1.time_ - var_114_11) / var_114_12

				if arg_111_1.var_.characterEffect1148ui_story and not isNil(var_114_10) then
					arg_111_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_11 + var_114_12 and arg_111_1.time_ < var_114_11 + var_114_12 + arg_114_0 and not isNil(var_114_10) and arg_111_1.var_.characterEffect1148ui_story then
				arg_111_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_114_14 = 0.0166666666666667

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				arg_111_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			local var_114_15 = 0.0166666666666667

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_114_16 = 0
			local var_114_17 = 0.7

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_18 = arg_111_1:FormatText(StoryNameCfg[8].name)

				arg_111_1.leftNameTxt_.text = var_114_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_19 = arg_111_1:GetWordFromCfg(114804027)
				local var_114_20 = arg_111_1:FormatText(var_114_19.content)

				arg_111_1.text_.text = var_114_20

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_21 = 28
				local var_114_22 = utf8.len(var_114_20)
				local var_114_23 = var_114_21 <= 0 and var_114_17 or var_114_17 * (var_114_22 / var_114_21)

				if var_114_23 > 0 and var_114_17 < var_114_23 then
					arg_111_1.talkMaxDuration = var_114_23

					if var_114_23 + var_114_16 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_23 + var_114_16
					end
				end

				arg_111_1.text_.text = var_114_20
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804027", "story_v_side_old_114804.awb") ~= 0 then
					local var_114_24 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804027", "story_v_side_old_114804.awb") / 1000

					if var_114_24 + var_114_16 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_24 + var_114_16
					end

					if var_114_19.prefab_name ~= "" and arg_111_1.actors_[var_114_19.prefab_name] ~= nil then
						local var_114_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_19.prefab_name].transform, "story_v_side_old_114804", "114804027", "story_v_side_old_114804.awb")

						arg_111_1:RecordAudio("114804027", var_114_25)
						arg_111_1:RecordAudio("114804027", var_114_25)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804027", "story_v_side_old_114804.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804027", "story_v_side_old_114804.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_26 = math.max(var_114_17, arg_111_1.talkMaxDuration)

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_26 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_16) / var_114_26

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_16 + var_114_26 and arg_111_1.time_ < var_114_16 + var_114_26 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play114804028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114804028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play114804029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_2")
			end

			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_118_2 = 0
			local var_118_3 = 0.325

			if var_118_2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_4 = arg_115_1:GetWordFromCfg(114804028)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_6 = 13
				local var_118_7 = utf8.len(var_118_5)
				local var_118_8 = var_118_6 <= 0 and var_118_3 or var_118_3 * (var_118_7 / var_118_6)

				if var_118_8 > 0 and var_118_3 < var_118_8 then
					arg_115_1.talkMaxDuration = var_118_8

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_9 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_9 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_9

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_9 and arg_115_1.time_ < var_118_2 + var_118_9 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play114804029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114804029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play114804030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1148ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1148ui_story == nil then
				arg_119_1.var_.characterEffect1148ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.2

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1148ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1148ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1148ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1148ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_122_7 = 0
			local var_122_8 = 0.175

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_9 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_10 = arg_119_1:GetWordFromCfg(114804029)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_12 = 7
				local var_122_13 = utf8.len(var_122_11)
				local var_122_14 = var_122_12 <= 0 and var_122_8 or var_122_8 * (var_122_13 / var_122_12)

				if var_122_14 > 0 and var_122_8 < var_122_14 then
					arg_119_1.talkMaxDuration = var_122_14

					if var_122_14 + var_122_7 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_7
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_15 = math.max(var_122_8, arg_119_1.talkMaxDuration)

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_15 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_7) / var_122_15

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_7 + var_122_15 and arg_119_1.time_ < var_122_7 + var_122_15 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play114804030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114804030
		arg_123_1.duration_ = 3.8

		local var_123_0 = {
			ja = 1.999999999999,
			ko = 3.8,
			zh = 3.266,
			en = 3.166
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
				arg_123_0:Play114804031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1148ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1148ui_story == nil then
				arg_123_1.var_.characterEffect1148ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1148ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1148ui_story then
				arg_123_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_126_4 = 0

			if var_126_4 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_126_6 = 0
			local var_126_7 = 0.225

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_8 = arg_123_1:FormatText(StoryNameCfg[8].name)

				arg_123_1.leftNameTxt_.text = var_126_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_9 = arg_123_1:GetWordFromCfg(114804030)
				local var_126_10 = arg_123_1:FormatText(var_126_9.content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 9
				local var_126_12 = utf8.len(var_126_10)
				local var_126_13 = var_126_11 <= 0 and var_126_7 or var_126_7 * (var_126_12 / var_126_11)

				if var_126_13 > 0 and var_126_7 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804030", "story_v_side_old_114804.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804030", "story_v_side_old_114804.awb") / 1000

					if var_126_14 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_6
					end

					if var_126_9.prefab_name ~= "" and arg_123_1.actors_[var_126_9.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_9.prefab_name].transform, "story_v_side_old_114804", "114804030", "story_v_side_old_114804.awb")

						arg_123_1:RecordAudio("114804030", var_126_15)
						arg_123_1:RecordAudio("114804030", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804030", "story_v_side_old_114804.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804030", "story_v_side_old_114804.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_16 and arg_123_1.time_ < var_126_6 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play114804031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114804031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play114804032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1148ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1148ui_story == nil then
				arg_127_1.var_.characterEffect1148ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1148ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1148ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1148ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1148ui_story.fillRatio = var_130_5
			end

			local var_130_6 = 0

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_130_7 = 0
			local var_130_8 = 0.325

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_9 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_10 = arg_127_1:GetWordFromCfg(114804031)
				local var_130_11 = arg_127_1:FormatText(var_130_10.content)

				arg_127_1.text_.text = var_130_11

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_12 = 13
				local var_130_13 = utf8.len(var_130_11)
				local var_130_14 = var_130_12 <= 0 and var_130_8 or var_130_8 * (var_130_13 / var_130_12)

				if var_130_14 > 0 and var_130_8 < var_130_14 then
					arg_127_1.talkMaxDuration = var_130_14

					if var_130_14 + var_130_7 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_14 + var_130_7
					end
				end

				arg_127_1.text_.text = var_130_11
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_15 = math.max(var_130_8, arg_127_1.talkMaxDuration)

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_15 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_7) / var_130_15

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_7 + var_130_15 and arg_127_1.time_ < var_130_7 + var_130_15 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play114804032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114804032
		arg_131_1.duration_ = 10

		local var_131_0 = {
			ja = 10,
			ko = 5.5,
			zh = 4,
			en = 4.6
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
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play114804033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1148ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1148ui_story == nil then
				arg_131_1.var_.characterEffect1148ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1148ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1148ui_story then
				arg_131_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_134_4 = 0

			if var_134_4 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_134_6 = 0
			local var_134_7 = 0.5

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_8 = arg_131_1:FormatText(StoryNameCfg[8].name)

				arg_131_1.leftNameTxt_.text = var_134_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_9 = arg_131_1:GetWordFromCfg(114804032)
				local var_134_10 = arg_131_1:FormatText(var_134_9.content)

				arg_131_1.text_.text = var_134_10

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 20
				local var_134_12 = utf8.len(var_134_10)
				local var_134_13 = var_134_11 <= 0 and var_134_7 or var_134_7 * (var_134_12 / var_134_11)

				if var_134_13 > 0 and var_134_7 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_10
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804032", "story_v_side_old_114804.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804032", "story_v_side_old_114804.awb") / 1000

					if var_134_14 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_6
					end

					if var_134_9.prefab_name ~= "" and arg_131_1.actors_[var_134_9.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_9.prefab_name].transform, "story_v_side_old_114804", "114804032", "story_v_side_old_114804.awb")

						arg_131_1:RecordAudio("114804032", var_134_15)
						arg_131_1:RecordAudio("114804032", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804032", "story_v_side_old_114804.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804032", "story_v_side_old_114804.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_16 and arg_131_1.time_ < var_134_6 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play114804033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 114804033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play114804034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1148ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1148ui_story == nil then
				arg_135_1.var_.characterEffect1148ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1148ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1148ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1148ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1148ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_138_7 = 0
			local var_138_8 = 0.6

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_9 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_10 = arg_135_1:GetWordFromCfg(114804033)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_12 = 24
				local var_138_13 = utf8.len(var_138_11)
				local var_138_14 = var_138_12 <= 0 and var_138_8 or var_138_8 * (var_138_13 / var_138_12)

				if var_138_14 > 0 and var_138_8 < var_138_14 then
					arg_135_1.talkMaxDuration = var_138_14

					if var_138_14 + var_138_7 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_7
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_15 = math.max(var_138_8, arg_135_1.talkMaxDuration)

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_15 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_7) / var_138_15

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_7 + var_138_15 and arg_135_1.time_ < var_138_7 + var_138_15 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play114804034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114804034
		arg_139_1.duration_ = 4.87

		local var_139_0 = {
			ja = 4.166,
			ko = 4.866,
			zh = 3.266,
			en = 3.833
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
				arg_139_0:Play114804035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1148ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1148ui_story == nil then
				arg_139_1.var_.characterEffect1148ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1148ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1148ui_story then
				arg_139_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_142_4 = 0

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_142_5 = 0
			local var_142_6 = 0.4

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_7 = arg_139_1:FormatText(StoryNameCfg[8].name)

				arg_139_1.leftNameTxt_.text = var_142_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_8 = arg_139_1:GetWordFromCfg(114804034)
				local var_142_9 = arg_139_1:FormatText(var_142_8.content)

				arg_139_1.text_.text = var_142_9

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_10 = 16
				local var_142_11 = utf8.len(var_142_9)
				local var_142_12 = var_142_10 <= 0 and var_142_6 or var_142_6 * (var_142_11 / var_142_10)

				if var_142_12 > 0 and var_142_6 < var_142_12 then
					arg_139_1.talkMaxDuration = var_142_12

					if var_142_12 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_9
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804034", "story_v_side_old_114804.awb") ~= 0 then
					local var_142_13 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804034", "story_v_side_old_114804.awb") / 1000

					if var_142_13 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_5
					end

					if var_142_8.prefab_name ~= "" and arg_139_1.actors_[var_142_8.prefab_name] ~= nil then
						local var_142_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_8.prefab_name].transform, "story_v_side_old_114804", "114804034", "story_v_side_old_114804.awb")

						arg_139_1:RecordAudio("114804034", var_142_14)
						arg_139_1:RecordAudio("114804034", var_142_14)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804034", "story_v_side_old_114804.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804034", "story_v_side_old_114804.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_15 = math.max(var_142_6, arg_139_1.talkMaxDuration)

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_15 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_5) / var_142_15

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_5 + var_142_15 and arg_139_1.time_ < var_142_5 + var_142_15 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play114804035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114804035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play114804036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1148ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1148ui_story == nil then
				arg_143_1.var_.characterEffect1148ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.2

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1148ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1148ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1148ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1148ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_146_7 = 0
			local var_146_8 = 0.9

			if var_146_7 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_9 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_10 = arg_143_1:GetWordFromCfg(114804035)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_12 = 36
				local var_146_13 = utf8.len(var_146_11)
				local var_146_14 = var_146_12 <= 0 and var_146_8 or var_146_8 * (var_146_13 / var_146_12)

				if var_146_14 > 0 and var_146_8 < var_146_14 then
					arg_143_1.talkMaxDuration = var_146_14

					if var_146_14 + var_146_7 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_7
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_15 = math.max(var_146_8, arg_143_1.talkMaxDuration)

			if var_146_7 <= arg_143_1.time_ and arg_143_1.time_ < var_146_7 + var_146_15 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_7) / var_146_15

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_7 + var_146_15 and arg_143_1.time_ < var_146_7 + var_146_15 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play114804036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 114804036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play114804037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_150_2 = 0
			local var_150_3 = 0.725

			if var_150_2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(114804036)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_6 = 29
				local var_150_7 = utf8.len(var_150_5)
				local var_150_8 = var_150_6 <= 0 and var_150_3 or var_150_3 * (var_150_7 / var_150_6)

				if var_150_8 > 0 and var_150_3 < var_150_8 then
					arg_147_1.talkMaxDuration = var_150_8

					if var_150_8 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_9 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_9 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_9

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_9 and arg_147_1.time_ < var_150_2 + var_150_9 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play114804037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114804037
		arg_151_1.duration_ = 4.87

		local var_151_0 = {
			ja = 4.866,
			ko = 4.3,
			zh = 4.233,
			en = 4.6
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
				arg_151_0:Play114804038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1148ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1148ui_story == nil then
				arg_151_1.var_.characterEffect1148ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1148ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1148ui_story then
				arg_151_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_154_6 = 0
			local var_154_7 = 0.525

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[8].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_9 = arg_151_1:GetWordFromCfg(114804037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 21
				local var_154_12 = utf8.len(var_154_10)
				local var_154_13 = var_154_11 <= 0 and var_154_7 or var_154_7 * (var_154_12 / var_154_11)

				if var_154_13 > 0 and var_154_7 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804037", "story_v_side_old_114804.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804037", "story_v_side_old_114804.awb") / 1000

					if var_154_14 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_6
					end

					if var_154_9.prefab_name ~= "" and arg_151_1.actors_[var_154_9.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_9.prefab_name].transform, "story_v_side_old_114804", "114804037", "story_v_side_old_114804.awb")

						arg_151_1:RecordAudio("114804037", var_154_15)
						arg_151_1:RecordAudio("114804037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804037", "story_v_side_old_114804.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804037", "story_v_side_old_114804.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_16 and arg_151_1.time_ < var_154_6 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114804038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114804038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play114804039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1148ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1148ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0, 100, 0)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1148ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, 100, 0)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = 0
			local var_158_10 = 1

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				local var_158_11 = "play"
				local var_158_12 = "effect"

				arg_155_1:AudioAction(var_158_11, var_158_12, "se_story_side_1148", "se_story_1148_lamp", "")
			end

			local var_158_13 = 0
			local var_158_14 = 1.25

			if var_158_13 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_15 = arg_155_1:GetWordFromCfg(114804038)
				local var_158_16 = arg_155_1:FormatText(var_158_15.content)

				arg_155_1.text_.text = var_158_16

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_17 = 50
				local var_158_18 = utf8.len(var_158_16)
				local var_158_19 = var_158_17 <= 0 and var_158_14 or var_158_14 * (var_158_18 / var_158_17)

				if var_158_19 > 0 and var_158_14 < var_158_19 then
					arg_155_1.talkMaxDuration = var_158_19

					if var_158_19 + var_158_13 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_19 + var_158_13
					end
				end

				arg_155_1.text_.text = var_158_16
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_20 = math.max(var_158_14, arg_155_1.talkMaxDuration)

			if var_158_13 <= arg_155_1.time_ and arg_155_1.time_ < var_158_13 + var_158_20 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_13) / var_158_20

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_13 + var_158_20 and arg_155_1.time_ < var_158_13 + var_158_20 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play114804039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114804039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play114804040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 1.125

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(114804039)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 45
				local var_162_5 = utf8.len(var_162_3)
				local var_162_6 = var_162_4 <= 0 and var_162_1 or var_162_1 * (var_162_5 / var_162_4)

				if var_162_6 > 0 and var_162_1 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_7 and arg_159_1.time_ < var_162_0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play114804040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 114804040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play114804041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 1.425

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(114804040)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 57
				local var_166_5 = utf8.len(var_166_3)
				local var_166_6 = var_166_4 <= 0 and var_166_1 or var_166_1 * (var_166_5 / var_166_4)

				if var_166_6 > 0 and var_166_1 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_7 and arg_163_1.time_ < var_166_0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play114804041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 114804041
		arg_167_1.duration_ = 4.37

		local var_167_0 = {
			ja = 3.366,
			ko = 4.3,
			zh = 3.9,
			en = 4.366
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
				arg_167_0:Play114804042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.225

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[36].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(114804041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 9
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804041", "story_v_side_old_114804.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804041", "story_v_side_old_114804.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_side_old_114804", "114804041", "story_v_side_old_114804.awb")

						arg_167_1:RecordAudio("114804041", var_170_9)
						arg_167_1:RecordAudio("114804041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804041", "story_v_side_old_114804.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804041", "story_v_side_old_114804.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play114804042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 114804042
		arg_171_1.duration_ = 2

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play114804043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1148ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1148ui_story = var_174_0.localPosition

				local var_174_2 = "1148ui_story"

				arg_171_1:ShowWeapon(arg_171_1.var_[var_174_2 .. "Animator"].transform, false)
			end

			local var_174_3 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_3 then
				local var_174_4 = (arg_171_1.time_ - var_174_1) / var_174_3
				local var_174_5 = Vector3.New(0, -0.8, -6.2)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1148ui_story, var_174_5, var_174_4)

				local var_174_6 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_6.x, var_174_6.y, var_174_6.z)

				local var_174_7 = var_174_0.localEulerAngles

				var_174_7.z = 0
				var_174_7.x = 0
				var_174_0.localEulerAngles = var_174_7
			end

			if arg_171_1.time_ >= var_174_1 + var_174_3 and arg_171_1.time_ < var_174_1 + var_174_3 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_174_8 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_8.x, var_174_8.y, var_174_8.z)

				local var_174_9 = var_174_0.localEulerAngles

				var_174_9.z = 0
				var_174_9.x = 0
				var_174_0.localEulerAngles = var_174_9
			end

			local var_174_10 = 0.0166666666666667

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			local var_174_11 = arg_171_1.actors_["1148ui_story"]
			local var_174_12 = 0

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 and not isNil(var_174_11) and arg_171_1.var_.characterEffect1148ui_story == nil then
				arg_171_1.var_.characterEffect1148ui_story = var_174_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_13 = 0.2

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_13 and not isNil(var_174_11) then
				local var_174_14 = (arg_171_1.time_ - var_174_12) / var_174_13

				if arg_171_1.var_.characterEffect1148ui_story and not isNil(var_174_11) then
					arg_171_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_12 + var_174_13 and arg_171_1.time_ < var_174_12 + var_174_13 + arg_174_0 and not isNil(var_174_11) and arg_171_1.var_.characterEffect1148ui_story then
				arg_171_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_174_15 = 0.0166666666666667

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_174_16 = 0
			local var_174_17 = 0.075

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_18 = arg_171_1:FormatText(StoryNameCfg[8].name)

				arg_171_1.leftNameTxt_.text = var_174_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_19 = arg_171_1:GetWordFromCfg(114804042)
				local var_174_20 = arg_171_1:FormatText(var_174_19.content)

				arg_171_1.text_.text = var_174_20

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_21 = 3
				local var_174_22 = utf8.len(var_174_20)
				local var_174_23 = var_174_21 <= 0 and var_174_17 or var_174_17 * (var_174_22 / var_174_21)

				if var_174_23 > 0 and var_174_17 < var_174_23 then
					arg_171_1.talkMaxDuration = var_174_23

					if var_174_23 + var_174_16 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_16
					end
				end

				arg_171_1.text_.text = var_174_20
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804042", "story_v_side_old_114804.awb") ~= 0 then
					local var_174_24 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804042", "story_v_side_old_114804.awb") / 1000

					if var_174_24 + var_174_16 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_24 + var_174_16
					end

					if var_174_19.prefab_name ~= "" and arg_171_1.actors_[var_174_19.prefab_name] ~= nil then
						local var_174_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_19.prefab_name].transform, "story_v_side_old_114804", "114804042", "story_v_side_old_114804.awb")

						arg_171_1:RecordAudio("114804042", var_174_25)
						arg_171_1:RecordAudio("114804042", var_174_25)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804042", "story_v_side_old_114804.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804042", "story_v_side_old_114804.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_26 = math.max(var_174_17, arg_171_1.talkMaxDuration)

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_26 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_16) / var_174_26

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_16 + var_174_26 and arg_171_1.time_ < var_174_16 + var_174_26 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play114804043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 114804043
		arg_175_1.duration_ = 10

		local var_175_0 = {
			ja = 10,
			ko = 4.766,
			zh = 7.166,
			en = 7.166
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
				arg_175_0:Play114804044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1148ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1148ui_story == nil then
				arg_175_1.var_.characterEffect1148ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1148ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1148ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1148ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1148ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_178_7 = 0
			local var_178_8 = 0.35

			if var_178_7 < arg_175_1.time_ and arg_175_1.time_ <= var_178_7 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_9 = arg_175_1:FormatText(StoryNameCfg[36].name)

				arg_175_1.leftNameTxt_.text = var_178_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(114804043)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_12 = 14
				local var_178_13 = utf8.len(var_178_11)
				local var_178_14 = var_178_12 <= 0 and var_178_8 or var_178_8 * (var_178_13 / var_178_12)

				if var_178_14 > 0 and var_178_8 < var_178_14 then
					arg_175_1.talkMaxDuration = var_178_14

					if var_178_14 + var_178_7 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_7
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804043", "story_v_side_old_114804.awb") ~= 0 then
					local var_178_15 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804043", "story_v_side_old_114804.awb") / 1000

					if var_178_15 + var_178_7 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_15 + var_178_7
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_side_old_114804", "114804043", "story_v_side_old_114804.awb")

						arg_175_1:RecordAudio("114804043", var_178_16)
						arg_175_1:RecordAudio("114804043", var_178_16)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804043", "story_v_side_old_114804.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804043", "story_v_side_old_114804.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_17 = math.max(var_178_8, arg_175_1.talkMaxDuration)

			if var_178_7 <= arg_175_1.time_ and arg_175_1.time_ < var_178_7 + var_178_17 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_7) / var_178_17

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_7 + var_178_17 and arg_175_1.time_ < var_178_7 + var_178_17 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play114804044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 114804044
		arg_179_1.duration_ = 6.1

		local var_179_0 = {
			ja = 6.1,
			ko = 5.166,
			zh = 3.533,
			en = 3.466
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
				arg_179_0:Play114804045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1148ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1148ui_story == nil then
				arg_179_1.var_.characterEffect1148ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1148ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1148ui_story then
				arg_179_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_182_4 = 0

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_182_5 = 0
			local var_182_6 = 0.325

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_7 = arg_179_1:FormatText(StoryNameCfg[8].name)

				arg_179_1.leftNameTxt_.text = var_182_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_8 = arg_179_1:GetWordFromCfg(114804044)
				local var_182_9 = arg_179_1:FormatText(var_182_8.content)

				arg_179_1.text_.text = var_182_9

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 13
				local var_182_11 = utf8.len(var_182_9)
				local var_182_12 = var_182_10 <= 0 and var_182_6 or var_182_6 * (var_182_11 / var_182_10)

				if var_182_12 > 0 and var_182_6 < var_182_12 then
					arg_179_1.talkMaxDuration = var_182_12

					if var_182_12 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_9
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804044", "story_v_side_old_114804.awb") ~= 0 then
					local var_182_13 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804044", "story_v_side_old_114804.awb") / 1000

					if var_182_13 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_5
					end

					if var_182_8.prefab_name ~= "" and arg_179_1.actors_[var_182_8.prefab_name] ~= nil then
						local var_182_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_8.prefab_name].transform, "story_v_side_old_114804", "114804044", "story_v_side_old_114804.awb")

						arg_179_1:RecordAudio("114804044", var_182_14)
						arg_179_1:RecordAudio("114804044", var_182_14)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804044", "story_v_side_old_114804.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804044", "story_v_side_old_114804.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_15 = math.max(var_182_6, arg_179_1.talkMaxDuration)

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_15 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_5) / var_182_15

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_5 + var_182_15 and arg_179_1.time_ < var_182_5 + var_182_15 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play114804045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 114804045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play114804046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1148ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1148ui_story == nil then
				arg_183_1.var_.characterEffect1148ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1148ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1148ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1148ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1148ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_186_7 = 0
			local var_186_8 = 0.775

			if var_186_7 < arg_183_1.time_ and arg_183_1.time_ <= var_186_7 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_9 = arg_183_1:GetWordFromCfg(114804045)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 31
				local var_186_12 = utf8.len(var_186_10)
				local var_186_13 = var_186_11 <= 0 and var_186_8 or var_186_8 * (var_186_12 / var_186_11)

				if var_186_13 > 0 and var_186_8 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_7 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_7
					end
				end

				arg_183_1.text_.text = var_186_10
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_8, arg_183_1.talkMaxDuration)

			if var_186_7 <= arg_183_1.time_ and arg_183_1.time_ < var_186_7 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_7) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_7 + var_186_14 and arg_183_1.time_ < var_186_7 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play114804046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 114804046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play114804047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_190_1 = 0
			local var_190_2 = 1

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:GetWordFromCfg(114804046)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 40
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_2 or var_190_2 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_2 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_8 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_8 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_8

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_8 and arg_187_1.time_ < var_190_1 + var_190_8 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play114804047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 114804047
		arg_191_1.duration_ = 13.63

		local var_191_0 = {
			ja = 3.066,
			ko = 9.766,
			zh = 11.133,
			en = 13.633
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
				arg_191_0:Play114804048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_194_1 = 0
			local var_194_2 = 0.525

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_3 = arg_191_1:FormatText(StoryNameCfg[36].name)

				arg_191_1.leftNameTxt_.text = var_194_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(114804047)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_6 = 21
				local var_194_7 = utf8.len(var_194_5)
				local var_194_8 = var_194_6 <= 0 and var_194_2 or var_194_2 * (var_194_7 / var_194_6)

				if var_194_8 > 0 and var_194_2 < var_194_8 then
					arg_191_1.talkMaxDuration = var_194_8

					if var_194_8 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804047", "story_v_side_old_114804.awb") ~= 0 then
					local var_194_9 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804047", "story_v_side_old_114804.awb") / 1000

					if var_194_9 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_1
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_side_old_114804", "114804047", "story_v_side_old_114804.awb")

						arg_191_1:RecordAudio("114804047", var_194_10)
						arg_191_1:RecordAudio("114804047", var_194_10)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804047", "story_v_side_old_114804.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804047", "story_v_side_old_114804.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_11 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_11 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_11

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_11 and arg_191_1.time_ < var_194_1 + var_194_11 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play114804048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 114804048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play114804049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action427")
			end

			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_198_2 = 0
			local var_198_3 = 1.275

			if var_198_2 < arg_195_1.time_ and arg_195_1.time_ <= var_198_2 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_4 = arg_195_1:GetWordFromCfg(114804048)
				local var_198_5 = arg_195_1:FormatText(var_198_4.content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_6 = 51
				local var_198_7 = utf8.len(var_198_5)
				local var_198_8 = var_198_6 <= 0 and var_198_3 or var_198_3 * (var_198_7 / var_198_6)

				if var_198_8 > 0 and var_198_3 < var_198_8 then
					arg_195_1.talkMaxDuration = var_198_8

					if var_198_8 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_2
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_9 = math.max(var_198_3, arg_195_1.talkMaxDuration)

			if var_198_2 <= arg_195_1.time_ and arg_195_1.time_ < var_198_2 + var_198_9 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_2) / var_198_9

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_2 + var_198_9 and arg_195_1.time_ < var_198_2 + var_198_9 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play114804049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 114804049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play114804050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_202_1 = 0
			local var_202_2 = 0.725

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:GetWordFromCfg(114804049)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 29
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_2 or var_202_2 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_2 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_8 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_8 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_8

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_8 and arg_199_1.time_ < var_202_1 + var_202_8 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play114804050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 114804050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play114804051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_206_1 = 0
			local var_206_2 = 0.6

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(114804050)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 24
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_2 or var_206_2 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_2 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_8 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_8 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_8

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_8 and arg_203_1.time_ < var_206_1 + var_206_8 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play114804051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 114804051
		arg_207_1.duration_ = 12

		local var_207_0 = {
			ja = 12,
			ko = 11.933,
			zh = 9.4,
			en = 9.733
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
				arg_207_0:Play114804052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1148ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1148ui_story = var_210_0.localPosition

				local var_210_2 = "1148ui_story"

				arg_207_1:ShowWeapon(arg_207_1.var_[var_210_2 .. "Animator"].transform, false)
			end

			local var_210_3 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_3 then
				local var_210_4 = (arg_207_1.time_ - var_210_1) / var_210_3
				local var_210_5 = Vector3.New(0, 100, 0)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1148ui_story, var_210_5, var_210_4)

				local var_210_6 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_6.x, var_210_6.y, var_210_6.z)

				local var_210_7 = var_210_0.localEulerAngles

				var_210_7.z = 0
				var_210_7.x = 0
				var_210_0.localEulerAngles = var_210_7
			end

			if arg_207_1.time_ >= var_210_1 + var_210_3 and arg_207_1.time_ < var_210_1 + var_210_3 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, 100, 0)

				local var_210_8 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_8.x, var_210_8.y, var_210_8.z)

				local var_210_9 = var_210_0.localEulerAngles

				var_210_9.z = 0
				var_210_9.x = 0
				var_210_0.localEulerAngles = var_210_9
			end

			local var_210_10 = arg_207_1.actors_["1019ui_story"].transform
			local var_210_11 = 0

			if var_210_11 < arg_207_1.time_ and arg_207_1.time_ <= var_210_11 + arg_210_0 then
				arg_207_1.var_.moveOldPos1019ui_story = var_210_10.localPosition

				local var_210_12 = "1019ui_story"

				arg_207_1:ShowWeapon(arg_207_1.var_[var_210_12 .. "Animator"].transform, false)
			end

			local var_210_13 = 0.001

			if var_210_11 <= arg_207_1.time_ and arg_207_1.time_ < var_210_11 + var_210_13 then
				local var_210_14 = (arg_207_1.time_ - var_210_11) / var_210_13
				local var_210_15 = Vector3.New(-0.2, -1.08, -5.9)

				var_210_10.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1019ui_story, var_210_15, var_210_14)

				local var_210_16 = manager.ui.mainCamera.transform.position - var_210_10.position

				var_210_10.forward = Vector3.New(var_210_16.x, var_210_16.y, var_210_16.z)

				local var_210_17 = var_210_10.localEulerAngles

				var_210_17.z = 0
				var_210_17.x = 0
				var_210_10.localEulerAngles = var_210_17
			end

			if arg_207_1.time_ >= var_210_11 + var_210_13 and arg_207_1.time_ < var_210_11 + var_210_13 + arg_210_0 then
				var_210_10.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_210_18 = manager.ui.mainCamera.transform.position - var_210_10.position

				var_210_10.forward = Vector3.New(var_210_18.x, var_210_18.y, var_210_18.z)

				local var_210_19 = var_210_10.localEulerAngles

				var_210_19.z = 0
				var_210_19.x = 0
				var_210_10.localEulerAngles = var_210_19
			end

			local var_210_20 = arg_207_1.actors_["1019ui_story"]
			local var_210_21 = 0

			if var_210_21 < arg_207_1.time_ and arg_207_1.time_ <= var_210_21 + arg_210_0 and not isNil(var_210_20) and arg_207_1.var_.characterEffect1019ui_story == nil then
				arg_207_1.var_.characterEffect1019ui_story = var_210_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_22 = 0.2

			if var_210_21 <= arg_207_1.time_ and arg_207_1.time_ < var_210_21 + var_210_22 and not isNil(var_210_20) then
				local var_210_23 = (arg_207_1.time_ - var_210_21) / var_210_22

				if arg_207_1.var_.characterEffect1019ui_story and not isNil(var_210_20) then
					arg_207_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_21 + var_210_22 and arg_207_1.time_ < var_210_21 + var_210_22 + arg_210_0 and not isNil(var_210_20) and arg_207_1.var_.characterEffect1019ui_story then
				arg_207_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_210_24 = 0.0166666666666667

			if var_210_24 < arg_207_1.time_ and arg_207_1.time_ <= var_210_24 + arg_210_0 then
				arg_207_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action3_1")
			end

			local var_210_25 = 0.0166666666666667

			if var_210_25 < arg_207_1.time_ and arg_207_1.time_ <= var_210_25 + arg_210_0 then
				arg_207_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_210_26 = 0
			local var_210_27 = 1.075

			if var_210_26 < arg_207_1.time_ and arg_207_1.time_ <= var_210_26 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_28 = arg_207_1:FormatText(StoryNameCfg[13].name)

				arg_207_1.leftNameTxt_.text = var_210_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_29 = arg_207_1:GetWordFromCfg(114804051)
				local var_210_30 = arg_207_1:FormatText(var_210_29.content)

				arg_207_1.text_.text = var_210_30

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_31 = 43
				local var_210_32 = utf8.len(var_210_30)
				local var_210_33 = var_210_31 <= 0 and var_210_27 or var_210_27 * (var_210_32 / var_210_31)

				if var_210_33 > 0 and var_210_27 < var_210_33 then
					arg_207_1.talkMaxDuration = var_210_33

					if var_210_33 + var_210_26 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_33 + var_210_26
					end
				end

				arg_207_1.text_.text = var_210_30
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804051", "story_v_side_old_114804.awb") ~= 0 then
					local var_210_34 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804051", "story_v_side_old_114804.awb") / 1000

					if var_210_34 + var_210_26 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_34 + var_210_26
					end

					if var_210_29.prefab_name ~= "" and arg_207_1.actors_[var_210_29.prefab_name] ~= nil then
						local var_210_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_29.prefab_name].transform, "story_v_side_old_114804", "114804051", "story_v_side_old_114804.awb")

						arg_207_1:RecordAudio("114804051", var_210_35)
						arg_207_1:RecordAudio("114804051", var_210_35)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804051", "story_v_side_old_114804.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804051", "story_v_side_old_114804.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_36 = math.max(var_210_27, arg_207_1.talkMaxDuration)

			if var_210_26 <= arg_207_1.time_ and arg_207_1.time_ < var_210_26 + var_210_36 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_26) / var_210_36

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_26 + var_210_36 and arg_207_1.time_ < var_210_26 + var_210_36 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play114804052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 114804052
		arg_211_1.duration_ = 7.47

		local var_211_0 = {
			ja = 7.466,
			ko = 6.333,
			zh = 5,
			en = 5.066
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play114804053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1019ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1019ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1019ui_story, var_214_4, var_214_3)

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

			local var_214_9 = "1066ui_story"

			if arg_211_1.actors_[var_214_9] == nil then
				local var_214_10 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_214_10) then
					local var_214_11 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_211_1.stage_.transform)

					var_214_11.name = var_214_9
					var_214_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_211_1.actors_[var_214_9] = var_214_11

					local var_214_12 = var_214_11:GetComponentInChildren(typeof(CharacterEffect))

					var_214_12.enabled = true

					local var_214_13 = GameObjectTools.GetOrAddComponent(var_214_11, typeof(DynamicBoneHelper))

					if var_214_13 then
						var_214_13:EnableDynamicBone(false)
					end

					arg_211_1:ShowWeapon(var_214_12.transform, false)

					arg_211_1.var_[var_214_9 .. "Animator"] = var_214_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_211_1.var_[var_214_9 .. "Animator"].applyRootMotion = true
					arg_211_1.var_[var_214_9 .. "LipSync"] = var_214_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_214_14 = arg_211_1.actors_["1066ui_story"].transform
			local var_214_15 = 0

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1.var_.moveOldPos1066ui_story = var_214_14.localPosition

				local var_214_16 = "1066ui_story"

				arg_211_1:ShowWeapon(arg_211_1.var_[var_214_16 .. "Animator"].transform, false)
			end

			local var_214_17 = 0.001

			if var_214_15 <= arg_211_1.time_ and arg_211_1.time_ < var_214_15 + var_214_17 then
				local var_214_18 = (arg_211_1.time_ - var_214_15) / var_214_17
				local var_214_19 = Vector3.New(0, -0.77, -6.1)

				var_214_14.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1066ui_story, var_214_19, var_214_18)

				local var_214_20 = manager.ui.mainCamera.transform.position - var_214_14.position

				var_214_14.forward = Vector3.New(var_214_20.x, var_214_20.y, var_214_20.z)

				local var_214_21 = var_214_14.localEulerAngles

				var_214_21.z = 0
				var_214_21.x = 0
				var_214_14.localEulerAngles = var_214_21
			end

			if arg_211_1.time_ >= var_214_15 + var_214_17 and arg_211_1.time_ < var_214_15 + var_214_17 + arg_214_0 then
				var_214_14.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_214_22 = manager.ui.mainCamera.transform.position - var_214_14.position

				var_214_14.forward = Vector3.New(var_214_22.x, var_214_22.y, var_214_22.z)

				local var_214_23 = var_214_14.localEulerAngles

				var_214_23.z = 0
				var_214_23.x = 0
				var_214_14.localEulerAngles = var_214_23
			end

			local var_214_24 = arg_211_1.actors_["1066ui_story"]
			local var_214_25 = 0

			if var_214_25 < arg_211_1.time_ and arg_211_1.time_ <= var_214_25 + arg_214_0 and not isNil(var_214_24) and arg_211_1.var_.characterEffect1066ui_story == nil then
				arg_211_1.var_.characterEffect1066ui_story = var_214_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_26 = 0.2

			if var_214_25 <= arg_211_1.time_ and arg_211_1.time_ < var_214_25 + var_214_26 and not isNil(var_214_24) then
				local var_214_27 = (arg_211_1.time_ - var_214_25) / var_214_26

				if arg_211_1.var_.characterEffect1066ui_story and not isNil(var_214_24) then
					arg_211_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_25 + var_214_26 and arg_211_1.time_ < var_214_25 + var_214_26 + arg_214_0 and not isNil(var_214_24) and arg_211_1.var_.characterEffect1066ui_story then
				arg_211_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_214_28 = 0.0166666666666667

			if var_214_28 < arg_211_1.time_ and arg_211_1.time_ <= var_214_28 + arg_214_0 then
				arg_211_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_214_29 = 0.0166666666666667

			if var_214_29 < arg_211_1.time_ and arg_211_1.time_ <= var_214_29 + arg_214_0 then
				arg_211_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_214_30 = 0
			local var_214_31 = 0.625

			if var_214_30 < arg_211_1.time_ and arg_211_1.time_ <= var_214_30 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_32 = arg_211_1:FormatText(StoryNameCfg[32].name)

				arg_211_1.leftNameTxt_.text = var_214_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_33 = arg_211_1:GetWordFromCfg(114804052)
				local var_214_34 = arg_211_1:FormatText(var_214_33.content)

				arg_211_1.text_.text = var_214_34

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_35 = 25
				local var_214_36 = utf8.len(var_214_34)
				local var_214_37 = var_214_35 <= 0 and var_214_31 or var_214_31 * (var_214_36 / var_214_35)

				if var_214_37 > 0 and var_214_31 < var_214_37 then
					arg_211_1.talkMaxDuration = var_214_37

					if var_214_37 + var_214_30 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_37 + var_214_30
					end
				end

				arg_211_1.text_.text = var_214_34
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804052", "story_v_side_old_114804.awb") ~= 0 then
					local var_214_38 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804052", "story_v_side_old_114804.awb") / 1000

					if var_214_38 + var_214_30 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_38 + var_214_30
					end

					if var_214_33.prefab_name ~= "" and arg_211_1.actors_[var_214_33.prefab_name] ~= nil then
						local var_214_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_33.prefab_name].transform, "story_v_side_old_114804", "114804052", "story_v_side_old_114804.awb")

						arg_211_1:RecordAudio("114804052", var_214_39)
						arg_211_1:RecordAudio("114804052", var_214_39)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804052", "story_v_side_old_114804.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804052", "story_v_side_old_114804.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_40 = math.max(var_214_31, arg_211_1.talkMaxDuration)

			if var_214_30 <= arg_211_1.time_ and arg_211_1.time_ < var_214_30 + var_214_40 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_30) / var_214_40

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_30 + var_214_40 and arg_211_1.time_ < var_214_30 + var_214_40 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play114804053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 114804053
		arg_215_1.duration_ = 8.37

		local var_215_0 = {
			ja = 8.366,
			ko = 6.6,
			zh = 5.466,
			en = 5.9
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play114804054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1066ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1066ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, 100, 0)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1066ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, 100, 0)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = "1039ui_story"

			if arg_215_1.actors_[var_218_9] == nil then
				local var_218_10 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_218_10) then
					local var_218_11 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_215_1.stage_.transform)

					var_218_11.name = var_218_9
					var_218_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_215_1.actors_[var_218_9] = var_218_11

					local var_218_12 = var_218_11:GetComponentInChildren(typeof(CharacterEffect))

					var_218_12.enabled = true

					local var_218_13 = GameObjectTools.GetOrAddComponent(var_218_11, typeof(DynamicBoneHelper))

					if var_218_13 then
						var_218_13:EnableDynamicBone(false)
					end

					arg_215_1:ShowWeapon(var_218_12.transform, false)

					arg_215_1.var_[var_218_9 .. "Animator"] = var_218_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_215_1.var_[var_218_9 .. "Animator"].applyRootMotion = true
					arg_215_1.var_[var_218_9 .. "LipSync"] = var_218_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_218_14 = arg_215_1.actors_["1039ui_story"].transform
			local var_218_15 = 0

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.var_.moveOldPos1039ui_story = var_218_14.localPosition

				local var_218_16 = "1039ui_story"

				arg_215_1:ShowWeapon(arg_215_1.var_[var_218_16 .. "Animator"].transform, false)
			end

			local var_218_17 = 0.001

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_17 then
				local var_218_18 = (arg_215_1.time_ - var_218_15) / var_218_17
				local var_218_19 = Vector3.New(0, -1.01, -5.9)

				var_218_14.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1039ui_story, var_218_19, var_218_18)

				local var_218_20 = manager.ui.mainCamera.transform.position - var_218_14.position

				var_218_14.forward = Vector3.New(var_218_20.x, var_218_20.y, var_218_20.z)

				local var_218_21 = var_218_14.localEulerAngles

				var_218_21.z = 0
				var_218_21.x = 0
				var_218_14.localEulerAngles = var_218_21
			end

			if arg_215_1.time_ >= var_218_15 + var_218_17 and arg_215_1.time_ < var_218_15 + var_218_17 + arg_218_0 then
				var_218_14.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_218_22 = manager.ui.mainCamera.transform.position - var_218_14.position

				var_218_14.forward = Vector3.New(var_218_22.x, var_218_22.y, var_218_22.z)

				local var_218_23 = var_218_14.localEulerAngles

				var_218_23.z = 0
				var_218_23.x = 0
				var_218_14.localEulerAngles = var_218_23
			end

			local var_218_24 = arg_215_1.actors_["1039ui_story"]
			local var_218_25 = 0

			if var_218_25 < arg_215_1.time_ and arg_215_1.time_ <= var_218_25 + arg_218_0 and not isNil(var_218_24) and arg_215_1.var_.characterEffect1039ui_story == nil then
				arg_215_1.var_.characterEffect1039ui_story = var_218_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_26 = 0.2

			if var_218_25 <= arg_215_1.time_ and arg_215_1.time_ < var_218_25 + var_218_26 and not isNil(var_218_24) then
				local var_218_27 = (arg_215_1.time_ - var_218_25) / var_218_26

				if arg_215_1.var_.characterEffect1039ui_story and not isNil(var_218_24) then
					arg_215_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_25 + var_218_26 and arg_215_1.time_ < var_218_25 + var_218_26 + arg_218_0 and not isNil(var_218_24) and arg_215_1.var_.characterEffect1039ui_story then
				arg_215_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_218_28 = 0.0166666666666667

			if var_218_28 < arg_215_1.time_ and arg_215_1.time_ <= var_218_28 + arg_218_0 then
				arg_215_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			local var_218_29 = 0.0166666666666667

			if var_218_29 < arg_215_1.time_ and arg_215_1.time_ <= var_218_29 + arg_218_0 then
				arg_215_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_218_30 = 0
			local var_218_31 = 0.675

			if var_218_30 < arg_215_1.time_ and arg_215_1.time_ <= var_218_30 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_32 = arg_215_1:FormatText(StoryNameCfg[9].name)

				arg_215_1.leftNameTxt_.text = var_218_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_33 = arg_215_1:GetWordFromCfg(114804053)
				local var_218_34 = arg_215_1:FormatText(var_218_33.content)

				arg_215_1.text_.text = var_218_34

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_35 = 27
				local var_218_36 = utf8.len(var_218_34)
				local var_218_37 = var_218_35 <= 0 and var_218_31 or var_218_31 * (var_218_36 / var_218_35)

				if var_218_37 > 0 and var_218_31 < var_218_37 then
					arg_215_1.talkMaxDuration = var_218_37

					if var_218_37 + var_218_30 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_37 + var_218_30
					end
				end

				arg_215_1.text_.text = var_218_34
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804053", "story_v_side_old_114804.awb") ~= 0 then
					local var_218_38 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804053", "story_v_side_old_114804.awb") / 1000

					if var_218_38 + var_218_30 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_38 + var_218_30
					end

					if var_218_33.prefab_name ~= "" and arg_215_1.actors_[var_218_33.prefab_name] ~= nil then
						local var_218_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_33.prefab_name].transform, "story_v_side_old_114804", "114804053", "story_v_side_old_114804.awb")

						arg_215_1:RecordAudio("114804053", var_218_39)
						arg_215_1:RecordAudio("114804053", var_218_39)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804053", "story_v_side_old_114804.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804053", "story_v_side_old_114804.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_40 = math.max(var_218_31, arg_215_1.talkMaxDuration)

			if var_218_30 <= arg_215_1.time_ and arg_215_1.time_ < var_218_30 + var_218_40 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_30) / var_218_40

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_30 + var_218_40 and arg_215_1.time_ < var_218_30 + var_218_40 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play114804054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 114804054
		arg_219_1.duration_ = 4.2

		local var_219_0 = {
			ja = 4.2,
			ko = 2.9,
			zh = 2.6,
			en = 4
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play114804055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1039ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1039ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0, 100, 0)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1039ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, 100, 0)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = "1084ui_story"

			if arg_219_1.actors_[var_222_9] == nil then
				local var_222_10 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_222_10) then
					local var_222_11 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_219_1.stage_.transform)

					var_222_11.name = var_222_9
					var_222_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_219_1.actors_[var_222_9] = var_222_11

					local var_222_12 = var_222_11:GetComponentInChildren(typeof(CharacterEffect))

					var_222_12.enabled = true

					local var_222_13 = GameObjectTools.GetOrAddComponent(var_222_11, typeof(DynamicBoneHelper))

					if var_222_13 then
						var_222_13:EnableDynamicBone(false)
					end

					arg_219_1:ShowWeapon(var_222_12.transform, false)

					arg_219_1.var_[var_222_9 .. "Animator"] = var_222_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_219_1.var_[var_222_9 .. "Animator"].applyRootMotion = true
					arg_219_1.var_[var_222_9 .. "LipSync"] = var_222_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_222_14 = arg_219_1.actors_["1084ui_story"].transform
			local var_222_15 = 0

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.var_.moveOldPos1084ui_story = var_222_14.localPosition

				local var_222_16 = "1084ui_story"

				arg_219_1:ShowWeapon(arg_219_1.var_[var_222_16 .. "Animator"].transform, false)
			end

			local var_222_17 = 0.001

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_17 then
				local var_222_18 = (arg_219_1.time_ - var_222_15) / var_222_17
				local var_222_19 = Vector3.New(0, -0.97, -6)

				var_222_14.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1084ui_story, var_222_19, var_222_18)

				local var_222_20 = manager.ui.mainCamera.transform.position - var_222_14.position

				var_222_14.forward = Vector3.New(var_222_20.x, var_222_20.y, var_222_20.z)

				local var_222_21 = var_222_14.localEulerAngles

				var_222_21.z = 0
				var_222_21.x = 0
				var_222_14.localEulerAngles = var_222_21
			end

			if arg_219_1.time_ >= var_222_15 + var_222_17 and arg_219_1.time_ < var_222_15 + var_222_17 + arg_222_0 then
				var_222_14.localPosition = Vector3.New(0, -0.97, -6)

				local var_222_22 = manager.ui.mainCamera.transform.position - var_222_14.position

				var_222_14.forward = Vector3.New(var_222_22.x, var_222_22.y, var_222_22.z)

				local var_222_23 = var_222_14.localEulerAngles

				var_222_23.z = 0
				var_222_23.x = 0
				var_222_14.localEulerAngles = var_222_23
			end

			local var_222_24 = arg_219_1.actors_["1084ui_story"]
			local var_222_25 = 0

			if var_222_25 < arg_219_1.time_ and arg_219_1.time_ <= var_222_25 + arg_222_0 and not isNil(var_222_24) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = var_222_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_26 = 0.2

			if var_222_25 <= arg_219_1.time_ and arg_219_1.time_ < var_222_25 + var_222_26 and not isNil(var_222_24) then
				local var_222_27 = (arg_219_1.time_ - var_222_25) / var_222_26

				if arg_219_1.var_.characterEffect1084ui_story and not isNil(var_222_24) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_25 + var_222_26 and arg_219_1.time_ < var_222_25 + var_222_26 + arg_222_0 and not isNil(var_222_24) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_222_28 = 0.0166666666666667

			if var_222_28 < arg_219_1.time_ and arg_219_1.time_ <= var_222_28 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_222_29 = 0.0166666666666667

			if var_222_29 < arg_219_1.time_ and arg_219_1.time_ <= var_222_29 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_222_30 = 0
			local var_222_31 = 2.01666666666667

			if var_222_30 < arg_219_1.time_ and arg_219_1.time_ <= var_222_30 + arg_222_0 then
				local var_222_32 = "play"
				local var_222_33 = "music"

				arg_219_1:AudioAction(var_222_32, var_222_33, "bgm_side_daily06", "bgm_side_daily06", "bgm_side_daily06.awb")

				local var_222_34 = ""
				local var_222_35 = manager.audio:GetAudioName("bgm_side_daily06", "bgm_side_daily06")

				if var_222_35 ~= "" then
					if arg_219_1.bgmTxt_.text ~= var_222_35 and arg_219_1.bgmTxt_.text ~= "" then
						if arg_219_1.bgmTxt2_.text ~= "" then
							arg_219_1.bgmTxt_.text = arg_219_1.bgmTxt2_.text
						end

						arg_219_1.bgmTxt2_.text = var_222_35

						arg_219_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_219_1.bgmTxt_.text = var_222_35
						arg_219_1.bgmTxt2_.text = var_222_35
					end

					if arg_219_1.bgmTimer then
						arg_219_1.bgmTimer:Stop()

						arg_219_1.bgmTimer = nil
					end

					if arg_219_1.settingData.show_music_name == 1 then
						arg_219_1.musicController:SetSelectedState("show")
						arg_219_1.musicAnimator_:Play("open", 0, 0)

						if arg_219_1.settingData.music_time ~= 0 then
							arg_219_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_219_1.settingData.music_time), function()
								if arg_219_1 == nil or isNil(arg_219_1.bgmTxt_) then
									return
								end

								arg_219_1.musicController:SetSelectedState("hide")
								arg_219_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_222_36 = 0
			local var_222_37 = 0.3

			if var_222_36 < arg_219_1.time_ and arg_219_1.time_ <= var_222_36 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_38 = arg_219_1:FormatText(StoryNameCfg[6].name)

				arg_219_1.leftNameTxt_.text = var_222_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_39 = arg_219_1:GetWordFromCfg(114804054)
				local var_222_40 = arg_219_1:FormatText(var_222_39.content)

				arg_219_1.text_.text = var_222_40

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_41 = 12
				local var_222_42 = utf8.len(var_222_40)
				local var_222_43 = var_222_41 <= 0 and var_222_37 or var_222_37 * (var_222_42 / var_222_41)

				if var_222_43 > 0 and var_222_37 < var_222_43 then
					arg_219_1.talkMaxDuration = var_222_43

					if var_222_43 + var_222_36 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_43 + var_222_36
					end
				end

				arg_219_1.text_.text = var_222_40
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804054", "story_v_side_old_114804.awb") ~= 0 then
					local var_222_44 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804054", "story_v_side_old_114804.awb") / 1000

					if var_222_44 + var_222_36 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_44 + var_222_36
					end

					if var_222_39.prefab_name ~= "" and arg_219_1.actors_[var_222_39.prefab_name] ~= nil then
						local var_222_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_39.prefab_name].transform, "story_v_side_old_114804", "114804054", "story_v_side_old_114804.awb")

						arg_219_1:RecordAudio("114804054", var_222_45)
						arg_219_1:RecordAudio("114804054", var_222_45)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804054", "story_v_side_old_114804.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804054", "story_v_side_old_114804.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_46 = math.max(var_222_37, arg_219_1.talkMaxDuration)

			if var_222_36 <= arg_219_1.time_ and arg_219_1.time_ < var_222_36 + var_222_46 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_36) / var_222_46

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_36 + var_222_46 and arg_219_1.time_ < var_222_36 + var_222_46 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play114804055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 114804055
		arg_224_1.duration_ = 5.9

		local var_224_0 = {
			ja = 5.9,
			ko = 5.9,
			zh = 5.1,
			en = 5.366
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
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play114804056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1084ui_story"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos1084ui_story = var_227_0.localPosition
			end

			local var_227_2 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2
				local var_227_4 = Vector3.New(0, 100, 0)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1084ui_story, var_227_4, var_227_3)

				local var_227_5 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_5.x, var_227_5.y, var_227_5.z)

				local var_227_6 = var_227_0.localEulerAngles

				var_227_6.z = 0
				var_227_6.x = 0
				var_227_0.localEulerAngles = var_227_6
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(0, 100, 0)

				local var_227_7 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_7.x, var_227_7.y, var_227_7.z)

				local var_227_8 = var_227_0.localEulerAngles

				var_227_8.z = 0
				var_227_8.x = 0
				var_227_0.localEulerAngles = var_227_8
			end

			local var_227_9 = "1027ui_story"

			if arg_224_1.actors_[var_227_9] == nil then
				local var_227_10 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_227_10) then
					local var_227_11 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_224_1.stage_.transform)

					var_227_11.name = var_227_9
					var_227_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_224_1.actors_[var_227_9] = var_227_11

					local var_227_12 = var_227_11:GetComponentInChildren(typeof(CharacterEffect))

					var_227_12.enabled = true

					local var_227_13 = GameObjectTools.GetOrAddComponent(var_227_11, typeof(DynamicBoneHelper))

					if var_227_13 then
						var_227_13:EnableDynamicBone(false)
					end

					arg_224_1:ShowWeapon(var_227_12.transform, false)

					arg_224_1.var_[var_227_9 .. "Animator"] = var_227_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_224_1.var_[var_227_9 .. "Animator"].applyRootMotion = true
					arg_224_1.var_[var_227_9 .. "LipSync"] = var_227_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_227_14 = arg_224_1.actors_["1027ui_story"].transform
			local var_227_15 = 0

			if var_227_15 < arg_224_1.time_ and arg_224_1.time_ <= var_227_15 + arg_227_0 then
				arg_224_1.var_.moveOldPos1027ui_story = var_227_14.localPosition

				local var_227_16 = "1027ui_story"

				arg_224_1:ShowWeapon(arg_224_1.var_[var_227_16 .. "Animator"].transform, false)
			end

			local var_227_17 = 0.001

			if var_227_15 <= arg_224_1.time_ and arg_224_1.time_ < var_227_15 + var_227_17 then
				local var_227_18 = (arg_224_1.time_ - var_227_15) / var_227_17
				local var_227_19 = Vector3.New(0, -0.81, -5.8)

				var_227_14.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1027ui_story, var_227_19, var_227_18)

				local var_227_20 = manager.ui.mainCamera.transform.position - var_227_14.position

				var_227_14.forward = Vector3.New(var_227_20.x, var_227_20.y, var_227_20.z)

				local var_227_21 = var_227_14.localEulerAngles

				var_227_21.z = 0
				var_227_21.x = 0
				var_227_14.localEulerAngles = var_227_21
			end

			if arg_224_1.time_ >= var_227_15 + var_227_17 and arg_224_1.time_ < var_227_15 + var_227_17 + arg_227_0 then
				var_227_14.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_227_22 = manager.ui.mainCamera.transform.position - var_227_14.position

				var_227_14.forward = Vector3.New(var_227_22.x, var_227_22.y, var_227_22.z)

				local var_227_23 = var_227_14.localEulerAngles

				var_227_23.z = 0
				var_227_23.x = 0
				var_227_14.localEulerAngles = var_227_23
			end

			local var_227_24 = arg_224_1.actors_["1027ui_story"]
			local var_227_25 = 0

			if var_227_25 < arg_224_1.time_ and arg_224_1.time_ <= var_227_25 + arg_227_0 and not isNil(var_227_24) and arg_224_1.var_.characterEffect1027ui_story == nil then
				arg_224_1.var_.characterEffect1027ui_story = var_227_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_26 = 0.2

			if var_227_25 <= arg_224_1.time_ and arg_224_1.time_ < var_227_25 + var_227_26 and not isNil(var_227_24) then
				local var_227_27 = (arg_224_1.time_ - var_227_25) / var_227_26

				if arg_224_1.var_.characterEffect1027ui_story and not isNil(var_227_24) then
					arg_224_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_25 + var_227_26 and arg_224_1.time_ < var_227_25 + var_227_26 + arg_227_0 and not isNil(var_227_24) and arg_224_1.var_.characterEffect1027ui_story then
				arg_224_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_227_28 = 0.0166666666666667

			if var_227_28 < arg_224_1.time_ and arg_224_1.time_ <= var_227_28 + arg_227_0 then
				arg_224_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			local var_227_29 = 0.0166666666666667

			if var_227_29 < arg_224_1.time_ and arg_224_1.time_ <= var_227_29 + arg_227_0 then
				arg_224_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_227_30 = 0
			local var_227_31 = 0.675

			if var_227_30 < arg_224_1.time_ and arg_224_1.time_ <= var_227_30 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_32 = arg_224_1:FormatText(StoryNameCfg[56].name)

				arg_224_1.leftNameTxt_.text = var_227_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_33 = arg_224_1:GetWordFromCfg(114804055)
				local var_227_34 = arg_224_1:FormatText(var_227_33.content)

				arg_224_1.text_.text = var_227_34

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_35 = 27
				local var_227_36 = utf8.len(var_227_34)
				local var_227_37 = var_227_35 <= 0 and var_227_31 or var_227_31 * (var_227_36 / var_227_35)

				if var_227_37 > 0 and var_227_31 < var_227_37 then
					arg_224_1.talkMaxDuration = var_227_37

					if var_227_37 + var_227_30 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_37 + var_227_30
					end
				end

				arg_224_1.text_.text = var_227_34
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804055", "story_v_side_old_114804.awb") ~= 0 then
					local var_227_38 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804055", "story_v_side_old_114804.awb") / 1000

					if var_227_38 + var_227_30 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_38 + var_227_30
					end

					if var_227_33.prefab_name ~= "" and arg_224_1.actors_[var_227_33.prefab_name] ~= nil then
						local var_227_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_33.prefab_name].transform, "story_v_side_old_114804", "114804055", "story_v_side_old_114804.awb")

						arg_224_1:RecordAudio("114804055", var_227_39)
						arg_224_1:RecordAudio("114804055", var_227_39)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804055", "story_v_side_old_114804.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804055", "story_v_side_old_114804.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_40 = math.max(var_227_31, arg_224_1.talkMaxDuration)

			if var_227_30 <= arg_224_1.time_ and arg_224_1.time_ < var_227_30 + var_227_40 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_30) / var_227_40

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_30 + var_227_40 and arg_224_1.time_ < var_227_30 + var_227_40 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play114804056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 114804056
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play114804057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1027ui_story"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos1027ui_story = var_231_0.localPosition
			end

			local var_231_2 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2
				local var_231_4 = Vector3.New(0, 100, 0)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1027ui_story, var_231_4, var_231_3)

				local var_231_5 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_5.x, var_231_5.y, var_231_5.z)

				local var_231_6 = var_231_0.localEulerAngles

				var_231_6.z = 0
				var_231_6.x = 0
				var_231_0.localEulerAngles = var_231_6
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(0, 100, 0)

				local var_231_7 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_7.x, var_231_7.y, var_231_7.z)

				local var_231_8 = var_231_0.localEulerAngles

				var_231_8.z = 0
				var_231_8.x = 0
				var_231_0.localEulerAngles = var_231_8
			end

			local var_231_9 = 0
			local var_231_10 = 1.35

			if var_231_9 < arg_228_1.time_ and arg_228_1.time_ <= var_231_9 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_11 = arg_228_1:GetWordFromCfg(114804056)
				local var_231_12 = arg_228_1:FormatText(var_231_11.content)

				arg_228_1.text_.text = var_231_12

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_13 = 54
				local var_231_14 = utf8.len(var_231_12)
				local var_231_15 = var_231_13 <= 0 and var_231_10 or var_231_10 * (var_231_14 / var_231_13)

				if var_231_15 > 0 and var_231_10 < var_231_15 then
					arg_228_1.talkMaxDuration = var_231_15

					if var_231_15 + var_231_9 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_15 + var_231_9
					end
				end

				arg_228_1.text_.text = var_231_12
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_16 = math.max(var_231_10, arg_228_1.talkMaxDuration)

			if var_231_9 <= arg_228_1.time_ and arg_228_1.time_ < var_231_9 + var_231_16 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_9) / var_231_16

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_9 + var_231_16 and arg_228_1.time_ < var_231_9 + var_231_16 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play114804057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 114804057
		arg_232_1.duration_ = 7.97

		local var_232_0 = {
			ja = 7.966,
			ko = 5.833,
			zh = 4.833,
			en = 6.266
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
				arg_232_0:Play114804058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1148ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos1148ui_story = var_235_0.localPosition

				local var_235_2 = "1148ui_story"

				arg_232_1:ShowWeapon(arg_232_1.var_[var_235_2 .. "Animator"].transform, false)
			end

			local var_235_3 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_3 then
				local var_235_4 = (arg_232_1.time_ - var_235_1) / var_235_3
				local var_235_5 = Vector3.New(0, -0.8, -6.2)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1148ui_story, var_235_5, var_235_4)

				local var_235_6 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_6.x, var_235_6.y, var_235_6.z)

				local var_235_7 = var_235_0.localEulerAngles

				var_235_7.z = 0
				var_235_7.x = 0
				var_235_0.localEulerAngles = var_235_7
			end

			if arg_232_1.time_ >= var_235_1 + var_235_3 and arg_232_1.time_ < var_235_1 + var_235_3 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_235_8 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_8.x, var_235_8.y, var_235_8.z)

				local var_235_9 = var_235_0.localEulerAngles

				var_235_9.z = 0
				var_235_9.x = 0
				var_235_0.localEulerAngles = var_235_9
			end

			local var_235_10 = arg_232_1.actors_["1148ui_story"]
			local var_235_11 = 0

			if var_235_11 < arg_232_1.time_ and arg_232_1.time_ <= var_235_11 + arg_235_0 and not isNil(var_235_10) and arg_232_1.var_.characterEffect1148ui_story == nil then
				arg_232_1.var_.characterEffect1148ui_story = var_235_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_12 = 0.2

			if var_235_11 <= arg_232_1.time_ and arg_232_1.time_ < var_235_11 + var_235_12 and not isNil(var_235_10) then
				local var_235_13 = (arg_232_1.time_ - var_235_11) / var_235_12

				if arg_232_1.var_.characterEffect1148ui_story and not isNil(var_235_10) then
					arg_232_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_11 + var_235_12 and arg_232_1.time_ < var_235_11 + var_235_12 + arg_235_0 and not isNil(var_235_10) and arg_232_1.var_.characterEffect1148ui_story then
				arg_232_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_235_14 = 0.0166666666666667

			if var_235_14 < arg_232_1.time_ and arg_232_1.time_ <= var_235_14 + arg_235_0 then
				arg_232_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_235_15 = 0.0166666666666667

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 then
				arg_232_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_235_16 = 0
			local var_235_17 = 0.425

			if var_235_16 < arg_232_1.time_ and arg_232_1.time_ <= var_235_16 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_18 = arg_232_1:FormatText(StoryNameCfg[8].name)

				arg_232_1.leftNameTxt_.text = var_235_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_19 = arg_232_1:GetWordFromCfg(114804057)
				local var_235_20 = arg_232_1:FormatText(var_235_19.content)

				arg_232_1.text_.text = var_235_20

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_21 = 17
				local var_235_22 = utf8.len(var_235_20)
				local var_235_23 = var_235_21 <= 0 and var_235_17 or var_235_17 * (var_235_22 / var_235_21)

				if var_235_23 > 0 and var_235_17 < var_235_23 then
					arg_232_1.talkMaxDuration = var_235_23

					if var_235_23 + var_235_16 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_23 + var_235_16
					end
				end

				arg_232_1.text_.text = var_235_20
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804057", "story_v_side_old_114804.awb") ~= 0 then
					local var_235_24 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804057", "story_v_side_old_114804.awb") / 1000

					if var_235_24 + var_235_16 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_24 + var_235_16
					end

					if var_235_19.prefab_name ~= "" and arg_232_1.actors_[var_235_19.prefab_name] ~= nil then
						local var_235_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_19.prefab_name].transform, "story_v_side_old_114804", "114804057", "story_v_side_old_114804.awb")

						arg_232_1:RecordAudio("114804057", var_235_25)
						arg_232_1:RecordAudio("114804057", var_235_25)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804057", "story_v_side_old_114804.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804057", "story_v_side_old_114804.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_26 = math.max(var_235_17, arg_232_1.talkMaxDuration)

			if var_235_16 <= arg_232_1.time_ and arg_232_1.time_ < var_235_16 + var_235_26 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_16) / var_235_26

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_16 + var_235_26 and arg_232_1.time_ < var_235_16 + var_235_26 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play114804058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 114804058
		arg_236_1.duration_ = 9.5

		local var_236_0 = {
			ja = 9.5,
			ko = 2.5,
			zh = 2.066,
			en = 2.1
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play114804059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_239_2 = 0
			local var_239_3 = 0.125

			if var_239_2 < arg_236_1.time_ and arg_236_1.time_ <= var_239_2 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_4 = arg_236_1:FormatText(StoryNameCfg[8].name)

				arg_236_1.leftNameTxt_.text = var_239_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_5 = arg_236_1:GetWordFromCfg(114804058)
				local var_239_6 = arg_236_1:FormatText(var_239_5.content)

				arg_236_1.text_.text = var_239_6

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_7 = 5
				local var_239_8 = utf8.len(var_239_6)
				local var_239_9 = var_239_7 <= 0 and var_239_3 or var_239_3 * (var_239_8 / var_239_7)

				if var_239_9 > 0 and var_239_3 < var_239_9 then
					arg_236_1.talkMaxDuration = var_239_9

					if var_239_9 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_9 + var_239_2
					end
				end

				arg_236_1.text_.text = var_239_6
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804058", "story_v_side_old_114804.awb") ~= 0 then
					local var_239_10 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804058", "story_v_side_old_114804.awb") / 1000

					if var_239_10 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_2
					end

					if var_239_5.prefab_name ~= "" and arg_236_1.actors_[var_239_5.prefab_name] ~= nil then
						local var_239_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_5.prefab_name].transform, "story_v_side_old_114804", "114804058", "story_v_side_old_114804.awb")

						arg_236_1:RecordAudio("114804058", var_239_11)
						arg_236_1:RecordAudio("114804058", var_239_11)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804058", "story_v_side_old_114804.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804058", "story_v_side_old_114804.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_12 = math.max(var_239_3, arg_236_1.talkMaxDuration)

			if var_239_2 <= arg_236_1.time_ and arg_236_1.time_ < var_239_2 + var_239_12 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_2) / var_239_12

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_2 + var_239_12 and arg_236_1.time_ < var_239_2 + var_239_12 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play114804059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 114804059
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play114804060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1148ui_story"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1148ui_story == nil then
				arg_240_1.var_.characterEffect1148ui_story = var_243_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.2

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.characterEffect1148ui_story and not isNil(var_243_0) then
					local var_243_4 = Mathf.Lerp(0, 0.5, var_243_3)

					arg_240_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1148ui_story.fillRatio = var_243_4
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1148ui_story then
				local var_243_5 = 0.5

				arg_240_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1148ui_story.fillRatio = var_243_5
			end

			local var_243_6 = 0

			if var_243_6 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_243_7 = 0
			local var_243_8 = 1.025

			if var_243_7 < arg_240_1.time_ and arg_240_1.time_ <= var_243_7 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_9 = arg_240_1:GetWordFromCfg(114804059)
				local var_243_10 = arg_240_1:FormatText(var_243_9.content)

				arg_240_1.text_.text = var_243_10

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_11 = 41
				local var_243_12 = utf8.len(var_243_10)
				local var_243_13 = var_243_11 <= 0 and var_243_8 or var_243_8 * (var_243_12 / var_243_11)

				if var_243_13 > 0 and var_243_8 < var_243_13 then
					arg_240_1.talkMaxDuration = var_243_13

					if var_243_13 + var_243_7 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_7
					end
				end

				arg_240_1.text_.text = var_243_10
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_14 = math.max(var_243_8, arg_240_1.talkMaxDuration)

			if var_243_7 <= arg_240_1.time_ and arg_240_1.time_ < var_243_7 + var_243_14 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_7) / var_243_14

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_7 + var_243_14 and arg_240_1.time_ < var_243_7 + var_243_14 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play114804060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 114804060
		arg_244_1.duration_ = 5.6

		local var_244_0 = {
			ja = 5.366,
			ko = 3.833,
			zh = 5.6,
			en = 3.6
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play114804061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1148ui_story"].transform
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.var_.moveOldPos1148ui_story = var_247_0.localPosition

				local var_247_2 = "1148ui_story"

				arg_244_1:ShowWeapon(arg_244_1.var_[var_247_2 .. "Animator"].transform, false)
			end

			local var_247_3 = 0.001

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_3 then
				local var_247_4 = (arg_244_1.time_ - var_247_1) / var_247_3
				local var_247_5 = Vector3.New(-0.7, -0.8, -6.2)

				var_247_0.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1148ui_story, var_247_5, var_247_4)

				local var_247_6 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_6.x, var_247_6.y, var_247_6.z)

				local var_247_7 = var_247_0.localEulerAngles

				var_247_7.z = 0
				var_247_7.x = 0
				var_247_0.localEulerAngles = var_247_7
			end

			if arg_244_1.time_ >= var_247_1 + var_247_3 and arg_244_1.time_ < var_247_1 + var_247_3 + arg_247_0 then
				var_247_0.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_247_8 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_8.x, var_247_8.y, var_247_8.z)

				local var_247_9 = var_247_0.localEulerAngles

				var_247_9.z = 0
				var_247_9.x = 0
				var_247_0.localEulerAngles = var_247_9
			end

			local var_247_10 = arg_244_1.actors_["1019ui_story"].transform
			local var_247_11 = 0

			if var_247_11 < arg_244_1.time_ and arg_244_1.time_ <= var_247_11 + arg_247_0 then
				arg_244_1.var_.moveOldPos1019ui_story = var_247_10.localPosition

				local var_247_12 = "1019ui_story"

				arg_244_1:ShowWeapon(arg_244_1.var_[var_247_12 .. "Animator"].transform, false)
			end

			local var_247_13 = 0.001

			if var_247_11 <= arg_244_1.time_ and arg_244_1.time_ < var_247_11 + var_247_13 then
				local var_247_14 = (arg_244_1.time_ - var_247_11) / var_247_13
				local var_247_15 = Vector3.New(0.7, -1.08, -5.9)

				var_247_10.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1019ui_story, var_247_15, var_247_14)

				local var_247_16 = manager.ui.mainCamera.transform.position - var_247_10.position

				var_247_10.forward = Vector3.New(var_247_16.x, var_247_16.y, var_247_16.z)

				local var_247_17 = var_247_10.localEulerAngles

				var_247_17.z = 0
				var_247_17.x = 0
				var_247_10.localEulerAngles = var_247_17
			end

			if arg_244_1.time_ >= var_247_11 + var_247_13 and arg_244_1.time_ < var_247_11 + var_247_13 + arg_247_0 then
				var_247_10.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_247_18 = manager.ui.mainCamera.transform.position - var_247_10.position

				var_247_10.forward = Vector3.New(var_247_18.x, var_247_18.y, var_247_18.z)

				local var_247_19 = var_247_10.localEulerAngles

				var_247_19.z = 0
				var_247_19.x = 0
				var_247_10.localEulerAngles = var_247_19
			end

			local var_247_20 = arg_244_1.actors_["1019ui_story"]
			local var_247_21 = 0

			if var_247_21 < arg_244_1.time_ and arg_244_1.time_ <= var_247_21 + arg_247_0 and not isNil(var_247_20) and arg_244_1.var_.characterEffect1019ui_story == nil then
				arg_244_1.var_.characterEffect1019ui_story = var_247_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_22 = 0.2

			if var_247_21 <= arg_244_1.time_ and arg_244_1.time_ < var_247_21 + var_247_22 and not isNil(var_247_20) then
				local var_247_23 = (arg_244_1.time_ - var_247_21) / var_247_22

				if arg_244_1.var_.characterEffect1019ui_story and not isNil(var_247_20) then
					arg_244_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_21 + var_247_22 and arg_244_1.time_ < var_247_21 + var_247_22 + arg_247_0 and not isNil(var_247_20) and arg_244_1.var_.characterEffect1019ui_story then
				arg_244_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_247_24 = 0.0166666666666667

			if var_247_24 < arg_244_1.time_ and arg_244_1.time_ <= var_247_24 + arg_247_0 then
				arg_244_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_247_25 = 0.0166666666666667

			if var_247_25 < arg_244_1.time_ and arg_244_1.time_ <= var_247_25 + arg_247_0 then
				arg_244_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_247_26 = 0.0166666666666667

			if var_247_26 < arg_244_1.time_ and arg_244_1.time_ <= var_247_26 + arg_247_0 then
				arg_244_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_247_27 = 0
			local var_247_28 = 0.4

			if var_247_27 < arg_244_1.time_ and arg_244_1.time_ <= var_247_27 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_29 = arg_244_1:FormatText(StoryNameCfg[13].name)

				arg_244_1.leftNameTxt_.text = var_247_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_30 = arg_244_1:GetWordFromCfg(114804060)
				local var_247_31 = arg_244_1:FormatText(var_247_30.content)

				arg_244_1.text_.text = var_247_31

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_32 = 16
				local var_247_33 = utf8.len(var_247_31)
				local var_247_34 = var_247_32 <= 0 and var_247_28 or var_247_28 * (var_247_33 / var_247_32)

				if var_247_34 > 0 and var_247_28 < var_247_34 then
					arg_244_1.talkMaxDuration = var_247_34

					if var_247_34 + var_247_27 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_34 + var_247_27
					end
				end

				arg_244_1.text_.text = var_247_31
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804060", "story_v_side_old_114804.awb") ~= 0 then
					local var_247_35 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804060", "story_v_side_old_114804.awb") / 1000

					if var_247_35 + var_247_27 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_35 + var_247_27
					end

					if var_247_30.prefab_name ~= "" and arg_244_1.actors_[var_247_30.prefab_name] ~= nil then
						local var_247_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_30.prefab_name].transform, "story_v_side_old_114804", "114804060", "story_v_side_old_114804.awb")

						arg_244_1:RecordAudio("114804060", var_247_36)
						arg_244_1:RecordAudio("114804060", var_247_36)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804060", "story_v_side_old_114804.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804060", "story_v_side_old_114804.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_37 = math.max(var_247_28, arg_244_1.talkMaxDuration)

			if var_247_27 <= arg_244_1.time_ and arg_244_1.time_ < var_247_27 + var_247_37 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_27) / var_247_37

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_27 + var_247_37 and arg_244_1.time_ < var_247_27 + var_247_37 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play114804061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 114804061
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play114804062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1019ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1019ui_story == nil then
				arg_248_1.var_.characterEffect1019ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.2

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect1019ui_story and not isNil(var_251_0) then
					local var_251_4 = Mathf.Lerp(0, 0.5, var_251_3)

					arg_248_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1019ui_story.fillRatio = var_251_4
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1019ui_story then
				local var_251_5 = 0.5

				arg_248_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1019ui_story.fillRatio = var_251_5
			end

			local var_251_6 = 0

			if var_251_6 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_251_7 = 0

			if var_251_7 < arg_248_1.time_ and arg_248_1.time_ <= var_251_7 + arg_251_0 then
				arg_248_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_251_8 = 0
			local var_251_9 = 0.725

			if var_251_8 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_10 = arg_248_1:FormatText(StoryNameCfg[7].name)

				arg_248_1.leftNameTxt_.text = var_251_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_11 = arg_248_1:GetWordFromCfg(114804061)
				local var_251_12 = arg_248_1:FormatText(var_251_11.content)

				arg_248_1.text_.text = var_251_12

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_13 = 29
				local var_251_14 = utf8.len(var_251_12)
				local var_251_15 = var_251_13 <= 0 and var_251_9 or var_251_9 * (var_251_14 / var_251_13)

				if var_251_15 > 0 and var_251_9 < var_251_15 then
					arg_248_1.talkMaxDuration = var_251_15

					if var_251_15 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_15 + var_251_8
					end
				end

				arg_248_1.text_.text = var_251_12
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_16 = math.max(var_251_9, arg_248_1.talkMaxDuration)

			if var_251_8 <= arg_248_1.time_ and arg_248_1.time_ < var_251_8 + var_251_16 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_8) / var_251_16

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_8 + var_251_16 and arg_248_1.time_ < var_251_8 + var_251_16 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play114804062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 114804062
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play114804063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_255_2 = 0

			if var_255_2 < arg_252_1.time_ and arg_252_1.time_ <= var_255_2 + arg_255_0 then
				arg_252_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_255_3 = 0
			local var_255_4 = 0.925

			if var_255_3 < arg_252_1.time_ and arg_252_1.time_ <= var_255_3 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_5 = arg_252_1:GetWordFromCfg(114804062)
				local var_255_6 = arg_252_1:FormatText(var_255_5.content)

				arg_252_1.text_.text = var_255_6

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_7 = 37
				local var_255_8 = utf8.len(var_255_6)
				local var_255_9 = var_255_7 <= 0 and var_255_4 or var_255_4 * (var_255_8 / var_255_7)

				if var_255_9 > 0 and var_255_4 < var_255_9 then
					arg_252_1.talkMaxDuration = var_255_9

					if var_255_9 + var_255_3 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_9 + var_255_3
					end
				end

				arg_252_1.text_.text = var_255_6
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_10 = math.max(var_255_4, arg_252_1.talkMaxDuration)

			if var_255_3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_3 + var_255_10 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_3) / var_255_10

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_3 + var_255_10 and arg_252_1.time_ < var_255_3 + var_255_10 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play114804063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 114804063
		arg_256_1.duration_ = 6.47

		local var_256_0 = {
			ja = 6.466,
			ko = 4.8,
			zh = 3.933,
			en = 5.133
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play114804064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1148ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1148ui_story == nil then
				arg_256_1.var_.characterEffect1148ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.2

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1148ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1148ui_story then
				arg_256_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_259_4 = 0

			if var_259_4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_259_5 = 0

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_259_6 = 0

			if var_259_6 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_259_7 = 0

			if var_259_7 < arg_256_1.time_ and arg_256_1.time_ <= var_259_7 + arg_259_0 then
				arg_256_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_259_8 = 0
			local var_259_9 = 0.425

			if var_259_8 < arg_256_1.time_ and arg_256_1.time_ <= var_259_8 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_10 = arg_256_1:FormatText(StoryNameCfg[8].name)

				arg_256_1.leftNameTxt_.text = var_259_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_11 = arg_256_1:GetWordFromCfg(114804063)
				local var_259_12 = arg_256_1:FormatText(var_259_11.content)

				arg_256_1.text_.text = var_259_12

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_13 = 17
				local var_259_14 = utf8.len(var_259_12)
				local var_259_15 = var_259_13 <= 0 and var_259_9 or var_259_9 * (var_259_14 / var_259_13)

				if var_259_15 > 0 and var_259_9 < var_259_15 then
					arg_256_1.talkMaxDuration = var_259_15

					if var_259_15 + var_259_8 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_15 + var_259_8
					end
				end

				arg_256_1.text_.text = var_259_12
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804063", "story_v_side_old_114804.awb") ~= 0 then
					local var_259_16 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804063", "story_v_side_old_114804.awb") / 1000

					if var_259_16 + var_259_8 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_16 + var_259_8
					end

					if var_259_11.prefab_name ~= "" and arg_256_1.actors_[var_259_11.prefab_name] ~= nil then
						local var_259_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_11.prefab_name].transform, "story_v_side_old_114804", "114804063", "story_v_side_old_114804.awb")

						arg_256_1:RecordAudio("114804063", var_259_17)
						arg_256_1:RecordAudio("114804063", var_259_17)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804063", "story_v_side_old_114804.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804063", "story_v_side_old_114804.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_18 = math.max(var_259_9, arg_256_1.talkMaxDuration)

			if var_259_8 <= arg_256_1.time_ and arg_256_1.time_ < var_259_8 + var_259_18 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_8) / var_259_18

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_8 + var_259_18 and arg_256_1.time_ < var_259_8 + var_259_18 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play114804064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 114804064
		arg_260_1.duration_ = 9.3

		local var_260_0 = {
			ja = 9.3,
			ko = 7.033,
			zh = 6.466,
			en = 7.733
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play114804065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = "R4801"

			if arg_260_1.bgs_[var_263_0] == nil then
				local var_263_1 = Object.Instantiate(arg_260_1.paintGo_)

				var_263_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_263_0)
				var_263_1.name = var_263_0
				var_263_1.transform.parent = arg_260_1.stage_.transform
				var_263_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.bgs_[var_263_0] = var_263_1
			end

			local var_263_2 = 1.5

			if var_263_2 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				local var_263_3 = manager.ui.mainCamera.transform.localPosition
				local var_263_4 = Vector3.New(0, 0, 10) + Vector3.New(var_263_3.x, var_263_3.y, 0)
				local var_263_5 = arg_260_1.bgs_.R4801

				var_263_5.transform.localPosition = var_263_4
				var_263_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_6 = var_263_5:GetComponent("SpriteRenderer")

				if var_263_6 and var_263_6.sprite then
					local var_263_7 = (var_263_5.transform.localPosition - var_263_3).z
					local var_263_8 = manager.ui.mainCameraCom_
					local var_263_9 = 2 * var_263_7 * Mathf.Tan(var_263_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_263_10 = var_263_9 * var_263_8.aspect
					local var_263_11 = var_263_6.sprite.bounds.size.x
					local var_263_12 = var_263_6.sprite.bounds.size.y
					local var_263_13 = var_263_10 / var_263_11
					local var_263_14 = var_263_9 / var_263_12
					local var_263_15 = var_263_14 < var_263_13 and var_263_13 or var_263_14

					var_263_5.transform.localScale = Vector3.New(var_263_15, var_263_15, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "R4801" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_16 = arg_260_1.actors_["1019ui_story"].transform
			local var_263_17 = 0

			if var_263_17 < arg_260_1.time_ and arg_260_1.time_ <= var_263_17 + arg_263_0 then
				arg_260_1.var_.moveOldPos1019ui_story = var_263_16.localPosition
			end

			local var_263_18 = 0.001

			if var_263_17 <= arg_260_1.time_ and arg_260_1.time_ < var_263_17 + var_263_18 then
				local var_263_19 = (arg_260_1.time_ - var_263_17) / var_263_18
				local var_263_20 = Vector3.New(0, 100, 0)

				var_263_16.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1019ui_story, var_263_20, var_263_19)

				local var_263_21 = manager.ui.mainCamera.transform.position - var_263_16.position

				var_263_16.forward = Vector3.New(var_263_21.x, var_263_21.y, var_263_21.z)

				local var_263_22 = var_263_16.localEulerAngles

				var_263_22.z = 0
				var_263_22.x = 0
				var_263_16.localEulerAngles = var_263_22
			end

			if arg_260_1.time_ >= var_263_17 + var_263_18 and arg_260_1.time_ < var_263_17 + var_263_18 + arg_263_0 then
				var_263_16.localPosition = Vector3.New(0, 100, 0)

				local var_263_23 = manager.ui.mainCamera.transform.position - var_263_16.position

				var_263_16.forward = Vector3.New(var_263_23.x, var_263_23.y, var_263_23.z)

				local var_263_24 = var_263_16.localEulerAngles

				var_263_24.z = 0
				var_263_24.x = 0
				var_263_16.localEulerAngles = var_263_24
			end

			local var_263_25 = arg_260_1.actors_["1148ui_story"].transform
			local var_263_26 = 0

			if var_263_26 < arg_260_1.time_ and arg_260_1.time_ <= var_263_26 + arg_263_0 then
				arg_260_1.var_.moveOldPos1148ui_story = var_263_25.localPosition
			end

			local var_263_27 = 0.001

			if var_263_26 <= arg_260_1.time_ and arg_260_1.time_ < var_263_26 + var_263_27 then
				local var_263_28 = (arg_260_1.time_ - var_263_26) / var_263_27
				local var_263_29 = Vector3.New(0, 100, 0)

				var_263_25.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1148ui_story, var_263_29, var_263_28)

				local var_263_30 = manager.ui.mainCamera.transform.position - var_263_25.position

				var_263_25.forward = Vector3.New(var_263_30.x, var_263_30.y, var_263_30.z)

				local var_263_31 = var_263_25.localEulerAngles

				var_263_31.z = 0
				var_263_31.x = 0
				var_263_25.localEulerAngles = var_263_31
			end

			if arg_260_1.time_ >= var_263_26 + var_263_27 and arg_260_1.time_ < var_263_26 + var_263_27 + arg_263_0 then
				var_263_25.localPosition = Vector3.New(0, 100, 0)

				local var_263_32 = manager.ui.mainCamera.transform.position - var_263_25.position

				var_263_25.forward = Vector3.New(var_263_32.x, var_263_32.y, var_263_32.z)

				local var_263_33 = var_263_25.localEulerAngles

				var_263_33.z = 0
				var_263_33.x = 0
				var_263_25.localEulerAngles = var_263_33
			end

			local var_263_34 = arg_260_1.bgs_.ST02
			local var_263_35 = 0

			if var_263_35 < arg_260_1.time_ and arg_260_1.time_ <= var_263_35 + arg_263_0 then
				local var_263_36 = var_263_34:GetComponent("SpriteRenderer")

				if var_263_36 then
					arg_260_1.var_.alphaOldValueST02 = var_263_36.color.a
					arg_260_1.var_.alphaMatValueST02 = var_263_36
				end

				arg_260_1.var_.alphaOldValueST02 = 1
			end

			local var_263_37 = 1.5

			if var_263_35 <= arg_260_1.time_ and arg_260_1.time_ < var_263_35 + var_263_37 then
				local var_263_38 = (arg_260_1.time_ - var_263_35) / var_263_37
				local var_263_39 = Mathf.Lerp(arg_260_1.var_.alphaOldValueST02, 0, var_263_38)

				if arg_260_1.var_.alphaMatValueST02 then
					local var_263_40 = arg_260_1.var_.alphaMatValueST02.color

					var_263_40.a = var_263_39
					arg_260_1.var_.alphaMatValueST02.color = var_263_40
				end
			end

			if arg_260_1.time_ >= var_263_35 + var_263_37 and arg_260_1.time_ < var_263_35 + var_263_37 + arg_263_0 and arg_260_1.var_.alphaMatValueST02 then
				local var_263_41 = arg_260_1.var_.alphaMatValueST02
				local var_263_42 = var_263_41.color

				var_263_42.a = 0
				var_263_41.color = var_263_42
			end

			local var_263_43 = arg_260_1.bgs_.R4801
			local var_263_44 = 1.5

			if var_263_44 < arg_260_1.time_ and arg_260_1.time_ <= var_263_44 + arg_263_0 then
				local var_263_45 = var_263_43:GetComponent("SpriteRenderer")

				if var_263_45 then
					arg_260_1.var_.alphaOldValueR4801 = var_263_45.color.a
					arg_260_1.var_.alphaMatValueR4801 = var_263_45
				end

				arg_260_1.var_.alphaOldValueR4801 = 0
			end

			local var_263_46 = 1.5

			if var_263_44 <= arg_260_1.time_ and arg_260_1.time_ < var_263_44 + var_263_46 then
				local var_263_47 = (arg_260_1.time_ - var_263_44) / var_263_46
				local var_263_48 = Mathf.Lerp(arg_260_1.var_.alphaOldValueR4801, 1, var_263_47)

				if arg_260_1.var_.alphaMatValueR4801 then
					local var_263_49 = arg_260_1.var_.alphaMatValueR4801.color

					var_263_49.a = var_263_48
					arg_260_1.var_.alphaMatValueR4801.color = var_263_49
				end
			end

			if arg_260_1.time_ >= var_263_44 + var_263_46 and arg_260_1.time_ < var_263_44 + var_263_46 + arg_263_0 and arg_260_1.var_.alphaMatValueR4801 then
				local var_263_50 = arg_260_1.var_.alphaMatValueR4801
				local var_263_51 = var_263_50.color

				var_263_51.a = 1
				var_263_50.color = var_263_51
			end

			local var_263_52 = 0
			local var_263_53 = 0.575

			if var_263_52 < arg_260_1.time_ and arg_260_1.time_ <= var_263_52 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_54 = arg_260_1:FormatText(StoryNameCfg[8].name)

				arg_260_1.leftNameTxt_.text = var_263_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_55 = arg_260_1:GetWordFromCfg(114804064)
				local var_263_56 = arg_260_1:FormatText(var_263_55.content)

				arg_260_1.text_.text = var_263_56

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_57 = 23
				local var_263_58 = utf8.len(var_263_56)
				local var_263_59 = var_263_57 <= 0 and var_263_53 or var_263_53 * (var_263_58 / var_263_57)

				if var_263_59 > 0 and var_263_53 < var_263_59 then
					arg_260_1.talkMaxDuration = var_263_59

					if var_263_59 + var_263_52 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_59 + var_263_52
					end
				end

				arg_260_1.text_.text = var_263_56
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804064", "story_v_side_old_114804.awb") ~= 0 then
					local var_263_60 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804064", "story_v_side_old_114804.awb") / 1000

					if var_263_60 + var_263_52 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_60 + var_263_52
					end

					if var_263_55.prefab_name ~= "" and arg_260_1.actors_[var_263_55.prefab_name] ~= nil then
						local var_263_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_55.prefab_name].transform, "story_v_side_old_114804", "114804064", "story_v_side_old_114804.awb")

						arg_260_1:RecordAudio("114804064", var_263_61)
						arg_260_1:RecordAudio("114804064", var_263_61)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804064", "story_v_side_old_114804.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804064", "story_v_side_old_114804.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_62 = math.max(var_263_53, arg_260_1.talkMaxDuration)

			if var_263_52 <= arg_260_1.time_ and arg_260_1.time_ < var_263_52 + var_263_62 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_52) / var_263_62

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_52 + var_263_62 and arg_260_1.time_ < var_263_52 + var_263_62 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play114804065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 114804065
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play114804066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 0.25

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_2 = arg_264_1:FormatText(StoryNameCfg[7].name)

				arg_264_1.leftNameTxt_.text = var_267_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_3 = arg_264_1:GetWordFromCfg(114804065)
				local var_267_4 = arg_264_1:FormatText(var_267_3.content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 10
				local var_267_6 = utf8.len(var_267_4)
				local var_267_7 = var_267_5 <= 0 and var_267_1 or var_267_1 * (var_267_6 / var_267_5)

				if var_267_7 > 0 and var_267_1 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_0
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_8 = math.max(var_267_1, arg_264_1.talkMaxDuration)

			if var_267_0 <= arg_264_1.time_ and arg_264_1.time_ < var_267_0 + var_267_8 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_0) / var_267_8

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_0 + var_267_8 and arg_264_1.time_ < var_267_0 + var_267_8 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play114804066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 114804066
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play114804067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 1.05

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_2 = arg_268_1:GetWordFromCfg(114804066)
				local var_271_3 = arg_268_1:FormatText(var_271_2.content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 42
				local var_271_5 = utf8.len(var_271_3)
				local var_271_6 = var_271_4 <= 0 and var_271_1 or var_271_1 * (var_271_5 / var_271_4)

				if var_271_6 > 0 and var_271_1 < var_271_6 then
					arg_268_1.talkMaxDuration = var_271_6

					if var_271_6 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_6 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_7 and arg_268_1.time_ < var_271_0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play114804067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 114804067
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play114804068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 1.275

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_2 = arg_272_1:GetWordFromCfg(114804067)
				local var_275_3 = arg_272_1:FormatText(var_275_2.content)

				arg_272_1.text_.text = var_275_3

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 51
				local var_275_5 = utf8.len(var_275_3)
				local var_275_6 = var_275_4 <= 0 and var_275_1 or var_275_1 * (var_275_5 / var_275_4)

				if var_275_6 > 0 and var_275_1 < var_275_6 then
					arg_272_1.talkMaxDuration = var_275_6

					if var_275_6 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_6 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_3
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_7 and arg_272_1.time_ < var_275_0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play114804068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 114804068
		arg_276_1.duration_ = 8.5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play114804069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 1.5

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				local var_279_1 = manager.ui.mainCamera.transform.localPosition
				local var_279_2 = Vector3.New(0, 0, 10) + Vector3.New(var_279_1.x, var_279_1.y, 0)
				local var_279_3 = arg_276_1.bgs_.ST02

				var_279_3.transform.localPosition = var_279_2
				var_279_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_279_4 = var_279_3:GetComponent("SpriteRenderer")

				if var_279_4 and var_279_4.sprite then
					local var_279_5 = (var_279_3.transform.localPosition - var_279_1).z
					local var_279_6 = manager.ui.mainCameraCom_
					local var_279_7 = 2 * var_279_5 * Mathf.Tan(var_279_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_279_8 = var_279_7 * var_279_6.aspect
					local var_279_9 = var_279_4.sprite.bounds.size.x
					local var_279_10 = var_279_4.sprite.bounds.size.y
					local var_279_11 = var_279_8 / var_279_9
					local var_279_12 = var_279_7 / var_279_10
					local var_279_13 = var_279_12 < var_279_11 and var_279_11 or var_279_12

					var_279_3.transform.localScale = Vector3.New(var_279_13, var_279_13, 0)
				end

				for iter_279_0, iter_279_1 in pairs(arg_276_1.bgs_) do
					if iter_279_0 ~= "ST02" then
						iter_279_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_279_14 = arg_276_1.bgs_.R4801
			local var_279_15 = 0

			if var_279_15 < arg_276_1.time_ and arg_276_1.time_ <= var_279_15 + arg_279_0 then
				local var_279_16 = var_279_14:GetComponent("SpriteRenderer")

				if var_279_16 then
					arg_276_1.var_.alphaOldValueR4801 = var_279_16.color.a
					arg_276_1.var_.alphaMatValueR4801 = var_279_16
				end

				arg_276_1.var_.alphaOldValueR4801 = 1
			end

			local var_279_17 = 1.5

			if var_279_15 <= arg_276_1.time_ and arg_276_1.time_ < var_279_15 + var_279_17 then
				local var_279_18 = (arg_276_1.time_ - var_279_15) / var_279_17
				local var_279_19 = Mathf.Lerp(arg_276_1.var_.alphaOldValueR4801, 0, var_279_18)

				if arg_276_1.var_.alphaMatValueR4801 then
					local var_279_20 = arg_276_1.var_.alphaMatValueR4801.color

					var_279_20.a = var_279_19
					arg_276_1.var_.alphaMatValueR4801.color = var_279_20
				end
			end

			if arg_276_1.time_ >= var_279_15 + var_279_17 and arg_276_1.time_ < var_279_15 + var_279_17 + arg_279_0 and arg_276_1.var_.alphaMatValueR4801 then
				local var_279_21 = arg_276_1.var_.alphaMatValueR4801
				local var_279_22 = var_279_21.color

				var_279_22.a = 0
				var_279_21.color = var_279_22
			end

			local var_279_23 = arg_276_1.bgs_.ST02
			local var_279_24 = 1.5

			if var_279_24 < arg_276_1.time_ and arg_276_1.time_ <= var_279_24 + arg_279_0 then
				local var_279_25 = var_279_23:GetComponent("SpriteRenderer")

				if var_279_25 then
					arg_276_1.var_.alphaOldValueST02 = var_279_25.color.a
					arg_276_1.var_.alphaMatValueST02 = var_279_25
				end

				arg_276_1.var_.alphaOldValueST02 = 0
			end

			local var_279_26 = 1.5

			if var_279_24 <= arg_276_1.time_ and arg_276_1.time_ < var_279_24 + var_279_26 then
				local var_279_27 = (arg_276_1.time_ - var_279_24) / var_279_26
				local var_279_28 = Mathf.Lerp(arg_276_1.var_.alphaOldValueST02, 1, var_279_27)

				if arg_276_1.var_.alphaMatValueST02 then
					local var_279_29 = arg_276_1.var_.alphaMatValueST02.color

					var_279_29.a = var_279_28
					arg_276_1.var_.alphaMatValueST02.color = var_279_29
				end
			end

			if arg_276_1.time_ >= var_279_24 + var_279_26 and arg_276_1.time_ < var_279_24 + var_279_26 + arg_279_0 and arg_276_1.var_.alphaMatValueST02 then
				local var_279_30 = arg_276_1.var_.alphaMatValueST02
				local var_279_31 = var_279_30.color

				var_279_31.a = 1
				var_279_30.color = var_279_31
			end

			if arg_276_1.frameCnt_ <= 1 then
				arg_276_1.dialog_:SetActive(false)
			end

			local var_279_32 = 3.5
			local var_279_33 = 0.475

			if var_279_32 < arg_276_1.time_ and arg_276_1.time_ <= var_279_32 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0

				arg_276_1.dialog_:SetActive(true)

				arg_276_1.dialogCg_.alpha = 0

				local var_279_34 = LeanTween.value(arg_276_1.dialog_, 0, 1, 0.3)

				var_279_34:setOnUpdate(LuaHelper.FloatAction(function(arg_280_0)
					arg_276_1.dialogCg_.alpha = arg_280_0
				end))
				var_279_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_276_1.dialog_)
					var_279_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_276_1.duration_ = arg_276_1.duration_ + 0.3

				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_35 = arg_276_1:GetWordFromCfg(114804068)
				local var_279_36 = arg_276_1:FormatText(var_279_35.content)

				arg_276_1.text_.text = var_279_36

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_37 = 19
				local var_279_38 = utf8.len(var_279_36)
				local var_279_39 = var_279_37 <= 0 and var_279_33 or var_279_33 * (var_279_38 / var_279_37)

				if var_279_39 > 0 and var_279_33 < var_279_39 then
					arg_276_1.talkMaxDuration = var_279_39
					var_279_32 = var_279_32 + 0.3

					if var_279_39 + var_279_32 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_39 + var_279_32
					end
				end

				arg_276_1.text_.text = var_279_36
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_40 = var_279_32 + 0.3
			local var_279_41 = math.max(var_279_33, arg_276_1.talkMaxDuration)

			if var_279_40 <= arg_276_1.time_ and arg_276_1.time_ < var_279_40 + var_279_41 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_40) / var_279_41

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_40 + var_279_41 and arg_276_1.time_ < var_279_40 + var_279_41 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play114804069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 114804069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play114804070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 1.325

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_2 = arg_282_1:GetWordFromCfg(114804069)
				local var_285_3 = arg_282_1:FormatText(var_285_2.content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 53
				local var_285_5 = utf8.len(var_285_3)
				local var_285_6 = var_285_4 <= 0 and var_285_1 or var_285_1 * (var_285_5 / var_285_4)

				if var_285_6 > 0 and var_285_1 < var_285_6 then
					arg_282_1.talkMaxDuration = var_285_6

					if var_285_6 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_7 and arg_282_1.time_ < var_285_0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play114804070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 114804070
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play114804071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.425

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_2 = arg_286_1:GetWordFromCfg(114804070)
				local var_289_3 = arg_286_1:FormatText(var_289_2.content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 17
				local var_289_5 = utf8.len(var_289_3)
				local var_289_6 = var_289_4 <= 0 and var_289_1 or var_289_1 * (var_289_5 / var_289_4)

				if var_289_6 > 0 and var_289_1 < var_289_6 then
					arg_286_1.talkMaxDuration = var_289_6

					if var_289_6 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_6 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_7 and arg_286_1.time_ < var_289_0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play114804071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 114804071
		arg_290_1.duration_ = 3.73

		local var_290_0 = {
			ja = 3.733,
			ko = 2.466,
			zh = 2,
			en = 2.7
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play114804072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1019ui_story"].transform
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.var_.moveOldPos1019ui_story = var_293_0.localPosition

				local var_293_2 = "1019ui_story"

				arg_290_1:ShowWeapon(arg_290_1.var_[var_293_2 .. "Animator"].transform, false)
			end

			local var_293_3 = 0.001

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_3 then
				local var_293_4 = (arg_290_1.time_ - var_293_1) / var_293_3
				local var_293_5 = Vector3.New(-0.2, -1.08, -5.9)

				var_293_0.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1019ui_story, var_293_5, var_293_4)

				local var_293_6 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_6.x, var_293_6.y, var_293_6.z)

				local var_293_7 = var_293_0.localEulerAngles

				var_293_7.z = 0
				var_293_7.x = 0
				var_293_0.localEulerAngles = var_293_7
			end

			if arg_290_1.time_ >= var_293_1 + var_293_3 and arg_290_1.time_ < var_293_1 + var_293_3 + arg_293_0 then
				var_293_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_293_8 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_8.x, var_293_8.y, var_293_8.z)

				local var_293_9 = var_293_0.localEulerAngles

				var_293_9.z = 0
				var_293_9.x = 0
				var_293_0.localEulerAngles = var_293_9
			end

			local var_293_10 = arg_290_1.actors_["1019ui_story"]
			local var_293_11 = 0

			if var_293_11 < arg_290_1.time_ and arg_290_1.time_ <= var_293_11 + arg_293_0 and not isNil(var_293_10) and arg_290_1.var_.characterEffect1019ui_story == nil then
				arg_290_1.var_.characterEffect1019ui_story = var_293_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_12 = 0.2

			if var_293_11 <= arg_290_1.time_ and arg_290_1.time_ < var_293_11 + var_293_12 and not isNil(var_293_10) then
				local var_293_13 = (arg_290_1.time_ - var_293_11) / var_293_12

				if arg_290_1.var_.characterEffect1019ui_story and not isNil(var_293_10) then
					arg_290_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_11 + var_293_12 and arg_290_1.time_ < var_293_11 + var_293_12 + arg_293_0 and not isNil(var_293_10) and arg_290_1.var_.characterEffect1019ui_story then
				arg_290_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_293_14 = 0.0166666666666667

			if var_293_14 < arg_290_1.time_ and arg_290_1.time_ <= var_293_14 + arg_293_0 then
				arg_290_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_293_15 = 0.0166666666666667

			if var_293_15 < arg_290_1.time_ and arg_290_1.time_ <= var_293_15 + arg_293_0 then
				arg_290_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_293_16 = 0
			local var_293_17 = 0.25

			if var_293_16 < arg_290_1.time_ and arg_290_1.time_ <= var_293_16 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_18 = arg_290_1:FormatText(StoryNameCfg[13].name)

				arg_290_1.leftNameTxt_.text = var_293_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_19 = arg_290_1:GetWordFromCfg(114804071)
				local var_293_20 = arg_290_1:FormatText(var_293_19.content)

				arg_290_1.text_.text = var_293_20

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_21 = 10
				local var_293_22 = utf8.len(var_293_20)
				local var_293_23 = var_293_21 <= 0 and var_293_17 or var_293_17 * (var_293_22 / var_293_21)

				if var_293_23 > 0 and var_293_17 < var_293_23 then
					arg_290_1.talkMaxDuration = var_293_23

					if var_293_23 + var_293_16 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_23 + var_293_16
					end
				end

				arg_290_1.text_.text = var_293_20
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804071", "story_v_side_old_114804.awb") ~= 0 then
					local var_293_24 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804071", "story_v_side_old_114804.awb") / 1000

					if var_293_24 + var_293_16 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_24 + var_293_16
					end

					if var_293_19.prefab_name ~= "" and arg_290_1.actors_[var_293_19.prefab_name] ~= nil then
						local var_293_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_19.prefab_name].transform, "story_v_side_old_114804", "114804071", "story_v_side_old_114804.awb")

						arg_290_1:RecordAudio("114804071", var_293_25)
						arg_290_1:RecordAudio("114804071", var_293_25)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804071", "story_v_side_old_114804.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804071", "story_v_side_old_114804.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_26 = math.max(var_293_17, arg_290_1.talkMaxDuration)

			if var_293_16 <= arg_290_1.time_ and arg_290_1.time_ < var_293_16 + var_293_26 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_16) / var_293_26

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_16 + var_293_26 and arg_290_1.time_ < var_293_16 + var_293_26 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play114804072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 114804072
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play114804073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1019ui_story"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1019ui_story == nil then
				arg_294_1.var_.characterEffect1019ui_story = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.2

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect1019ui_story and not isNil(var_297_0) then
					local var_297_4 = Mathf.Lerp(0, 0.5, var_297_3)

					arg_294_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1019ui_story.fillRatio = var_297_4
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1019ui_story then
				local var_297_5 = 0.5

				arg_294_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1019ui_story.fillRatio = var_297_5
			end

			local var_297_6 = 0

			if var_297_6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_297_7 = 0
			local var_297_8 = 0.225

			if var_297_7 < arg_294_1.time_ and arg_294_1.time_ <= var_297_7 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_9 = arg_294_1:FormatText(StoryNameCfg[7].name)

				arg_294_1.leftNameTxt_.text = var_297_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_10 = arg_294_1:GetWordFromCfg(114804072)
				local var_297_11 = arg_294_1:FormatText(var_297_10.content)

				arg_294_1.text_.text = var_297_11

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_12 = 9
				local var_297_13 = utf8.len(var_297_11)
				local var_297_14 = var_297_12 <= 0 and var_297_8 or var_297_8 * (var_297_13 / var_297_12)

				if var_297_14 > 0 and var_297_8 < var_297_14 then
					arg_294_1.talkMaxDuration = var_297_14

					if var_297_14 + var_297_7 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_14 + var_297_7
					end
				end

				arg_294_1.text_.text = var_297_11
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_15 = math.max(var_297_8, arg_294_1.talkMaxDuration)

			if var_297_7 <= arg_294_1.time_ and arg_294_1.time_ < var_297_7 + var_297_15 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_7) / var_297_15

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_7 + var_297_15 and arg_294_1.time_ < var_297_7 + var_297_15 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play114804073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 114804073
		arg_298_1.duration_ = 9.17

		local var_298_0 = {
			ja = 7.9,
			ko = 9.166,
			zh = 7.266,
			en = 6.066
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play114804074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1019ui_story"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect1019ui_story == nil then
				arg_298_1.var_.characterEffect1019ui_story = var_301_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_2 = 0.2

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.characterEffect1019ui_story and not isNil(var_301_0) then
					arg_298_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect1019ui_story then
				arg_298_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_301_4 = 0

			if var_301_4 < arg_298_1.time_ and arg_298_1.time_ <= var_301_4 + arg_301_0 then
				arg_298_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_301_5 = 0

			if var_301_5 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 then
				arg_298_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_301_6 = 0
			local var_301_7 = 1

			if var_301_6 < arg_298_1.time_ and arg_298_1.time_ <= var_301_6 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_8 = arg_298_1:FormatText(StoryNameCfg[13].name)

				arg_298_1.leftNameTxt_.text = var_301_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_9 = arg_298_1:GetWordFromCfg(114804073)
				local var_301_10 = arg_298_1:FormatText(var_301_9.content)

				arg_298_1.text_.text = var_301_10

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_11 = 40
				local var_301_12 = utf8.len(var_301_10)
				local var_301_13 = var_301_11 <= 0 and var_301_7 or var_301_7 * (var_301_12 / var_301_11)

				if var_301_13 > 0 and var_301_7 < var_301_13 then
					arg_298_1.talkMaxDuration = var_301_13

					if var_301_13 + var_301_6 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_13 + var_301_6
					end
				end

				arg_298_1.text_.text = var_301_10
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804073", "story_v_side_old_114804.awb") ~= 0 then
					local var_301_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804073", "story_v_side_old_114804.awb") / 1000

					if var_301_14 + var_301_6 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_14 + var_301_6
					end

					if var_301_9.prefab_name ~= "" and arg_298_1.actors_[var_301_9.prefab_name] ~= nil then
						local var_301_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_9.prefab_name].transform, "story_v_side_old_114804", "114804073", "story_v_side_old_114804.awb")

						arg_298_1:RecordAudio("114804073", var_301_15)
						arg_298_1:RecordAudio("114804073", var_301_15)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804073", "story_v_side_old_114804.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804073", "story_v_side_old_114804.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_16 = math.max(var_301_7, arg_298_1.talkMaxDuration)

			if var_301_6 <= arg_298_1.time_ and arg_298_1.time_ < var_301_6 + var_301_16 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_6) / var_301_16

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_6 + var_301_16 and arg_298_1.time_ < var_301_6 + var_301_16 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play114804074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 114804074
		arg_302_1.duration_ = 5.17

		local var_302_0 = {
			ja = 5.166,
			ko = 3.566,
			zh = 2.8,
			en = 4.666
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
				arg_302_0:Play114804075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				arg_302_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_305_2 = 0
			local var_305_3 = 0.325

			if var_305_2 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_4 = arg_302_1:FormatText(StoryNameCfg[13].name)

				arg_302_1.leftNameTxt_.text = var_305_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_5 = arg_302_1:GetWordFromCfg(114804074)
				local var_305_6 = arg_302_1:FormatText(var_305_5.content)

				arg_302_1.text_.text = var_305_6

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_7 = 13
				local var_305_8 = utf8.len(var_305_6)
				local var_305_9 = var_305_7 <= 0 and var_305_3 or var_305_3 * (var_305_8 / var_305_7)

				if var_305_9 > 0 and var_305_3 < var_305_9 then
					arg_302_1.talkMaxDuration = var_305_9

					if var_305_9 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_9 + var_305_2
					end
				end

				arg_302_1.text_.text = var_305_6
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804074", "story_v_side_old_114804.awb") ~= 0 then
					local var_305_10 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804074", "story_v_side_old_114804.awb") / 1000

					if var_305_10 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_2
					end

					if var_305_5.prefab_name ~= "" and arg_302_1.actors_[var_305_5.prefab_name] ~= nil then
						local var_305_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_5.prefab_name].transform, "story_v_side_old_114804", "114804074", "story_v_side_old_114804.awb")

						arg_302_1:RecordAudio("114804074", var_305_11)
						arg_302_1:RecordAudio("114804074", var_305_11)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804074", "story_v_side_old_114804.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804074", "story_v_side_old_114804.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_12 = math.max(var_305_3, arg_302_1.talkMaxDuration)

			if var_305_2 <= arg_302_1.time_ and arg_302_1.time_ < var_305_2 + var_305_12 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_2) / var_305_12

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_2 + var_305_12 and arg_302_1.time_ < var_305_2 + var_305_12 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play114804075 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 114804075
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play114804076(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1019ui_story"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1019ui_story == nil then
				arg_306_1.var_.characterEffect1019ui_story = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.2

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect1019ui_story and not isNil(var_309_0) then
					local var_309_4 = Mathf.Lerp(0, 0.5, var_309_3)

					arg_306_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1019ui_story.fillRatio = var_309_4
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1019ui_story then
				local var_309_5 = 0.5

				arg_306_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1019ui_story.fillRatio = var_309_5
			end

			local var_309_6 = 0

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_309_7 = 0
			local var_309_8 = 0.15

			if var_309_7 < arg_306_1.time_ and arg_306_1.time_ <= var_309_7 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_9 = arg_306_1:FormatText(StoryNameCfg[7].name)

				arg_306_1.leftNameTxt_.text = var_309_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_10 = arg_306_1:GetWordFromCfg(114804075)
				local var_309_11 = arg_306_1:FormatText(var_309_10.content)

				arg_306_1.text_.text = var_309_11

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_12 = 6
				local var_309_13 = utf8.len(var_309_11)
				local var_309_14 = var_309_12 <= 0 and var_309_8 or var_309_8 * (var_309_13 / var_309_12)

				if var_309_14 > 0 and var_309_8 < var_309_14 then
					arg_306_1.talkMaxDuration = var_309_14

					if var_309_14 + var_309_7 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_14 + var_309_7
					end
				end

				arg_306_1.text_.text = var_309_11
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_15 = math.max(var_309_8, arg_306_1.talkMaxDuration)

			if var_309_7 <= arg_306_1.time_ and arg_306_1.time_ < var_309_7 + var_309_15 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_7) / var_309_15

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_7 + var_309_15 and arg_306_1.time_ < var_309_7 + var_309_15 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play114804076 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 114804076
		arg_310_1.duration_ = 12.07

		local var_310_0 = {
			ja = 12.066,
			ko = 10.6,
			zh = 10.233,
			en = 6.3
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
				arg_310_0:Play114804077(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1019ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1019ui_story == nil then
				arg_310_1.var_.characterEffect1019ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.2

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect1019ui_story and not isNil(var_313_0) then
					arg_310_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1019ui_story then
				arg_310_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_313_4 = 0

			if var_313_4 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_313_5 = 0
			local var_313_6 = 1.25

			if var_313_5 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_7 = arg_310_1:FormatText(StoryNameCfg[13].name)

				arg_310_1.leftNameTxt_.text = var_313_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_8 = arg_310_1:GetWordFromCfg(114804076)
				local var_313_9 = arg_310_1:FormatText(var_313_8.content)

				arg_310_1.text_.text = var_313_9

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_10 = 50
				local var_313_11 = utf8.len(var_313_9)
				local var_313_12 = var_313_10 <= 0 and var_313_6 or var_313_6 * (var_313_11 / var_313_10)

				if var_313_12 > 0 and var_313_6 < var_313_12 then
					arg_310_1.talkMaxDuration = var_313_12

					if var_313_12 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_12 + var_313_5
					end
				end

				arg_310_1.text_.text = var_313_9
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804076", "story_v_side_old_114804.awb") ~= 0 then
					local var_313_13 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804076", "story_v_side_old_114804.awb") / 1000

					if var_313_13 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_13 + var_313_5
					end

					if var_313_8.prefab_name ~= "" and arg_310_1.actors_[var_313_8.prefab_name] ~= nil then
						local var_313_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_8.prefab_name].transform, "story_v_side_old_114804", "114804076", "story_v_side_old_114804.awb")

						arg_310_1:RecordAudio("114804076", var_313_14)
						arg_310_1:RecordAudio("114804076", var_313_14)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804076", "story_v_side_old_114804.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804076", "story_v_side_old_114804.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_15 = math.max(var_313_6, arg_310_1.talkMaxDuration)

			if var_313_5 <= arg_310_1.time_ and arg_310_1.time_ < var_313_5 + var_313_15 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_5) / var_313_15

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_5 + var_313_15 and arg_310_1.time_ < var_313_5 + var_313_15 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play114804077 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 114804077
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play114804078(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1019ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1019ui_story == nil then
				arg_314_1.var_.characterEffect1019ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.2

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect1019ui_story and not isNil(var_317_0) then
					local var_317_4 = Mathf.Lerp(0, 0.5, var_317_3)

					arg_314_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1019ui_story.fillRatio = var_317_4
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1019ui_story then
				local var_317_5 = 0.5

				arg_314_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1019ui_story.fillRatio = var_317_5
			end

			local var_317_6 = 0

			if var_317_6 < arg_314_1.time_ and arg_314_1.time_ <= var_317_6 + arg_317_0 then
				arg_314_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_317_7 = 0
			local var_317_8 = 0.225

			if var_317_7 < arg_314_1.time_ and arg_314_1.time_ <= var_317_7 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_9 = arg_314_1:FormatText(StoryNameCfg[7].name)

				arg_314_1.leftNameTxt_.text = var_317_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_10 = arg_314_1:GetWordFromCfg(114804077)
				local var_317_11 = arg_314_1:FormatText(var_317_10.content)

				arg_314_1.text_.text = var_317_11

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_12 = 9
				local var_317_13 = utf8.len(var_317_11)
				local var_317_14 = var_317_12 <= 0 and var_317_8 or var_317_8 * (var_317_13 / var_317_12)

				if var_317_14 > 0 and var_317_8 < var_317_14 then
					arg_314_1.talkMaxDuration = var_317_14

					if var_317_14 + var_317_7 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_14 + var_317_7
					end
				end

				arg_314_1.text_.text = var_317_11
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_15 = math.max(var_317_8, arg_314_1.talkMaxDuration)

			if var_317_7 <= arg_314_1.time_ and arg_314_1.time_ < var_317_7 + var_317_15 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_7) / var_317_15

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_7 + var_317_15 and arg_314_1.time_ < var_317_7 + var_317_15 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play114804078 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 114804078
		arg_318_1.duration_ = 5.67

		local var_318_0 = {
			ja = 2.7,
			ko = 5.666,
			zh = 4.266,
			en = 4.066
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
				arg_318_0:Play114804079(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1019ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1019ui_story == nil then
				arg_318_1.var_.characterEffect1019ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.2

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect1019ui_story and not isNil(var_321_0) then
					arg_318_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1019ui_story then
				arg_318_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_321_4 = 0

			if var_321_4 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action457")
			end

			local var_321_5 = 0

			if var_321_5 < arg_318_1.time_ and arg_318_1.time_ <= var_321_5 + arg_321_0 then
				arg_318_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_321_6 = 0
			local var_321_7 = 0.55

			if var_321_6 < arg_318_1.time_ and arg_318_1.time_ <= var_321_6 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_8 = arg_318_1:FormatText(StoryNameCfg[13].name)

				arg_318_1.leftNameTxt_.text = var_321_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_9 = arg_318_1:GetWordFromCfg(114804078)
				local var_321_10 = arg_318_1:FormatText(var_321_9.content)

				arg_318_1.text_.text = var_321_10

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_11 = 22
				local var_321_12 = utf8.len(var_321_10)
				local var_321_13 = var_321_11 <= 0 and var_321_7 or var_321_7 * (var_321_12 / var_321_11)

				if var_321_13 > 0 and var_321_7 < var_321_13 then
					arg_318_1.talkMaxDuration = var_321_13

					if var_321_13 + var_321_6 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_13 + var_321_6
					end
				end

				arg_318_1.text_.text = var_321_10
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804078", "story_v_side_old_114804.awb") ~= 0 then
					local var_321_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804078", "story_v_side_old_114804.awb") / 1000

					if var_321_14 + var_321_6 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_14 + var_321_6
					end

					if var_321_9.prefab_name ~= "" and arg_318_1.actors_[var_321_9.prefab_name] ~= nil then
						local var_321_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_9.prefab_name].transform, "story_v_side_old_114804", "114804078", "story_v_side_old_114804.awb")

						arg_318_1:RecordAudio("114804078", var_321_15)
						arg_318_1:RecordAudio("114804078", var_321_15)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804078", "story_v_side_old_114804.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804078", "story_v_side_old_114804.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_16 = math.max(var_321_7, arg_318_1.talkMaxDuration)

			if var_321_6 <= arg_318_1.time_ and arg_318_1.time_ < var_321_6 + var_321_16 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_6) / var_321_16

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_6 + var_321_16 and arg_318_1.time_ < var_321_6 + var_321_16 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play114804079 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 114804079
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play114804080(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["1019ui_story"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1019ui_story == nil then
				arg_322_1.var_.characterEffect1019ui_story = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.2

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect1019ui_story and not isNil(var_325_0) then
					local var_325_4 = Mathf.Lerp(0, 0.5, var_325_3)

					arg_322_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1019ui_story.fillRatio = var_325_4
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1019ui_story then
				local var_325_5 = 0.5

				arg_322_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1019ui_story.fillRatio = var_325_5
			end

			local var_325_6 = 0

			if var_325_6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_6 + arg_325_0 then
				arg_322_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_325_7 = 0
			local var_325_8 = 1.075

			if var_325_7 < arg_322_1.time_ and arg_322_1.time_ <= var_325_7 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_9 = arg_322_1:FormatText(StoryNameCfg[7].name)

				arg_322_1.leftNameTxt_.text = var_325_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_10 = arg_322_1:GetWordFromCfg(114804079)
				local var_325_11 = arg_322_1:FormatText(var_325_10.content)

				arg_322_1.text_.text = var_325_11

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_12 = 43
				local var_325_13 = utf8.len(var_325_11)
				local var_325_14 = var_325_12 <= 0 and var_325_8 or var_325_8 * (var_325_13 / var_325_12)

				if var_325_14 > 0 and var_325_8 < var_325_14 then
					arg_322_1.talkMaxDuration = var_325_14

					if var_325_14 + var_325_7 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_14 + var_325_7
					end
				end

				arg_322_1.text_.text = var_325_11
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_15 = math.max(var_325_8, arg_322_1.talkMaxDuration)

			if var_325_7 <= arg_322_1.time_ and arg_322_1.time_ < var_325_7 + var_325_15 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_7) / var_325_15

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_7 + var_325_15 and arg_322_1.time_ < var_325_7 + var_325_15 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play114804080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 114804080
		arg_326_1.duration_ = 13.8

		local var_326_0 = {
			ja = 11.666,
			ko = 13.8,
			zh = 11.2,
			en = 9.5
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play114804081(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["1019ui_story"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect1019ui_story == nil then
				arg_326_1.var_.characterEffect1019ui_story = var_329_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.2

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.characterEffect1019ui_story and not isNil(var_329_0) then
					arg_326_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect1019ui_story then
				arg_326_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_329_4 = 0

			if var_329_4 < arg_326_1.time_ and arg_326_1.time_ <= var_329_4 + arg_329_0 then
				arg_326_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action472")
			end

			local var_329_5 = 0

			if var_329_5 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
				arg_326_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_329_6 = 0
			local var_329_7 = 1.45

			if var_329_6 < arg_326_1.time_ and arg_326_1.time_ <= var_329_6 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_8 = arg_326_1:FormatText(StoryNameCfg[13].name)

				arg_326_1.leftNameTxt_.text = var_329_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_9 = arg_326_1:GetWordFromCfg(114804080)
				local var_329_10 = arg_326_1:FormatText(var_329_9.content)

				arg_326_1.text_.text = var_329_10

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_11 = 58
				local var_329_12 = utf8.len(var_329_10)
				local var_329_13 = var_329_11 <= 0 and var_329_7 or var_329_7 * (var_329_12 / var_329_11)

				if var_329_13 > 0 and var_329_7 < var_329_13 then
					arg_326_1.talkMaxDuration = var_329_13

					if var_329_13 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_13 + var_329_6
					end
				end

				arg_326_1.text_.text = var_329_10
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804080", "story_v_side_old_114804.awb") ~= 0 then
					local var_329_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804080", "story_v_side_old_114804.awb") / 1000

					if var_329_14 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_14 + var_329_6
					end

					if var_329_9.prefab_name ~= "" and arg_326_1.actors_[var_329_9.prefab_name] ~= nil then
						local var_329_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_9.prefab_name].transform, "story_v_side_old_114804", "114804080", "story_v_side_old_114804.awb")

						arg_326_1:RecordAudio("114804080", var_329_15)
						arg_326_1:RecordAudio("114804080", var_329_15)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804080", "story_v_side_old_114804.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804080", "story_v_side_old_114804.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_16 = math.max(var_329_7, arg_326_1.talkMaxDuration)

			if var_329_6 <= arg_326_1.time_ and arg_326_1.time_ < var_329_6 + var_329_16 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_6) / var_329_16

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_6 + var_329_16 and arg_326_1.time_ < var_329_6 + var_329_16 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play114804081 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 114804081
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play114804082(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1019ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1019ui_story == nil then
				arg_330_1.var_.characterEffect1019ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.2

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect1019ui_story and not isNil(var_333_0) then
					local var_333_4 = Mathf.Lerp(0, 0.5, var_333_3)

					arg_330_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1019ui_story.fillRatio = var_333_4
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1019ui_story then
				local var_333_5 = 0.5

				arg_330_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1019ui_story.fillRatio = var_333_5
			end

			local var_333_6 = 0

			if var_333_6 < arg_330_1.time_ and arg_330_1.time_ <= var_333_6 + arg_333_0 then
				arg_330_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_333_7 = 0
			local var_333_8 = 0.05

			if var_333_7 < arg_330_1.time_ and arg_330_1.time_ <= var_333_7 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_9 = arg_330_1:FormatText(StoryNameCfg[7].name)

				arg_330_1.leftNameTxt_.text = var_333_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_10 = arg_330_1:GetWordFromCfg(114804081)
				local var_333_11 = arg_330_1:FormatText(var_333_10.content)

				arg_330_1.text_.text = var_333_11

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_12 = 2
				local var_333_13 = utf8.len(var_333_11)
				local var_333_14 = var_333_12 <= 0 and var_333_8 or var_333_8 * (var_333_13 / var_333_12)

				if var_333_14 > 0 and var_333_8 < var_333_14 then
					arg_330_1.talkMaxDuration = var_333_14

					if var_333_14 + var_333_7 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_14 + var_333_7
					end
				end

				arg_330_1.text_.text = var_333_11
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_15 = math.max(var_333_8, arg_330_1.talkMaxDuration)

			if var_333_7 <= arg_330_1.time_ and arg_330_1.time_ < var_333_7 + var_333_15 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_7) / var_333_15

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_7 + var_333_15 and arg_330_1.time_ < var_333_7 + var_333_15 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play114804082 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 114804082
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play114804083(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_337_2 = 0
			local var_337_3 = 0.6

			if var_337_2 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_4 = arg_334_1:GetWordFromCfg(114804082)
				local var_337_5 = arg_334_1:FormatText(var_337_4.content)

				arg_334_1.text_.text = var_337_5

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_6 = 24
				local var_337_7 = utf8.len(var_337_5)
				local var_337_8 = var_337_6 <= 0 and var_337_3 or var_337_3 * (var_337_7 / var_337_6)

				if var_337_8 > 0 and var_337_3 < var_337_8 then
					arg_334_1.talkMaxDuration = var_337_8

					if var_337_8 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_2
					end
				end

				arg_334_1.text_.text = var_337_5
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_9 = math.max(var_337_3, arg_334_1.talkMaxDuration)

			if var_337_2 <= arg_334_1.time_ and arg_334_1.time_ < var_337_2 + var_337_9 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_2) / var_337_9

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_2 + var_337_9 and arg_334_1.time_ < var_337_2 + var_337_9 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play114804083 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 114804083
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play114804084(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_341_1 = 0
			local var_341_2 = 1.225

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_3 = arg_338_1:GetWordFromCfg(114804083)
				local var_341_4 = arg_338_1:FormatText(var_341_3.content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 49
				local var_341_6 = utf8.len(var_341_4)
				local var_341_7 = var_341_5 <= 0 and var_341_2 or var_341_2 * (var_341_6 / var_341_5)

				if var_341_7 > 0 and var_341_2 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_1 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_1
					end
				end

				arg_338_1.text_.text = var_341_4
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_8 = math.max(var_341_2, arg_338_1.talkMaxDuration)

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_8 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_1) / var_341_8

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_1 + var_341_8 and arg_338_1.time_ < var_341_1 + var_341_8 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play114804084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 114804084
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play114804085(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_345_1 = 0
			local var_345_2 = 0.3

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_3 = arg_342_1:GetWordFromCfg(114804084)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 12
				local var_345_6 = utf8.len(var_345_4)
				local var_345_7 = var_345_5 <= 0 and var_345_2 or var_345_2 * (var_345_6 / var_345_5)

				if var_345_7 > 0 and var_345_2 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_1 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_1
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_8 = math.max(var_345_2, arg_342_1.talkMaxDuration)

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_8 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_1) / var_345_8

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_1 + var_345_8 and arg_342_1.time_ < var_345_1 + var_345_8 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play114804085 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 114804085
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play114804086(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_349_1 = 0
			local var_349_2 = 0.125

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_3 = arg_346_1:FormatText(StoryNameCfg[7].name)

				arg_346_1.leftNameTxt_.text = var_349_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_4 = arg_346_1:GetWordFromCfg(114804085)
				local var_349_5 = arg_346_1:FormatText(var_349_4.content)

				arg_346_1.text_.text = var_349_5

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_6 = 5
				local var_349_7 = utf8.len(var_349_5)
				local var_349_8 = var_349_6 <= 0 and var_349_2 or var_349_2 * (var_349_7 / var_349_6)

				if var_349_8 > 0 and var_349_2 < var_349_8 then
					arg_346_1.talkMaxDuration = var_349_8

					if var_349_8 + var_349_1 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_1
					end
				end

				arg_346_1.text_.text = var_349_5
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_9 = math.max(var_349_2, arg_346_1.talkMaxDuration)

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_9 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_1) / var_349_9

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_1 + var_349_9 and arg_346_1.time_ < var_349_1 + var_349_9 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play114804086 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 114804086
		arg_350_1.duration_ = 15.8

		local var_350_0 = {
			ja = 9.3,
			ko = 15.8,
			zh = 11.566,
			en = 12.6
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play114804087(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1019ui_story"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1019ui_story == nil then
				arg_350_1.var_.characterEffect1019ui_story = var_353_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.2

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.characterEffect1019ui_story and not isNil(var_353_0) then
					arg_350_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1019ui_story then
				arg_350_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_353_4 = 0

			if var_353_4 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_353_5 = 0

			if var_353_5 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_353_6 = 0
			local var_353_7 = 1.55

			if var_353_6 < arg_350_1.time_ and arg_350_1.time_ <= var_353_6 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_8 = arg_350_1:FormatText(StoryNameCfg[13].name)

				arg_350_1.leftNameTxt_.text = var_353_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_9 = arg_350_1:GetWordFromCfg(114804086)
				local var_353_10 = arg_350_1:FormatText(var_353_9.content)

				arg_350_1.text_.text = var_353_10

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_11 = 62
				local var_353_12 = utf8.len(var_353_10)
				local var_353_13 = var_353_11 <= 0 and var_353_7 or var_353_7 * (var_353_12 / var_353_11)

				if var_353_13 > 0 and var_353_7 < var_353_13 then
					arg_350_1.talkMaxDuration = var_353_13

					if var_353_13 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_13 + var_353_6
					end
				end

				arg_350_1.text_.text = var_353_10
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804086", "story_v_side_old_114804.awb") ~= 0 then
					local var_353_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804086", "story_v_side_old_114804.awb") / 1000

					if var_353_14 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_14 + var_353_6
					end

					if var_353_9.prefab_name ~= "" and arg_350_1.actors_[var_353_9.prefab_name] ~= nil then
						local var_353_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_9.prefab_name].transform, "story_v_side_old_114804", "114804086", "story_v_side_old_114804.awb")

						arg_350_1:RecordAudio("114804086", var_353_15)
						arg_350_1:RecordAudio("114804086", var_353_15)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804086", "story_v_side_old_114804.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804086", "story_v_side_old_114804.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_16 = math.max(var_353_7, arg_350_1.talkMaxDuration)

			if var_353_6 <= arg_350_1.time_ and arg_350_1.time_ < var_353_6 + var_353_16 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_6) / var_353_16

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_6 + var_353_16 and arg_350_1.time_ < var_353_6 + var_353_16 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play114804087 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 114804087
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play114804088(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1019ui_story"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1019ui_story == nil then
				arg_354_1.var_.characterEffect1019ui_story = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.2

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect1019ui_story and not isNil(var_357_0) then
					local var_357_4 = Mathf.Lerp(0, 0.5, var_357_3)

					arg_354_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1019ui_story.fillRatio = var_357_4
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1019ui_story then
				local var_357_5 = 0.5

				arg_354_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1019ui_story.fillRatio = var_357_5
			end

			local var_357_6 = 0

			if var_357_6 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_357_7 = 0
			local var_357_8 = 0.2

			if var_357_7 < arg_354_1.time_ and arg_354_1.time_ <= var_357_7 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_9 = arg_354_1:FormatText(StoryNameCfg[7].name)

				arg_354_1.leftNameTxt_.text = var_357_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_10 = arg_354_1:GetWordFromCfg(114804087)
				local var_357_11 = arg_354_1:FormatText(var_357_10.content)

				arg_354_1.text_.text = var_357_11

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_12 = 8
				local var_357_13 = utf8.len(var_357_11)
				local var_357_14 = var_357_12 <= 0 and var_357_8 or var_357_8 * (var_357_13 / var_357_12)

				if var_357_14 > 0 and var_357_8 < var_357_14 then
					arg_354_1.talkMaxDuration = var_357_14

					if var_357_14 + var_357_7 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_14 + var_357_7
					end
				end

				arg_354_1.text_.text = var_357_11
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_15 = math.max(var_357_8, arg_354_1.talkMaxDuration)

			if var_357_7 <= arg_354_1.time_ and arg_354_1.time_ < var_357_7 + var_357_15 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_7) / var_357_15

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_7 + var_357_15 and arg_354_1.time_ < var_357_7 + var_357_15 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play114804088 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 114804088
		arg_358_1.duration_ = 6.07

		local var_358_0 = {
			ja = 2.266,
			ko = 6.066,
			zh = 5.2,
			en = 5.866
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play114804089(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1019ui_story"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1019ui_story == nil then
				arg_358_1.var_.characterEffect1019ui_story = var_361_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.2

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.characterEffect1019ui_story and not isNil(var_361_0) then
					arg_358_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1019ui_story then
				arg_358_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_361_4 = 0

			if var_361_4 < arg_358_1.time_ and arg_358_1.time_ <= var_361_4 + arg_361_0 then
				arg_358_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_361_5 = 0
			local var_361_6 = 0.65

			if var_361_5 < arg_358_1.time_ and arg_358_1.time_ <= var_361_5 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_7 = arg_358_1:FormatText(StoryNameCfg[13].name)

				arg_358_1.leftNameTxt_.text = var_361_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_8 = arg_358_1:GetWordFromCfg(114804088)
				local var_361_9 = arg_358_1:FormatText(var_361_8.content)

				arg_358_1.text_.text = var_361_9

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_10 = 26
				local var_361_11 = utf8.len(var_361_9)
				local var_361_12 = var_361_10 <= 0 and var_361_6 or var_361_6 * (var_361_11 / var_361_10)

				if var_361_12 > 0 and var_361_6 < var_361_12 then
					arg_358_1.talkMaxDuration = var_361_12

					if var_361_12 + var_361_5 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_12 + var_361_5
					end
				end

				arg_358_1.text_.text = var_361_9
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804088", "story_v_side_old_114804.awb") ~= 0 then
					local var_361_13 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804088", "story_v_side_old_114804.awb") / 1000

					if var_361_13 + var_361_5 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_13 + var_361_5
					end

					if var_361_8.prefab_name ~= "" and arg_358_1.actors_[var_361_8.prefab_name] ~= nil then
						local var_361_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_8.prefab_name].transform, "story_v_side_old_114804", "114804088", "story_v_side_old_114804.awb")

						arg_358_1:RecordAudio("114804088", var_361_14)
						arg_358_1:RecordAudio("114804088", var_361_14)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804088", "story_v_side_old_114804.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804088", "story_v_side_old_114804.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_15 = math.max(var_361_6, arg_358_1.talkMaxDuration)

			if var_361_5 <= arg_358_1.time_ and arg_358_1.time_ < var_361_5 + var_361_15 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_5) / var_361_15

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_5 + var_361_15 and arg_358_1.time_ < var_361_5 + var_361_15 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play114804089 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 114804089
		arg_362_1.duration_ = 16.17

		local var_362_0 = {
			ja = 16.166,
			ko = 15.8,
			zh = 13.7,
			en = 12.933
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
				arg_362_0:Play114804090(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_365_1 = 0
			local var_365_2 = 1.6

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_3 = arg_362_1:FormatText(StoryNameCfg[13].name)

				arg_362_1.leftNameTxt_.text = var_365_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_4 = arg_362_1:GetWordFromCfg(114804089)
				local var_365_5 = arg_362_1:FormatText(var_365_4.content)

				arg_362_1.text_.text = var_365_5

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_6 = 64
				local var_365_7 = utf8.len(var_365_5)
				local var_365_8 = var_365_6 <= 0 and var_365_2 or var_365_2 * (var_365_7 / var_365_6)

				if var_365_8 > 0 and var_365_2 < var_365_8 then
					arg_362_1.talkMaxDuration = var_365_8

					if var_365_8 + var_365_1 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_1
					end
				end

				arg_362_1.text_.text = var_365_5
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804089", "story_v_side_old_114804.awb") ~= 0 then
					local var_365_9 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804089", "story_v_side_old_114804.awb") / 1000

					if var_365_9 + var_365_1 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_9 + var_365_1
					end

					if var_365_4.prefab_name ~= "" and arg_362_1.actors_[var_365_4.prefab_name] ~= nil then
						local var_365_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_4.prefab_name].transform, "story_v_side_old_114804", "114804089", "story_v_side_old_114804.awb")

						arg_362_1:RecordAudio("114804089", var_365_10)
						arg_362_1:RecordAudio("114804089", var_365_10)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804089", "story_v_side_old_114804.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804089", "story_v_side_old_114804.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_11 = math.max(var_365_2, arg_362_1.talkMaxDuration)

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_11 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_1) / var_365_11

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_1 + var_365_11 and arg_362_1.time_ < var_365_1 + var_365_11 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play114804090 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 114804090
		arg_366_1.duration_ = 12.1

		local var_366_0 = {
			ja = 10.766,
			ko = 11,
			zh = 9.033,
			en = 12.1
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play114804091(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_369_1 = 0
			local var_369_2 = 1.1

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_3 = arg_366_1:FormatText(StoryNameCfg[13].name)

				arg_366_1.leftNameTxt_.text = var_369_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_4 = arg_366_1:GetWordFromCfg(114804090)
				local var_369_5 = arg_366_1:FormatText(var_369_4.content)

				arg_366_1.text_.text = var_369_5

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_6 = 44
				local var_369_7 = utf8.len(var_369_5)
				local var_369_8 = var_369_6 <= 0 and var_369_2 or var_369_2 * (var_369_7 / var_369_6)

				if var_369_8 > 0 and var_369_2 < var_369_8 then
					arg_366_1.talkMaxDuration = var_369_8

					if var_369_8 + var_369_1 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_8 + var_369_1
					end
				end

				arg_366_1.text_.text = var_369_5
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804090", "story_v_side_old_114804.awb") ~= 0 then
					local var_369_9 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804090", "story_v_side_old_114804.awb") / 1000

					if var_369_9 + var_369_1 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_9 + var_369_1
					end

					if var_369_4.prefab_name ~= "" and arg_366_1.actors_[var_369_4.prefab_name] ~= nil then
						local var_369_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_4.prefab_name].transform, "story_v_side_old_114804", "114804090", "story_v_side_old_114804.awb")

						arg_366_1:RecordAudio("114804090", var_369_10)
						arg_366_1:RecordAudio("114804090", var_369_10)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804090", "story_v_side_old_114804.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804090", "story_v_side_old_114804.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_11 = math.max(var_369_2, arg_366_1.talkMaxDuration)

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_11 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_1) / var_369_11

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_1 + var_369_11 and arg_366_1.time_ < var_369_1 + var_369_11 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play114804091 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 114804091
		arg_370_1.duration_ = 16

		local var_370_0 = {
			ja = 15.133,
			ko = 16,
			zh = 13.2,
			en = 14.566
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
				arg_370_0:Play114804092(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_373_1 = 0
			local var_373_2 = 1.425

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_3 = arg_370_1:FormatText(StoryNameCfg[13].name)

				arg_370_1.leftNameTxt_.text = var_373_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_4 = arg_370_1:GetWordFromCfg(114804091)
				local var_373_5 = arg_370_1:FormatText(var_373_4.content)

				arg_370_1.text_.text = var_373_5

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_6 = 57
				local var_373_7 = utf8.len(var_373_5)
				local var_373_8 = var_373_6 <= 0 and var_373_2 or var_373_2 * (var_373_7 / var_373_6)

				if var_373_8 > 0 and var_373_2 < var_373_8 then
					arg_370_1.talkMaxDuration = var_373_8

					if var_373_8 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_8 + var_373_1
					end
				end

				arg_370_1.text_.text = var_373_5
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804091", "story_v_side_old_114804.awb") ~= 0 then
					local var_373_9 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804091", "story_v_side_old_114804.awb") / 1000

					if var_373_9 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_9 + var_373_1
					end

					if var_373_4.prefab_name ~= "" and arg_370_1.actors_[var_373_4.prefab_name] ~= nil then
						local var_373_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_4.prefab_name].transform, "story_v_side_old_114804", "114804091", "story_v_side_old_114804.awb")

						arg_370_1:RecordAudio("114804091", var_373_10)
						arg_370_1:RecordAudio("114804091", var_373_10)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804091", "story_v_side_old_114804.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804091", "story_v_side_old_114804.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_11 = math.max(var_373_2, arg_370_1.talkMaxDuration)

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_11 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_1) / var_373_11

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_1 + var_373_11 and arg_370_1.time_ < var_373_1 + var_373_11 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play114804092 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 114804092
		arg_374_1.duration_ = 15.93

		local var_374_0 = {
			ja = 15.933,
			ko = 6.7,
			zh = 6.366,
			en = 6.466
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play114804093(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_377_1 = 0
			local var_377_2 = 0.775

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_3 = arg_374_1:FormatText(StoryNameCfg[13].name)

				arg_374_1.leftNameTxt_.text = var_377_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_4 = arg_374_1:GetWordFromCfg(114804092)
				local var_377_5 = arg_374_1:FormatText(var_377_4.content)

				arg_374_1.text_.text = var_377_5

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_6 = 31
				local var_377_7 = utf8.len(var_377_5)
				local var_377_8 = var_377_6 <= 0 and var_377_2 or var_377_2 * (var_377_7 / var_377_6)

				if var_377_8 > 0 and var_377_2 < var_377_8 then
					arg_374_1.talkMaxDuration = var_377_8

					if var_377_8 + var_377_1 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_8 + var_377_1
					end
				end

				arg_374_1.text_.text = var_377_5
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804092", "story_v_side_old_114804.awb") ~= 0 then
					local var_377_9 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804092", "story_v_side_old_114804.awb") / 1000

					if var_377_9 + var_377_1 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_9 + var_377_1
					end

					if var_377_4.prefab_name ~= "" and arg_374_1.actors_[var_377_4.prefab_name] ~= nil then
						local var_377_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_4.prefab_name].transform, "story_v_side_old_114804", "114804092", "story_v_side_old_114804.awb")

						arg_374_1:RecordAudio("114804092", var_377_10)
						arg_374_1:RecordAudio("114804092", var_377_10)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804092", "story_v_side_old_114804.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804092", "story_v_side_old_114804.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_11 = math.max(var_377_2, arg_374_1.talkMaxDuration)

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_11 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_1) / var_377_11

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_1 + var_377_11 and arg_374_1.time_ < var_377_1 + var_377_11 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play114804093 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 114804093
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play114804094(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_381_2 = arg_378_1.actors_["1019ui_story"]
			local var_381_3 = 0

			if var_381_3 < arg_378_1.time_ and arg_378_1.time_ <= var_381_3 + arg_381_0 and not isNil(var_381_2) and arg_378_1.var_.characterEffect1019ui_story == nil then
				arg_378_1.var_.characterEffect1019ui_story = var_381_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_4 = 0.2

			if var_381_3 <= arg_378_1.time_ and arg_378_1.time_ < var_381_3 + var_381_4 and not isNil(var_381_2) then
				local var_381_5 = (arg_378_1.time_ - var_381_3) / var_381_4

				if arg_378_1.var_.characterEffect1019ui_story and not isNil(var_381_2) then
					local var_381_6 = Mathf.Lerp(0, 0.5, var_381_5)

					arg_378_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1019ui_story.fillRatio = var_381_6
				end
			end

			if arg_378_1.time_ >= var_381_3 + var_381_4 and arg_378_1.time_ < var_381_3 + var_381_4 + arg_381_0 and not isNil(var_381_2) and arg_378_1.var_.characterEffect1019ui_story then
				local var_381_7 = 0.5

				arg_378_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1019ui_story.fillRatio = var_381_7
			end

			local var_381_8 = 0
			local var_381_9 = 1.075

			if var_381_8 < arg_378_1.time_ and arg_378_1.time_ <= var_381_8 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_10 = arg_378_1:GetWordFromCfg(114804093)
				local var_381_11 = arg_378_1:FormatText(var_381_10.content)

				arg_378_1.text_.text = var_381_11

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_12 = 43
				local var_381_13 = utf8.len(var_381_11)
				local var_381_14 = var_381_12 <= 0 and var_381_9 or var_381_9 * (var_381_13 / var_381_12)

				if var_381_14 > 0 and var_381_9 < var_381_14 then
					arg_378_1.talkMaxDuration = var_381_14

					if var_381_14 + var_381_8 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_14 + var_381_8
					end
				end

				arg_378_1.text_.text = var_381_11
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_15 = math.max(var_381_9, arg_378_1.talkMaxDuration)

			if var_381_8 <= arg_378_1.time_ and arg_378_1.time_ < var_381_8 + var_381_15 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_8) / var_381_15

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_8 + var_381_15 and arg_378_1.time_ < var_381_8 + var_381_15 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play114804094 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 114804094
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play114804095(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_385_1 = 0
			local var_385_2 = 0.575

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_3 = arg_382_1:GetWordFromCfg(114804094)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 24
				local var_385_6 = utf8.len(var_385_4)
				local var_385_7 = var_385_5 <= 0 and var_385_2 or var_385_2 * (var_385_6 / var_385_5)

				if var_385_7 > 0 and var_385_2 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_8 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_8 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_8

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_8 and arg_382_1.time_ < var_385_1 + var_385_8 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play114804095 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 114804095
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play114804096(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_389_1 = 0
			local var_389_2 = 1.15

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_3 = arg_386_1:GetWordFromCfg(114804095)
				local var_389_4 = arg_386_1:FormatText(var_389_3.content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 46
				local var_389_6 = utf8.len(var_389_4)
				local var_389_7 = var_389_5 <= 0 and var_389_2 or var_389_2 * (var_389_6 / var_389_5)

				if var_389_7 > 0 and var_389_2 < var_389_7 then
					arg_386_1.talkMaxDuration = var_389_7

					if var_389_7 + var_389_1 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_7 + var_389_1
					end
				end

				arg_386_1.text_.text = var_389_4
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_8 = math.max(var_389_2, arg_386_1.talkMaxDuration)

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_8 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_1) / var_389_8

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_1 + var_389_8 and arg_386_1.time_ < var_389_1 + var_389_8 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play114804096 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 114804096
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play114804097(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_393_1 = 0
			local var_393_2 = 0.475

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_3 = arg_390_1:FormatText(StoryNameCfg[7].name)

				arg_390_1.leftNameTxt_.text = var_393_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_4 = arg_390_1:GetWordFromCfg(114804096)
				local var_393_5 = arg_390_1:FormatText(var_393_4.content)

				arg_390_1.text_.text = var_393_5

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_6 = 19
				local var_393_7 = utf8.len(var_393_5)
				local var_393_8 = var_393_6 <= 0 and var_393_2 or var_393_2 * (var_393_7 / var_393_6)

				if var_393_8 > 0 and var_393_2 < var_393_8 then
					arg_390_1.talkMaxDuration = var_393_8

					if var_393_8 + var_393_1 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_1
					end
				end

				arg_390_1.text_.text = var_393_5
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_9 = math.max(var_393_2, arg_390_1.talkMaxDuration)

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_9 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_1) / var_393_9

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_1 + var_393_9 and arg_390_1.time_ < var_393_1 + var_393_9 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play114804097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 114804097
		arg_394_1.duration_ = 7.47

		local var_394_0 = {
			ja = 7.466,
			ko = 4.7,
			zh = 4.033,
			en = 4.8
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play114804098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1019ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1019ui_story == nil then
				arg_394_1.var_.characterEffect1019ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.2

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect1019ui_story and not isNil(var_397_0) then
					arg_394_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1019ui_story then
				arg_394_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_397_4 = 0

			if var_397_4 < arg_394_1.time_ and arg_394_1.time_ <= var_397_4 + arg_397_0 then
				arg_394_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action3_1")
			end

			local var_397_5 = 0

			if var_397_5 < arg_394_1.time_ and arg_394_1.time_ <= var_397_5 + arg_397_0 then
				arg_394_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_397_6 = 0
			local var_397_7 = 0.45

			if var_397_6 < arg_394_1.time_ and arg_394_1.time_ <= var_397_6 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_8 = arg_394_1:FormatText(StoryNameCfg[13].name)

				arg_394_1.leftNameTxt_.text = var_397_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_9 = arg_394_1:GetWordFromCfg(114804097)
				local var_397_10 = arg_394_1:FormatText(var_397_9.content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_11 = 18
				local var_397_12 = utf8.len(var_397_10)
				local var_397_13 = var_397_11 <= 0 and var_397_7 or var_397_7 * (var_397_12 / var_397_11)

				if var_397_13 > 0 and var_397_7 < var_397_13 then
					arg_394_1.talkMaxDuration = var_397_13

					if var_397_13 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_6
					end
				end

				arg_394_1.text_.text = var_397_10
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804097", "story_v_side_old_114804.awb") ~= 0 then
					local var_397_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804097", "story_v_side_old_114804.awb") / 1000

					if var_397_14 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_14 + var_397_6
					end

					if var_397_9.prefab_name ~= "" and arg_394_1.actors_[var_397_9.prefab_name] ~= nil then
						local var_397_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_9.prefab_name].transform, "story_v_side_old_114804", "114804097", "story_v_side_old_114804.awb")

						arg_394_1:RecordAudio("114804097", var_397_15)
						arg_394_1:RecordAudio("114804097", var_397_15)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804097", "story_v_side_old_114804.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804097", "story_v_side_old_114804.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_16 = math.max(var_397_7, arg_394_1.talkMaxDuration)

			if var_397_6 <= arg_394_1.time_ and arg_394_1.time_ < var_397_6 + var_397_16 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_6) / var_397_16

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_6 + var_397_16 and arg_394_1.time_ < var_397_6 + var_397_16 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play114804098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 114804098
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play114804099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1019ui_story"]
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect1019ui_story == nil then
				arg_398_1.var_.characterEffect1019ui_story = var_401_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.2

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 and not isNil(var_401_0) then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2

				if arg_398_1.var_.characterEffect1019ui_story and not isNil(var_401_0) then
					local var_401_4 = Mathf.Lerp(0, 0.5, var_401_3)

					arg_398_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_398_1.var_.characterEffect1019ui_story.fillRatio = var_401_4
				end
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect1019ui_story then
				local var_401_5 = 0.5

				arg_398_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_398_1.var_.characterEffect1019ui_story.fillRatio = var_401_5
			end

			local var_401_6 = 0

			if var_401_6 < arg_398_1.time_ and arg_398_1.time_ <= var_401_6 + arg_401_0 then
				arg_398_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_401_7 = 0
			local var_401_8 = 0.85

			if var_401_7 < arg_398_1.time_ and arg_398_1.time_ <= var_401_7 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_9 = arg_398_1:GetWordFromCfg(114804098)
				local var_401_10 = arg_398_1:FormatText(var_401_9.content)

				arg_398_1.text_.text = var_401_10

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_11 = 34
				local var_401_12 = utf8.len(var_401_10)
				local var_401_13 = var_401_11 <= 0 and var_401_8 or var_401_8 * (var_401_12 / var_401_11)

				if var_401_13 > 0 and var_401_8 < var_401_13 then
					arg_398_1.talkMaxDuration = var_401_13

					if var_401_13 + var_401_7 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_13 + var_401_7
					end
				end

				arg_398_1.text_.text = var_401_10
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_14 = math.max(var_401_8, arg_398_1.talkMaxDuration)

			if var_401_7 <= arg_398_1.time_ and arg_398_1.time_ < var_401_7 + var_401_14 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_7) / var_401_14

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_7 + var_401_14 and arg_398_1.time_ < var_401_7 + var_401_14 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play114804099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 114804099
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play114804100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_405_1 = 0
			local var_405_2 = 1.175

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_3 = arg_402_1:FormatText(StoryNameCfg[7].name)

				arg_402_1.leftNameTxt_.text = var_405_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_4 = arg_402_1:GetWordFromCfg(114804099)
				local var_405_5 = arg_402_1:FormatText(var_405_4.content)

				arg_402_1.text_.text = var_405_5

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_6 = 47
				local var_405_7 = utf8.len(var_405_5)
				local var_405_8 = var_405_6 <= 0 and var_405_2 or var_405_2 * (var_405_7 / var_405_6)

				if var_405_8 > 0 and var_405_2 < var_405_8 then
					arg_402_1.talkMaxDuration = var_405_8

					if var_405_8 + var_405_1 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_1
					end
				end

				arg_402_1.text_.text = var_405_5
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_9 = math.max(var_405_2, arg_402_1.talkMaxDuration)

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_9 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_1) / var_405_9

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_1 + var_405_9 and arg_402_1.time_ < var_405_1 + var_405_9 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play114804100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 114804100
		arg_406_1.duration_ = 4.7

		local var_406_0 = {
			ja = 3.7,
			ko = 2,
			zh = 1.999999999999,
			en = 4.7
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play114804101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1019ui_story"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1019ui_story == nil then
				arg_406_1.var_.characterEffect1019ui_story = var_409_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.2

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.characterEffect1019ui_story and not isNil(var_409_0) then
					arg_406_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1019ui_story then
				arg_406_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_409_4 = 0

			if var_409_4 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action435")
			end

			local var_409_5 = 0

			if var_409_5 < arg_406_1.time_ and arg_406_1.time_ <= var_409_5 + arg_409_0 then
				arg_406_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_409_6 = 0
			local var_409_7 = 0.3

			if var_409_6 < arg_406_1.time_ and arg_406_1.time_ <= var_409_6 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_8 = arg_406_1:FormatText(StoryNameCfg[13].name)

				arg_406_1.leftNameTxt_.text = var_409_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_9 = arg_406_1:GetWordFromCfg(114804100)
				local var_409_10 = arg_406_1:FormatText(var_409_9.content)

				arg_406_1.text_.text = var_409_10

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_11 = 12
				local var_409_12 = utf8.len(var_409_10)
				local var_409_13 = var_409_11 <= 0 and var_409_7 or var_409_7 * (var_409_12 / var_409_11)

				if var_409_13 > 0 and var_409_7 < var_409_13 then
					arg_406_1.talkMaxDuration = var_409_13

					if var_409_13 + var_409_6 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_13 + var_409_6
					end
				end

				arg_406_1.text_.text = var_409_10
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804100", "story_v_side_old_114804.awb") ~= 0 then
					local var_409_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804100", "story_v_side_old_114804.awb") / 1000

					if var_409_14 + var_409_6 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_14 + var_409_6
					end

					if var_409_9.prefab_name ~= "" and arg_406_1.actors_[var_409_9.prefab_name] ~= nil then
						local var_409_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_9.prefab_name].transform, "story_v_side_old_114804", "114804100", "story_v_side_old_114804.awb")

						arg_406_1:RecordAudio("114804100", var_409_15)
						arg_406_1:RecordAudio("114804100", var_409_15)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804100", "story_v_side_old_114804.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804100", "story_v_side_old_114804.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_16 = math.max(var_409_7, arg_406_1.talkMaxDuration)

			if var_409_6 <= arg_406_1.time_ and arg_406_1.time_ < var_409_6 + var_409_16 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_6) / var_409_16

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_6 + var_409_16 and arg_406_1.time_ < var_409_6 + var_409_16 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play114804101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 114804101
		arg_410_1.duration_ = 13.37

		local var_410_0 = {
			ja = 13.366,
			ko = 12.433,
			zh = 11.8,
			en = 8.966
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play114804102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_413_1 = 0
			local var_413_2 = 1.575

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_3 = arg_410_1:FormatText(StoryNameCfg[13].name)

				arg_410_1.leftNameTxt_.text = var_413_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_4 = arg_410_1:GetWordFromCfg(114804101)
				local var_413_5 = arg_410_1:FormatText(var_413_4.content)

				arg_410_1.text_.text = var_413_5

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_6 = 63
				local var_413_7 = utf8.len(var_413_5)
				local var_413_8 = var_413_6 <= 0 and var_413_2 or var_413_2 * (var_413_7 / var_413_6)

				if var_413_8 > 0 and var_413_2 < var_413_8 then
					arg_410_1.talkMaxDuration = var_413_8

					if var_413_8 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_1
					end
				end

				arg_410_1.text_.text = var_413_5
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804101", "story_v_side_old_114804.awb") ~= 0 then
					local var_413_9 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804101", "story_v_side_old_114804.awb") / 1000

					if var_413_9 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_9 + var_413_1
					end

					if var_413_4.prefab_name ~= "" and arg_410_1.actors_[var_413_4.prefab_name] ~= nil then
						local var_413_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_4.prefab_name].transform, "story_v_side_old_114804", "114804101", "story_v_side_old_114804.awb")

						arg_410_1:RecordAudio("114804101", var_413_10)
						arg_410_1:RecordAudio("114804101", var_413_10)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804101", "story_v_side_old_114804.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804101", "story_v_side_old_114804.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_11 = math.max(var_413_2, arg_410_1.talkMaxDuration)

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_11 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_1) / var_413_11

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_1 + var_413_11 and arg_410_1.time_ < var_413_1 + var_413_11 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play114804102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 114804102
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play114804103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1019ui_story"]
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect1019ui_story == nil then
				arg_414_1.var_.characterEffect1019ui_story = var_417_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_2 = 0.2

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 and not isNil(var_417_0) then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2

				if arg_414_1.var_.characterEffect1019ui_story and not isNil(var_417_0) then
					local var_417_4 = Mathf.Lerp(0, 0.5, var_417_3)

					arg_414_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1019ui_story.fillRatio = var_417_4
				end
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect1019ui_story then
				local var_417_5 = 0.5

				arg_414_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1019ui_story.fillRatio = var_417_5
			end

			local var_417_6 = 0

			if var_417_6 < arg_414_1.time_ and arg_414_1.time_ <= var_417_6 + arg_417_0 then
				arg_414_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_417_7 = 0
			local var_417_8 = 0.075

			if var_417_7 < arg_414_1.time_ and arg_414_1.time_ <= var_417_7 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_9 = arg_414_1:FormatText(StoryNameCfg[7].name)

				arg_414_1.leftNameTxt_.text = var_417_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_10 = arg_414_1:GetWordFromCfg(114804102)
				local var_417_11 = arg_414_1:FormatText(var_417_10.content)

				arg_414_1.text_.text = var_417_11

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_12 = 3
				local var_417_13 = utf8.len(var_417_11)
				local var_417_14 = var_417_12 <= 0 and var_417_8 or var_417_8 * (var_417_13 / var_417_12)

				if var_417_14 > 0 and var_417_8 < var_417_14 then
					arg_414_1.talkMaxDuration = var_417_14

					if var_417_14 + var_417_7 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_14 + var_417_7
					end
				end

				arg_414_1.text_.text = var_417_11
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_15 = math.max(var_417_8, arg_414_1.talkMaxDuration)

			if var_417_7 <= arg_414_1.time_ and arg_414_1.time_ < var_417_7 + var_417_15 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_7) / var_417_15

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_7 + var_417_15 and arg_414_1.time_ < var_417_7 + var_417_15 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play114804103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 114804103
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play114804104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_421_1 = 0
			local var_421_2 = 0.7

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_3 = arg_418_1:GetWordFromCfg(114804103)
				local var_421_4 = arg_418_1:FormatText(var_421_3.content)

				arg_418_1.text_.text = var_421_4

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 28
				local var_421_6 = utf8.len(var_421_4)
				local var_421_7 = var_421_5 <= 0 and var_421_2 or var_421_2 * (var_421_6 / var_421_5)

				if var_421_7 > 0 and var_421_2 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_1 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_1
					end
				end

				arg_418_1.text_.text = var_421_4
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_8 = math.max(var_421_2, arg_418_1.talkMaxDuration)

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_8 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_1) / var_421_8

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_1 + var_421_8 and arg_418_1.time_ < var_421_1 + var_421_8 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play114804104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 114804104
		arg_422_1.duration_ = 8.9

		local var_422_0 = {
			ja = 5.8,
			ko = 7.166,
			zh = 8.9,
			en = 5.8
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play114804105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1019ui_story"]
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1019ui_story == nil then
				arg_422_1.var_.characterEffect1019ui_story = var_425_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_2 = 0.2

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 and not isNil(var_425_0) then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2

				if arg_422_1.var_.characterEffect1019ui_story and not isNil(var_425_0) then
					arg_422_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1019ui_story then
				arg_422_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_425_4 = 0

			if var_425_4 < arg_422_1.time_ and arg_422_1.time_ <= var_425_4 + arg_425_0 then
				arg_422_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_425_5 = 0

			if var_425_5 < arg_422_1.time_ and arg_422_1.time_ <= var_425_5 + arg_425_0 then
				arg_422_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_425_6 = 0
			local var_425_7 = 0.875

			if var_425_6 < arg_422_1.time_ and arg_422_1.time_ <= var_425_6 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_8 = arg_422_1:FormatText(StoryNameCfg[13].name)

				arg_422_1.leftNameTxt_.text = var_425_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_9 = arg_422_1:GetWordFromCfg(114804104)
				local var_425_10 = arg_422_1:FormatText(var_425_9.content)

				arg_422_1.text_.text = var_425_10

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_11 = 35
				local var_425_12 = utf8.len(var_425_10)
				local var_425_13 = var_425_11 <= 0 and var_425_7 or var_425_7 * (var_425_12 / var_425_11)

				if var_425_13 > 0 and var_425_7 < var_425_13 then
					arg_422_1.talkMaxDuration = var_425_13

					if var_425_13 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_13 + var_425_6
					end
				end

				arg_422_1.text_.text = var_425_10
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804104", "story_v_side_old_114804.awb") ~= 0 then
					local var_425_14 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804104", "story_v_side_old_114804.awb") / 1000

					if var_425_14 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_14 + var_425_6
					end

					if var_425_9.prefab_name ~= "" and arg_422_1.actors_[var_425_9.prefab_name] ~= nil then
						local var_425_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_9.prefab_name].transform, "story_v_side_old_114804", "114804104", "story_v_side_old_114804.awb")

						arg_422_1:RecordAudio("114804104", var_425_15)
						arg_422_1:RecordAudio("114804104", var_425_15)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804104", "story_v_side_old_114804.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804104", "story_v_side_old_114804.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_16 = math.max(var_425_7, arg_422_1.talkMaxDuration)

			if var_425_6 <= arg_422_1.time_ and arg_422_1.time_ < var_425_6 + var_425_16 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_6) / var_425_16

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_6 + var_425_16 and arg_422_1.time_ < var_425_6 + var_425_16 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play114804105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 114804105
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play114804106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["1019ui_story"].transform
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.var_.moveOldPos1019ui_story = var_429_0.localPosition
			end

			local var_429_2 = 0.001

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2
				local var_429_4 = Vector3.New(0, 100, 0)

				var_429_0.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1019ui_story, var_429_4, var_429_3)

				local var_429_5 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_5.x, var_429_5.y, var_429_5.z)

				local var_429_6 = var_429_0.localEulerAngles

				var_429_6.z = 0
				var_429_6.x = 0
				var_429_0.localEulerAngles = var_429_6
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 then
				var_429_0.localPosition = Vector3.New(0, 100, 0)

				local var_429_7 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_7.x, var_429_7.y, var_429_7.z)

				local var_429_8 = var_429_0.localEulerAngles

				var_429_8.z = 0
				var_429_8.x = 0
				var_429_0.localEulerAngles = var_429_8
			end

			local var_429_9 = 0
			local var_429_10 = 0.575

			if var_429_9 < arg_426_1.time_ and arg_426_1.time_ <= var_429_9 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_11 = arg_426_1:GetWordFromCfg(114804105)
				local var_429_12 = arg_426_1:FormatText(var_429_11.content)

				arg_426_1.text_.text = var_429_12

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_13 = 23
				local var_429_14 = utf8.len(var_429_12)
				local var_429_15 = var_429_13 <= 0 and var_429_10 or var_429_10 * (var_429_14 / var_429_13)

				if var_429_15 > 0 and var_429_10 < var_429_15 then
					arg_426_1.talkMaxDuration = var_429_15

					if var_429_15 + var_429_9 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_15 + var_429_9
					end
				end

				arg_426_1.text_.text = var_429_12
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_16 = math.max(var_429_10, arg_426_1.talkMaxDuration)

			if var_429_9 <= arg_426_1.time_ and arg_426_1.time_ < var_429_9 + var_429_16 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_9) / var_429_16

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_9 + var_429_16 and arg_426_1.time_ < var_429_9 + var_429_16 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play114804106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 114804106
		arg_430_1.duration_ = 7.5

		local var_430_0 = {
			ja = 7.5,
			ko = 6.5,
			zh = 5.166,
			en = 5.6
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play114804107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1148ui_story"].transform
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.var_.moveOldPos1148ui_story = var_433_0.localPosition

				local var_433_2 = "1148ui_story"

				arg_430_1:ShowWeapon(arg_430_1.var_[var_433_2 .. "Animator"].transform, false)
			end

			local var_433_3 = 0.001

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_3 then
				local var_433_4 = (arg_430_1.time_ - var_433_1) / var_433_3
				local var_433_5 = Vector3.New(0, -0.8, -6.2)

				var_433_0.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1148ui_story, var_433_5, var_433_4)

				local var_433_6 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_6.x, var_433_6.y, var_433_6.z)

				local var_433_7 = var_433_0.localEulerAngles

				var_433_7.z = 0
				var_433_7.x = 0
				var_433_0.localEulerAngles = var_433_7
			end

			if arg_430_1.time_ >= var_433_1 + var_433_3 and arg_430_1.time_ < var_433_1 + var_433_3 + arg_433_0 then
				var_433_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_433_8 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_8.x, var_433_8.y, var_433_8.z)

				local var_433_9 = var_433_0.localEulerAngles

				var_433_9.z = 0
				var_433_9.x = 0
				var_433_0.localEulerAngles = var_433_9
			end

			local var_433_10 = arg_430_1.actors_["1148ui_story"]
			local var_433_11 = 0

			if var_433_11 < arg_430_1.time_ and arg_430_1.time_ <= var_433_11 + arg_433_0 and not isNil(var_433_10) and arg_430_1.var_.characterEffect1148ui_story == nil then
				arg_430_1.var_.characterEffect1148ui_story = var_433_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_12 = 0.2

			if var_433_11 <= arg_430_1.time_ and arg_430_1.time_ < var_433_11 + var_433_12 and not isNil(var_433_10) then
				local var_433_13 = (arg_430_1.time_ - var_433_11) / var_433_12

				if arg_430_1.var_.characterEffect1148ui_story and not isNil(var_433_10) then
					arg_430_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= var_433_11 + var_433_12 and arg_430_1.time_ < var_433_11 + var_433_12 + arg_433_0 and not isNil(var_433_10) and arg_430_1.var_.characterEffect1148ui_story then
				arg_430_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_433_14 = 0.0166666666666667

			if var_433_14 < arg_430_1.time_ and arg_430_1.time_ <= var_433_14 + arg_433_0 then
				arg_430_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_433_15 = 0.0166666666666667

			if var_433_15 < arg_430_1.time_ and arg_430_1.time_ <= var_433_15 + arg_433_0 then
				arg_430_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_433_16 = 0
			local var_433_17 = 0.5

			if var_433_16 < arg_430_1.time_ and arg_430_1.time_ <= var_433_16 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_18 = arg_430_1:FormatText(StoryNameCfg[8].name)

				arg_430_1.leftNameTxt_.text = var_433_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_19 = arg_430_1:GetWordFromCfg(114804106)
				local var_433_20 = arg_430_1:FormatText(var_433_19.content)

				arg_430_1.text_.text = var_433_20

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_21 = 20
				local var_433_22 = utf8.len(var_433_20)
				local var_433_23 = var_433_21 <= 0 and var_433_17 or var_433_17 * (var_433_22 / var_433_21)

				if var_433_23 > 0 and var_433_17 < var_433_23 then
					arg_430_1.talkMaxDuration = var_433_23

					if var_433_23 + var_433_16 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_23 + var_433_16
					end
				end

				arg_430_1.text_.text = var_433_20
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114804", "114804106", "story_v_side_old_114804.awb") ~= 0 then
					local var_433_24 = manager.audio:GetVoiceLength("story_v_side_old_114804", "114804106", "story_v_side_old_114804.awb") / 1000

					if var_433_24 + var_433_16 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_24 + var_433_16
					end

					if var_433_19.prefab_name ~= "" and arg_430_1.actors_[var_433_19.prefab_name] ~= nil then
						local var_433_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_19.prefab_name].transform, "story_v_side_old_114804", "114804106", "story_v_side_old_114804.awb")

						arg_430_1:RecordAudio("114804106", var_433_25)
						arg_430_1:RecordAudio("114804106", var_433_25)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_old_114804", "114804106", "story_v_side_old_114804.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_old_114804", "114804106", "story_v_side_old_114804.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_26 = math.max(var_433_17, arg_430_1.talkMaxDuration)

			if var_433_16 <= arg_430_1.time_ and arg_430_1.time_ < var_433_16 + var_433_26 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_16) / var_433_26

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_16 + var_433_26 and arg_430_1.time_ < var_433_16 + var_433_26 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play114804107 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 114804107
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
			arg_434_1.auto_ = false
		end

		function arg_434_1.playNext_(arg_436_0)
			arg_434_1.onStoryFinished_()
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_437_1 = 0
			local var_437_2 = 0.4

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_3 = arg_434_1:GetWordFromCfg(114804107)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 16
				local var_437_6 = utf8.len(var_437_4)
				local var_437_7 = var_437_5 <= 0 and var_437_2 or var_437_2 * (var_437_6 / var_437_5)

				if var_437_7 > 0 and var_437_2 < var_437_7 then
					arg_434_1.talkMaxDuration = var_437_7

					if var_437_7 + var_437_1 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_1
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_8 = math.max(var_437_2, arg_434_1.talkMaxDuration)

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_8 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_1) / var_437_8

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_1 + var_437_8 and arg_434_1.time_ < var_437_1 + var_437_8 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/R4801"
	},
	voices = {
		"story_v_side_old_114804.awb"
	}
}
