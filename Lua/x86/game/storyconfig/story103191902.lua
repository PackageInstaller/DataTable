return {
	Play319192001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319192001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319192002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D02a"

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
				local var_4_5 = arg_1_1.bgs_.D02a

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
					if iter_4_0 ~= "D02a" then
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
			local var_4_23 = 0.2

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

			local var_4_28 = 0.233333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

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
			local var_4_35 = 1.2

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

				local var_4_37 = arg_1_1:GetWordFromCfg(319192001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 48
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
	Play319192002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319192002
		arg_9_1.duration_ = 4.1

		local var_9_0 = {
			zh = 3.233,
			ja = 4.1
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
				arg_9_0:Play319192003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10066ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["10066ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos10066ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -0.99, -5.83)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10066ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["10066ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10066ui_story == nil then
				arg_9_1.var_.characterEffect10066ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect10066ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10066ui_story then
				arg_9_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.25

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[640].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(319192002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_319192", "319192002", "story_v_out_319192.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_319192", "319192002", "story_v_out_319192.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_319192", "319192002", "story_v_out_319192.awb")

						arg_9_1:RecordAudio("319192002", var_12_29)
						arg_9_1:RecordAudio("319192002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319192", "319192002", "story_v_out_319192.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319192", "319192002", "story_v_out_319192.awb")
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
				actorName = "10066ui_story",
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
	Play319192003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319192003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play319192004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10066ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect10066ui_story == nil then
				arg_13_1.var_.characterEffect10066ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect10066ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10066ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect10066ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10066ui_story.fillRatio = var_16_5
			end

			local var_16_6 = arg_13_1.actors_["10066ui_story"].transform
			local var_16_7 = 0

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				arg_13_1.var_.moveOldPos10066ui_story = var_16_6.localPosition
			end

			local var_16_8 = 0.001

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_7) / var_16_8
				local var_16_10 = Vector3.New(0, 100, 0)

				var_16_6.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10066ui_story, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_6.position

				var_16_6.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_6.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_6.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_7 + var_16_8 and arg_13_1.time_ < var_16_7 + var_16_8 + arg_16_0 then
				var_16_6.localPosition = Vector3.New(0, 100, 0)

				local var_16_13 = manager.ui.mainCamera.transform.position - var_16_6.position

				var_16_6.forward = Vector3.New(var_16_13.x, var_16_13.y, var_16_13.z)

				local var_16_14 = var_16_6.localEulerAngles

				var_16_14.z = 0
				var_16_14.x = 0
				var_16_6.localEulerAngles = var_16_14
			end

			local var_16_15 = 0
			local var_16_16 = 1.45

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_17 = arg_13_1:GetWordFromCfg(319192003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 58
				local var_16_20 = utf8.len(var_16_18)
				local var_16_21 = var_16_19 <= 0 and var_16_16 or var_16_16 * (var_16_20 / var_16_19)

				if var_16_21 > 0 and var_16_16 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21

					if var_16_21 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_18
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_22 and arg_13_1.time_ < var_16_15 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play319192004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319192004
		arg_17_1.duration_ = 4.4

		local var_17_0 = {
			zh = 2.033,
			ja = 4.4
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
				arg_17_0:Play319192005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "10079ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["10079ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos10079ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0, -0.95, -6.05)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10079ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["10079ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect10079ui_story == nil then
				arg_17_1.var_.characterEffect10079ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect10079ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect10079ui_story then
				arg_17_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_20_20 = arg_17_1.actors_["10066ui_story"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos10066ui_story = var_20_20.localPosition
			end

			local var_20_22 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22
				local var_20_24 = Vector3.New(0, 100, 0)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10066ui_story, var_20_24, var_20_23)

				local var_20_25 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_25.x, var_20_25.y, var_20_25.z)

				local var_20_26 = var_20_20.localEulerAngles

				var_20_26.z = 0
				var_20_26.x = 0
				var_20_20.localEulerAngles = var_20_26
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(0, 100, 0)

				local var_20_27 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_27.x, var_20_27.y, var_20_27.z)

				local var_20_28 = var_20_20.localEulerAngles

				var_20_28.z = 0
				var_20_28.x = 0
				var_20_20.localEulerAngles = var_20_28
			end

			local var_20_29 = 0
			local var_20_30 = 0.25

			if var_20_29 < arg_17_1.time_ and arg_17_1.time_ <= var_20_29 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_31 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_32 = arg_17_1:GetWordFromCfg(319192004)
				local var_20_33 = arg_17_1:FormatText(var_20_32.content)

				arg_17_1.text_.text = var_20_33

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_34 = 10
				local var_20_35 = utf8.len(var_20_33)
				local var_20_36 = var_20_34 <= 0 and var_20_30 or var_20_30 * (var_20_35 / var_20_34)

				if var_20_36 > 0 and var_20_30 < var_20_36 then
					arg_17_1.talkMaxDuration = var_20_36

					if var_20_36 + var_20_29 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_36 + var_20_29
					end
				end

				arg_17_1.text_.text = var_20_33
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319192", "319192004", "story_v_out_319192.awb") ~= 0 then
					local var_20_37 = manager.audio:GetVoiceLength("story_v_out_319192", "319192004", "story_v_out_319192.awb") / 1000

					if var_20_37 + var_20_29 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_37 + var_20_29
					end

					if var_20_32.prefab_name ~= "" and arg_17_1.actors_[var_20_32.prefab_name] ~= nil then
						local var_20_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_32.prefab_name].transform, "story_v_out_319192", "319192004", "story_v_out_319192.awb")

						arg_17_1:RecordAudio("319192004", var_20_38)
						arg_17_1:RecordAudio("319192004", var_20_38)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319192", "319192004", "story_v_out_319192.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319192", "319192004", "story_v_out_319192.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_39 = math.max(var_20_30, arg_17_1.talkMaxDuration)

			if var_20_29 <= arg_17_1.time_ and arg_17_1.time_ < var_20_29 + var_20_39 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_29) / var_20_39

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_29 + var_20_39 and arg_17_1.time_ < var_20_29 + var_20_39 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play319192005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319192005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319192006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10079ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10079ui_story == nil then
				arg_21_1.var_.characterEffect10079ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect10079ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10079ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10079ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10079ui_story.fillRatio = var_24_5
			end

			local var_24_6 = arg_21_1.actors_["10079ui_story"].transform
			local var_24_7 = 0

			if var_24_7 < arg_21_1.time_ and arg_21_1.time_ <= var_24_7 + arg_24_0 then
				arg_21_1.var_.moveOldPos10079ui_story = var_24_6.localPosition
			end

			local var_24_8 = 0.001

			if var_24_7 <= arg_21_1.time_ and arg_21_1.time_ < var_24_7 + var_24_8 then
				local var_24_9 = (arg_21_1.time_ - var_24_7) / var_24_8
				local var_24_10 = Vector3.New(0, 100, 0)

				var_24_6.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10079ui_story, var_24_10, var_24_9)

				local var_24_11 = manager.ui.mainCamera.transform.position - var_24_6.position

				var_24_6.forward = Vector3.New(var_24_11.x, var_24_11.y, var_24_11.z)

				local var_24_12 = var_24_6.localEulerAngles

				var_24_12.z = 0
				var_24_12.x = 0
				var_24_6.localEulerAngles = var_24_12
			end

			if arg_21_1.time_ >= var_24_7 + var_24_8 and arg_21_1.time_ < var_24_7 + var_24_8 + arg_24_0 then
				var_24_6.localPosition = Vector3.New(0, 100, 0)

				local var_24_13 = manager.ui.mainCamera.transform.position - var_24_6.position

				var_24_6.forward = Vector3.New(var_24_13.x, var_24_13.y, var_24_13.z)

				local var_24_14 = var_24_6.localEulerAngles

				var_24_14.z = 0
				var_24_14.x = 0
				var_24_6.localEulerAngles = var_24_14
			end

			local var_24_15 = 0
			local var_24_16 = 1.1

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_17 = arg_21_1:GetWordFromCfg(319192005)
				local var_24_18 = arg_21_1:FormatText(var_24_17.content)

				arg_21_1.text_.text = var_24_18

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_19 = 44
				local var_24_20 = utf8.len(var_24_18)
				local var_24_21 = var_24_19 <= 0 and var_24_16 or var_24_16 * (var_24_20 / var_24_19)

				if var_24_21 > 0 and var_24_16 < var_24_21 then
					arg_21_1.talkMaxDuration = var_24_21

					if var_24_21 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_21 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_18
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_22 and arg_21_1.time_ < var_24_15 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319192006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319192006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319192007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 1.1

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

				local var_28_2 = arg_25_1:GetWordFromCfg(319192006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 44
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
	Play319192007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319192007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319192008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.2

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

				local var_32_2 = arg_29_1:GetWordFromCfg(319192007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 48
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
	Play319192008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319192008
		arg_33_1.duration_ = 5.33

		local var_33_0 = {
			zh = 3.833,
			ja = 5.333
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
				arg_33_0:Play319192009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10066ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10066ui_story == nil then
				arg_33_1.var_.characterEffect10066ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10066ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10066ui_story then
				arg_33_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			local var_36_5 = arg_33_1.actors_["10066ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos10066ui_story = var_36_5.localPosition
			end

			local var_36_7 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7
				local var_36_9 = Vector3.New(-0.7, -0.99, -5.83)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10066ui_story, var_36_9, var_36_8)

				local var_36_10 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_10.x, var_36_10.y, var_36_10.z)

				local var_36_11 = var_36_5.localEulerAngles

				var_36_11.z = 0
				var_36_11.x = 0
				var_36_5.localEulerAngles = var_36_11
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_36_12 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_12.x, var_36_12.y, var_36_12.z)

				local var_36_13 = var_36_5.localEulerAngles

				var_36_13.z = 0
				var_36_13.x = 0
				var_36_5.localEulerAngles = var_36_13
			end

			local var_36_14 = 0
			local var_36_15 = 0.475

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_16 = arg_33_1:FormatText(StoryNameCfg[640].name)

				arg_33_1.leftNameTxt_.text = var_36_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_17 = arg_33_1:GetWordFromCfg(319192008)
				local var_36_18 = arg_33_1:FormatText(var_36_17.content)

				arg_33_1.text_.text = var_36_18

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_19 = 19
				local var_36_20 = utf8.len(var_36_18)
				local var_36_21 = var_36_19 <= 0 and var_36_15 or var_36_15 * (var_36_20 / var_36_19)

				if var_36_21 > 0 and var_36_15 < var_36_21 then
					arg_33_1.talkMaxDuration = var_36_21

					if var_36_21 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_21 + var_36_14
					end
				end

				arg_33_1.text_.text = var_36_18
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319192", "319192008", "story_v_out_319192.awb") ~= 0 then
					local var_36_22 = manager.audio:GetVoiceLength("story_v_out_319192", "319192008", "story_v_out_319192.awb") / 1000

					if var_36_22 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_14
					end

					if var_36_17.prefab_name ~= "" and arg_33_1.actors_[var_36_17.prefab_name] ~= nil then
						local var_36_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_17.prefab_name].transform, "story_v_out_319192", "319192008", "story_v_out_319192.awb")

						arg_33_1:RecordAudio("319192008", var_36_23)
						arg_33_1:RecordAudio("319192008", var_36_23)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319192", "319192008", "story_v_out_319192.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319192", "319192008", "story_v_out_319192.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_24 = math.max(var_36_15, arg_33_1.talkMaxDuration)

			if var_36_14 <= arg_33_1.time_ and arg_33_1.time_ < var_36_14 + var_36_24 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_14) / var_36_24

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_14 + var_36_24 and arg_33_1.time_ < var_36_14 + var_36_24 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play319192009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319192009
		arg_37_1.duration_ = 2.23

		local var_37_0 = {
			zh = 2.233,
			ja = 2.2
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
				arg_37_0:Play319192010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10079ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10079ui_story == nil then
				arg_37_1.var_.characterEffect10079ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10079ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10079ui_story then
				arg_37_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["10066ui_story"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10066ui_story == nil then
				arg_37_1.var_.characterEffect10066ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.characterEffect10066ui_story and not isNil(var_40_4) then
					local var_40_8 = Mathf.Lerp(0, 0.5, var_40_7)

					arg_37_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10066ui_story.fillRatio = var_40_8
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10066ui_story then
				local var_40_9 = 0.5

				arg_37_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10066ui_story.fillRatio = var_40_9
			end

			local var_40_10 = arg_37_1.actors_["10079ui_story"].transform
			local var_40_11 = 0

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.var_.moveOldPos10079ui_story = var_40_10.localPosition
			end

			local var_40_12 = 0.001

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_12 then
				local var_40_13 = (arg_37_1.time_ - var_40_11) / var_40_12
				local var_40_14 = Vector3.New(0.7, -0.95, -6.05)

				var_40_10.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10079ui_story, var_40_14, var_40_13)

				local var_40_15 = manager.ui.mainCamera.transform.position - var_40_10.position

				var_40_10.forward = Vector3.New(var_40_15.x, var_40_15.y, var_40_15.z)

				local var_40_16 = var_40_10.localEulerAngles

				var_40_16.z = 0
				var_40_16.x = 0
				var_40_10.localEulerAngles = var_40_16
			end

			if arg_37_1.time_ >= var_40_11 + var_40_12 and arg_37_1.time_ < var_40_11 + var_40_12 + arg_40_0 then
				var_40_10.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_40_17 = manager.ui.mainCamera.transform.position - var_40_10.position

				var_40_10.forward = Vector3.New(var_40_17.x, var_40_17.y, var_40_17.z)

				local var_40_18 = var_40_10.localEulerAngles

				var_40_18.z = 0
				var_40_18.x = 0
				var_40_10.localEulerAngles = var_40_18
			end

			local var_40_19 = 0
			local var_40_20 = 0.3

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_21 = arg_37_1:FormatText(StoryNameCfg[6].name)

				arg_37_1.leftNameTxt_.text = var_40_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_22 = arg_37_1:GetWordFromCfg(319192009)
				local var_40_23 = arg_37_1:FormatText(var_40_22.content)

				arg_37_1.text_.text = var_40_23

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_24 = 12
				local var_40_25 = utf8.len(var_40_23)
				local var_40_26 = var_40_24 <= 0 and var_40_20 or var_40_20 * (var_40_25 / var_40_24)

				if var_40_26 > 0 and var_40_20 < var_40_26 then
					arg_37_1.talkMaxDuration = var_40_26

					if var_40_26 + var_40_19 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_26 + var_40_19
					end
				end

				arg_37_1.text_.text = var_40_23
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319192", "319192009", "story_v_out_319192.awb") ~= 0 then
					local var_40_27 = manager.audio:GetVoiceLength("story_v_out_319192", "319192009", "story_v_out_319192.awb") / 1000

					if var_40_27 + var_40_19 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_27 + var_40_19
					end

					if var_40_22.prefab_name ~= "" and arg_37_1.actors_[var_40_22.prefab_name] ~= nil then
						local var_40_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_22.prefab_name].transform, "story_v_out_319192", "319192009", "story_v_out_319192.awb")

						arg_37_1:RecordAudio("319192009", var_40_28)
						arg_37_1:RecordAudio("319192009", var_40_28)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319192", "319192009", "story_v_out_319192.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319192", "319192009", "story_v_out_319192.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_29 = math.max(var_40_20, arg_37_1.talkMaxDuration)

			if var_40_19 <= arg_37_1.time_ and arg_37_1.time_ < var_40_19 + var_40_29 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_19) / var_40_29

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_19 + var_40_29 and arg_37_1.time_ < var_40_19 + var_40_29 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319192010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319192010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play319192011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10079ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10079ui_story == nil then
				arg_41_1.var_.characterEffect10079ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10079ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10079ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10079ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10079ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 1

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(319192010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 40
				local var_44_11 = utf8.len(var_44_9)
				local var_44_12 = var_44_10 <= 0 and var_44_7 or var_44_7 * (var_44_11 / var_44_10)

				if var_44_12 > 0 and var_44_7 < var_44_12 then
					arg_41_1.talkMaxDuration = var_44_12

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_13 and arg_41_1.time_ < var_44_6 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play319192011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319192011
		arg_45_1.duration_ = 7.27

		local var_45_0 = {
			zh = 2.566,
			ja = 7.266
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
				arg_45_0:Play319192012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10066ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10066ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10066ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["10066ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect10066ui_story == nil then
				arg_45_1.var_.characterEffect10066ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect10066ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect10066ui_story then
				arg_45_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			local var_48_15 = 0
			local var_48_16 = 0.275

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[640].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(319192011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 11
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319192", "319192011", "story_v_out_319192.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_319192", "319192011", "story_v_out_319192.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_319192", "319192011", "story_v_out_319192.awb")

						arg_45_1:RecordAudio("319192011", var_48_24)
						arg_45_1:RecordAudio("319192011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319192", "319192011", "story_v_out_319192.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319192", "319192011", "story_v_out_319192.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319192012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319192012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play319192013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10066ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10066ui_story == nil then
				arg_49_1.var_.characterEffect10066ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10066ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10066ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10066ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10066ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 1

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				local var_52_8 = "play"
				local var_52_9 = "effect"

				arg_49_1:AudioAction(var_52_8, var_52_9, "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			local var_52_10 = 0
			local var_52_11 = 1

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				local var_52_12 = "play"
				local var_52_13 = "effect"

				arg_49_1:AudioAction(var_52_12, var_52_13, "se_story_122_02", "se_story_122_02_energy", "")
			end

			local var_52_14 = arg_49_1.actors_["10066ui_story"].transform
			local var_52_15 = 0

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.var_.moveOldPos10066ui_story = var_52_14.localPosition
			end

			local var_52_16 = 0.001

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_16 then
				local var_52_17 = (arg_49_1.time_ - var_52_15) / var_52_16
				local var_52_18 = Vector3.New(0, 100, 0)

				var_52_14.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10066ui_story, var_52_18, var_52_17)

				local var_52_19 = manager.ui.mainCamera.transform.position - var_52_14.position

				var_52_14.forward = Vector3.New(var_52_19.x, var_52_19.y, var_52_19.z)

				local var_52_20 = var_52_14.localEulerAngles

				var_52_20.z = 0
				var_52_20.x = 0
				var_52_14.localEulerAngles = var_52_20
			end

			if arg_49_1.time_ >= var_52_15 + var_52_16 and arg_49_1.time_ < var_52_15 + var_52_16 + arg_52_0 then
				var_52_14.localPosition = Vector3.New(0, 100, 0)

				local var_52_21 = manager.ui.mainCamera.transform.position - var_52_14.position

				var_52_14.forward = Vector3.New(var_52_21.x, var_52_21.y, var_52_21.z)

				local var_52_22 = var_52_14.localEulerAngles

				var_52_22.z = 0
				var_52_22.x = 0
				var_52_14.localEulerAngles = var_52_22
			end

			local var_52_23 = arg_49_1.actors_["10079ui_story"].transform
			local var_52_24 = 0

			if var_52_24 < arg_49_1.time_ and arg_49_1.time_ <= var_52_24 + arg_52_0 then
				arg_49_1.var_.moveOldPos10079ui_story = var_52_23.localPosition
			end

			local var_52_25 = 0.001

			if var_52_24 <= arg_49_1.time_ and arg_49_1.time_ < var_52_24 + var_52_25 then
				local var_52_26 = (arg_49_1.time_ - var_52_24) / var_52_25
				local var_52_27 = Vector3.New(0, 100, 0)

				var_52_23.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10079ui_story, var_52_27, var_52_26)

				local var_52_28 = manager.ui.mainCamera.transform.position - var_52_23.position

				var_52_23.forward = Vector3.New(var_52_28.x, var_52_28.y, var_52_28.z)

				local var_52_29 = var_52_23.localEulerAngles

				var_52_29.z = 0
				var_52_29.x = 0
				var_52_23.localEulerAngles = var_52_29
			end

			if arg_49_1.time_ >= var_52_24 + var_52_25 and arg_49_1.time_ < var_52_24 + var_52_25 + arg_52_0 then
				var_52_23.localPosition = Vector3.New(0, 100, 0)

				local var_52_30 = manager.ui.mainCamera.transform.position - var_52_23.position

				var_52_23.forward = Vector3.New(var_52_30.x, var_52_30.y, var_52_30.z)

				local var_52_31 = var_52_23.localEulerAngles

				var_52_31.z = 0
				var_52_31.x = 0
				var_52_23.localEulerAngles = var_52_31
			end

			local var_52_32 = 0
			local var_52_33 = 1.075

			if var_52_32 < arg_49_1.time_ and arg_49_1.time_ <= var_52_32 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_34 = arg_49_1:GetWordFromCfg(319192012)
				local var_52_35 = arg_49_1:FormatText(var_52_34.content)

				arg_49_1.text_.text = var_52_35

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_36 = 43
				local var_52_37 = utf8.len(var_52_35)
				local var_52_38 = var_52_36 <= 0 and var_52_33 or var_52_33 * (var_52_37 / var_52_36)

				if var_52_38 > 0 and var_52_33 < var_52_38 then
					arg_49_1.talkMaxDuration = var_52_38

					if var_52_38 + var_52_32 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_38 + var_52_32
					end
				end

				arg_49_1.text_.text = var_52_35
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_39 = math.max(var_52_33, arg_49_1.talkMaxDuration)

			if var_52_32 <= arg_49_1.time_ and arg_49_1.time_ < var_52_32 + var_52_39 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_32) / var_52_39

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_32 + var_52_39 and arg_49_1.time_ < var_52_32 + var_52_39 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play319192013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319192013
		arg_53_1.duration_ = 5.67

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play319192014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = manager.ui.mainCamera.transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_0.localPosition
			end

			local var_56_2 = 0.666666666666667

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / 0.066
				local var_56_4, var_56_5 = math.modf(var_56_3)

				var_56_0.localPosition = Vector3.New(var_56_5 * 0.13, var_56_5 * 0.13, var_56_5 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_6 = 0.666666666666667
			local var_56_7 = 1.125

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_8 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_8:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_9 = arg_53_1:GetWordFromCfg(319192013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 45
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13
					var_56_6 = var_56_6 + 0.3

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = var_56_6 + 0.3
			local var_56_15 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_14 <= arg_53_1.time_ and arg_53_1.time_ < var_56_14 + var_56_15 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_14) / var_56_15

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_14 + var_56_15 and arg_53_1.time_ < var_56_14 + var_56_15 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play319192014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319192014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play319192015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 1.375

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(319192014)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 55
				local var_62_5 = utf8.len(var_62_3)
				local var_62_6 = var_62_4 <= 0 and var_62_1 or var_62_1 * (var_62_5 / var_62_4)

				if var_62_6 > 0 and var_62_1 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_7 and arg_59_1.time_ < var_62_0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play319192015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319192015
		arg_63_1.duration_ = 4

		local var_63_0 = {
			zh = 1.999999999999,
			ja = 4
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
			arg_63_1.auto_ = false
		end

		function arg_63_1.playNext_(arg_65_0)
			arg_63_1.onStoryFinished_()
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = "10058ui_story"

			if arg_63_1.actors_[var_66_0] == nil then
				local var_66_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_66_1) then
					local var_66_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_63_1.stage_.transform)

					var_66_2.name = var_66_0
					var_66_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_63_1.actors_[var_66_0] = var_66_2

					local var_66_3 = var_66_2:GetComponentInChildren(typeof(CharacterEffect))

					var_66_3.enabled = true

					local var_66_4 = GameObjectTools.GetOrAddComponent(var_66_2, typeof(DynamicBoneHelper))

					if var_66_4 then
						var_66_4:EnableDynamicBone(false)
					end

					arg_63_1:ShowWeapon(var_66_3.transform, false)

					arg_63_1.var_[var_66_0 .. "Animator"] = var_66_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_63_1.var_[var_66_0 .. "Animator"].applyRootMotion = true
					arg_63_1.var_[var_66_0 .. "LipSync"] = var_66_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_66_5 = arg_63_1.actors_["10058ui_story"].transform
			local var_66_6 = 0

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.var_.moveOldPos10058ui_story = var_66_5.localPosition
			end

			local var_66_7 = 0.001

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_7 then
				local var_66_8 = (arg_63_1.time_ - var_66_6) / var_66_7
				local var_66_9 = Vector3.New(0, -0.98, -6.1)

				var_66_5.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10058ui_story, var_66_9, var_66_8)

				local var_66_10 = manager.ui.mainCamera.transform.position - var_66_5.position

				var_66_5.forward = Vector3.New(var_66_10.x, var_66_10.y, var_66_10.z)

				local var_66_11 = var_66_5.localEulerAngles

				var_66_11.z = 0
				var_66_11.x = 0
				var_66_5.localEulerAngles = var_66_11
			end

			if arg_63_1.time_ >= var_66_6 + var_66_7 and arg_63_1.time_ < var_66_6 + var_66_7 + arg_66_0 then
				var_66_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_66_12 = manager.ui.mainCamera.transform.position - var_66_5.position

				var_66_5.forward = Vector3.New(var_66_12.x, var_66_12.y, var_66_12.z)

				local var_66_13 = var_66_5.localEulerAngles

				var_66_13.z = 0
				var_66_13.x = 0
				var_66_5.localEulerAngles = var_66_13
			end

			local var_66_14 = arg_63_1.actors_["10058ui_story"]
			local var_66_15 = 0

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 and not isNil(var_66_14) and arg_63_1.var_.characterEffect10058ui_story == nil then
				arg_63_1.var_.characterEffect10058ui_story = var_66_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_16 = 0.200000002980232

			if var_66_15 <= arg_63_1.time_ and arg_63_1.time_ < var_66_15 + var_66_16 and not isNil(var_66_14) then
				local var_66_17 = (arg_63_1.time_ - var_66_15) / var_66_16

				if arg_63_1.var_.characterEffect10058ui_story and not isNil(var_66_14) then
					arg_63_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_15 + var_66_16 and arg_63_1.time_ < var_66_15 + var_66_16 + arg_66_0 and not isNil(var_66_14) and arg_63_1.var_.characterEffect10058ui_story then
				arg_63_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_66_18 = 0

			if var_66_18 < arg_63_1.time_ and arg_63_1.time_ <= var_66_18 + arg_66_0 then
				arg_63_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_66_19 = 0

			if var_66_19 < arg_63_1.time_ and arg_63_1.time_ <= var_66_19 + arg_66_0 then
				arg_63_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_20 = arg_63_1.actors_["10079ui_story"].transform
			local var_66_21 = 0

			if var_66_21 < arg_63_1.time_ and arg_63_1.time_ <= var_66_21 + arg_66_0 then
				arg_63_1.var_.moveOldPos10079ui_story = var_66_20.localPosition
			end

			local var_66_22 = 0.001

			if var_66_21 <= arg_63_1.time_ and arg_63_1.time_ < var_66_21 + var_66_22 then
				local var_66_23 = (arg_63_1.time_ - var_66_21) / var_66_22
				local var_66_24 = Vector3.New(0, 100, 0)

				var_66_20.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10079ui_story, var_66_24, var_66_23)

				local var_66_25 = manager.ui.mainCamera.transform.position - var_66_20.position

				var_66_20.forward = Vector3.New(var_66_25.x, var_66_25.y, var_66_25.z)

				local var_66_26 = var_66_20.localEulerAngles

				var_66_26.z = 0
				var_66_26.x = 0
				var_66_20.localEulerAngles = var_66_26
			end

			if arg_63_1.time_ >= var_66_21 + var_66_22 and arg_63_1.time_ < var_66_21 + var_66_22 + arg_66_0 then
				var_66_20.localPosition = Vector3.New(0, 100, 0)

				local var_66_27 = manager.ui.mainCamera.transform.position - var_66_20.position

				var_66_20.forward = Vector3.New(var_66_27.x, var_66_27.y, var_66_27.z)

				local var_66_28 = var_66_20.localEulerAngles

				var_66_28.z = 0
				var_66_28.x = 0
				var_66_20.localEulerAngles = var_66_28
			end

			local var_66_29 = arg_63_1.actors_["10079ui_story"]
			local var_66_30 = 0

			if var_66_30 < arg_63_1.time_ and arg_63_1.time_ <= var_66_30 + arg_66_0 and not isNil(var_66_29) and arg_63_1.var_.characterEffect10079ui_story == nil then
				arg_63_1.var_.characterEffect10079ui_story = var_66_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_31 = 0.200000002980232

			if var_66_30 <= arg_63_1.time_ and arg_63_1.time_ < var_66_30 + var_66_31 and not isNil(var_66_29) then
				local var_66_32 = (arg_63_1.time_ - var_66_30) / var_66_31

				if arg_63_1.var_.characterEffect10079ui_story and not isNil(var_66_29) then
					local var_66_33 = Mathf.Lerp(0, 0.5, var_66_32)

					arg_63_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10079ui_story.fillRatio = var_66_33
				end
			end

			if arg_63_1.time_ >= var_66_30 + var_66_31 and arg_63_1.time_ < var_66_30 + var_66_31 + arg_66_0 and not isNil(var_66_29) and arg_63_1.var_.characterEffect10079ui_story then
				local var_66_34 = 0.5

				arg_63_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10079ui_story.fillRatio = var_66_34
			end

			local var_66_35 = arg_63_1.actors_["10066ui_story"].transform
			local var_66_36 = 0

			if var_66_36 < arg_63_1.time_ and arg_63_1.time_ <= var_66_36 + arg_66_0 then
				arg_63_1.var_.moveOldPos10066ui_story = var_66_35.localPosition
			end

			local var_66_37 = 0.001

			if var_66_36 <= arg_63_1.time_ and arg_63_1.time_ < var_66_36 + var_66_37 then
				local var_66_38 = (arg_63_1.time_ - var_66_36) / var_66_37
				local var_66_39 = Vector3.New(0, 100, 0)

				var_66_35.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10066ui_story, var_66_39, var_66_38)

				local var_66_40 = manager.ui.mainCamera.transform.position - var_66_35.position

				var_66_35.forward = Vector3.New(var_66_40.x, var_66_40.y, var_66_40.z)

				local var_66_41 = var_66_35.localEulerAngles

				var_66_41.z = 0
				var_66_41.x = 0
				var_66_35.localEulerAngles = var_66_41
			end

			if arg_63_1.time_ >= var_66_36 + var_66_37 and arg_63_1.time_ < var_66_36 + var_66_37 + arg_66_0 then
				var_66_35.localPosition = Vector3.New(0, 100, 0)

				local var_66_42 = manager.ui.mainCamera.transform.position - var_66_35.position

				var_66_35.forward = Vector3.New(var_66_42.x, var_66_42.y, var_66_42.z)

				local var_66_43 = var_66_35.localEulerAngles

				var_66_43.z = 0
				var_66_43.x = 0
				var_66_35.localEulerAngles = var_66_43
			end

			local var_66_44 = arg_63_1.actors_["10066ui_story"]
			local var_66_45 = 0

			if var_66_45 < arg_63_1.time_ and arg_63_1.time_ <= var_66_45 + arg_66_0 and not isNil(var_66_44) and arg_63_1.var_.characterEffect10066ui_story == nil then
				arg_63_1.var_.characterEffect10066ui_story = var_66_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_46 = 0.200000002980232

			if var_66_45 <= arg_63_1.time_ and arg_63_1.time_ < var_66_45 + var_66_46 and not isNil(var_66_44) then
				local var_66_47 = (arg_63_1.time_ - var_66_45) / var_66_46

				if arg_63_1.var_.characterEffect10066ui_story and not isNil(var_66_44) then
					local var_66_48 = Mathf.Lerp(0, 0.5, var_66_47)

					arg_63_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10066ui_story.fillRatio = var_66_48
				end
			end

			if arg_63_1.time_ >= var_66_45 + var_66_46 and arg_63_1.time_ < var_66_45 + var_66_46 + arg_66_0 and not isNil(var_66_44) and arg_63_1.var_.characterEffect10066ui_story then
				local var_66_49 = 0.5

				arg_63_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10066ui_story.fillRatio = var_66_49
			end

			local var_66_50 = 0
			local var_66_51 = 1

			if var_66_50 < arg_63_1.time_ and arg_63_1.time_ <= var_66_50 + arg_66_0 then
				local var_66_52 = "stop"
				local var_66_53 = "effect"

				arg_63_1:AudioAction(var_66_52, var_66_53, "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			local var_66_54 = 0
			local var_66_55 = 0.225

			if var_66_54 < arg_63_1.time_ and arg_63_1.time_ <= var_66_54 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_56 = arg_63_1:FormatText(StoryNameCfg[471].name)

				arg_63_1.leftNameTxt_.text = var_66_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_57 = arg_63_1:GetWordFromCfg(319192015)
				local var_66_58 = arg_63_1:FormatText(var_66_57.content)

				arg_63_1.text_.text = var_66_58

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_59 = 9
				local var_66_60 = utf8.len(var_66_58)
				local var_66_61 = var_66_59 <= 0 and var_66_55 or var_66_55 * (var_66_60 / var_66_59)

				if var_66_61 > 0 and var_66_55 < var_66_61 then
					arg_63_1.talkMaxDuration = var_66_61

					if var_66_61 + var_66_54 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_61 + var_66_54
					end
				end

				arg_63_1.text_.text = var_66_58
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319192", "319192015", "story_v_out_319192.awb") ~= 0 then
					local var_66_62 = manager.audio:GetVoiceLength("story_v_out_319192", "319192015", "story_v_out_319192.awb") / 1000

					if var_66_62 + var_66_54 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_62 + var_66_54
					end

					if var_66_57.prefab_name ~= "" and arg_63_1.actors_[var_66_57.prefab_name] ~= nil then
						local var_66_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_57.prefab_name].transform, "story_v_out_319192", "319192015", "story_v_out_319192.awb")

						arg_63_1:RecordAudio("319192015", var_66_63)
						arg_63_1:RecordAudio("319192015", var_66_63)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_319192", "319192015", "story_v_out_319192.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_319192", "319192015", "story_v_out_319192.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_64 = math.max(var_66_55, arg_63_1.talkMaxDuration)

			if var_66_54 <= arg_63_1.time_ and arg_63_1.time_ < var_66_54 + var_66_64 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_54) / var_66_64

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_54 + var_66_64 and arg_63_1.time_ < var_66_54 + var_66_64 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	assets = {
		"TextureConfig/Background/D02a"
	},
	voices = {
		"story_v_out_319192.awb"
	}
}
