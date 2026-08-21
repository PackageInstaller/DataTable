return {
	Play411111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B04g"

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
				local var_4_5 = arg_1_1.bgs_.B04g

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
					if iter_4_0 ~= "B04g" then
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
			local var_4_23 = 0.366666666666667

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

			local var_4_28 = 0.6
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2")

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

			local var_4_34 = 1.999999999999
			local var_4_35 = 1.075

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

				local var_4_37 = arg_1_1:GetWordFromCfg(411111001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 43
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
	Play411111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411111002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play411111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.4

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(411111002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 56
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play411111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411111003
		arg_13_1.duration_ = 2

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play411111004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1095ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = arg_13_1.actors_["1095ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1095ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -0.98, -6.1)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1095ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1095ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1095ui_story == nil then
				arg_13_1.var_.characterEffect1095ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1095ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1095ui_story then
				arg_13_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action8_2")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_16_20 = 0
			local var_16_21 = 0.175

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[471].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(411111003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 7
				local var_16_26 = utf8.len(var_16_24)
				local var_16_27 = var_16_25 <= 0 and var_16_21 or var_16_21 * (var_16_26 / var_16_25)

				if var_16_27 > 0 and var_16_21 < var_16_27 then
					arg_13_1.talkMaxDuration = var_16_27

					if var_16_27 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_20
					end
				end

				arg_13_1.text_.text = var_16_24
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111003", "story_v_out_411111.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_411111", "411111003", "story_v_out_411111.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_411111", "411111003", "story_v_out_411111.awb")

						arg_13_1:RecordAudio("411111003", var_16_29)
						arg_13_1:RecordAudio("411111003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_411111", "411111003", "story_v_out_411111.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_411111", "411111003", "story_v_out_411111.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_30 = math.max(var_16_21, arg_13_1.talkMaxDuration)

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_30 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_20) / var_16_30

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_20 + var_16_30 and arg_13_1.time_ < var_16_20 + var_16_30 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411111004
		arg_17_1.duration_ = 1.47

		local var_17_0 = {
			zh = 0.999999999999,
			ja = 1.466
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
				arg_17_0:Play411111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.125

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[471].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(411111004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 5
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111004", "story_v_out_411111.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111004", "story_v_out_411111.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_411111", "411111004", "story_v_out_411111.awb")

						arg_17_1:RecordAudio("411111004", var_20_9)
						arg_17_1:RecordAudio("411111004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_411111", "411111004", "story_v_out_411111.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_411111", "411111004", "story_v_out_411111.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play411111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411111005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play411111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1095ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1095ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1095ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, 100, 0)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["1095ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1095ui_story and not isNil(var_24_9) then
					local var_24_13 = Mathf.Lerp(0, 0.5, var_24_12)

					arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1095ui_story.fillRatio = var_24_13
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1095ui_story then
				local var_24_14 = 0.5

				arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1095ui_story.fillRatio = var_24_14
			end

			local var_24_15 = 0
			local var_24_16 = 1.75

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

				local var_24_17 = arg_21_1:GetWordFromCfg(411111005)
				local var_24_18 = arg_21_1:FormatText(var_24_17.content)

				arg_21_1.text_.text = var_24_18

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_19 = 68
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
				actorName = "1095ui_story",
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
	Play411111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411111006
		arg_25_1.duration_ = 3.4

		local var_25_0 = {
			zh = 2.033,
			ja = 3.4
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
				arg_25_0:Play411111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1095ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1095ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, -0.98, -6.1)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1095ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1095ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1095ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1095ui_story then
				arg_25_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_28_13 = 0
			local var_28_14 = 0.275

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_15 = arg_25_1:FormatText(StoryNameCfg[471].name)

				arg_25_1.leftNameTxt_.text = var_28_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_16 = arg_25_1:GetWordFromCfg(411111006)
				local var_28_17 = arg_25_1:FormatText(var_28_16.content)

				arg_25_1.text_.text = var_28_17

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_18 = 11
				local var_28_19 = utf8.len(var_28_17)
				local var_28_20 = var_28_18 <= 0 and var_28_14 or var_28_14 * (var_28_19 / var_28_18)

				if var_28_20 > 0 and var_28_14 < var_28_20 then
					arg_25_1.talkMaxDuration = var_28_20

					if var_28_20 + var_28_13 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_20 + var_28_13
					end
				end

				arg_25_1.text_.text = var_28_17
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111006", "story_v_out_411111.awb") ~= 0 then
					local var_28_21 = manager.audio:GetVoiceLength("story_v_out_411111", "411111006", "story_v_out_411111.awb") / 1000

					if var_28_21 + var_28_13 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_13
					end

					if var_28_16.prefab_name ~= "" and arg_25_1.actors_[var_28_16.prefab_name] ~= nil then
						local var_28_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_16.prefab_name].transform, "story_v_out_411111", "411111006", "story_v_out_411111.awb")

						arg_25_1:RecordAudio("411111006", var_28_22)
						arg_25_1:RecordAudio("411111006", var_28_22)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_411111", "411111006", "story_v_out_411111.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_411111", "411111006", "story_v_out_411111.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_23 = math.max(var_28_14, arg_25_1.talkMaxDuration)

			if var_28_13 <= arg_25_1.time_ and arg_25_1.time_ < var_28_13 + var_28_23 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_13) / var_28_23

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_13 + var_28_23 and arg_25_1.time_ < var_28_13 + var_28_23 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411111007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411111007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play411111008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_32_1 = 0
			local var_32_2 = 0.125

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_3 = arg_29_1:FormatText(StoryNameCfg[471].name)

				arg_29_1.leftNameTxt_.text = var_32_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(411111007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111007", "story_v_out_411111.awb") ~= 0 then
					local var_32_9 = manager.audio:GetVoiceLength("story_v_out_411111", "411111007", "story_v_out_411111.awb") / 1000

					if var_32_9 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_1
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_411111", "411111007", "story_v_out_411111.awb")

						arg_29_1:RecordAudio("411111007", var_32_10)
						arg_29_1:RecordAudio("411111007", var_32_10)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_411111", "411111007", "story_v_out_411111.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_411111", "411111007", "story_v_out_411111.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_11 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_11 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_11

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_11 and arg_29_1.time_ < var_32_1 + var_32_11 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play411111008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411111008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play411111009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1095ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1095ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1095ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1095ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1095ui_story.fillRatio = var_36_5
			end

			local var_36_6 = arg_33_1.actors_["1095ui_story"].transform
			local var_36_7 = 0

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.var_.moveOldPos1095ui_story = var_36_6.localPosition
			end

			local var_36_8 = 0.001

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_8 then
				local var_36_9 = (arg_33_1.time_ - var_36_7) / var_36_8
				local var_36_10 = Vector3.New(0, 100, 0)

				var_36_6.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1095ui_story, var_36_10, var_36_9)

				local var_36_11 = manager.ui.mainCamera.transform.position - var_36_6.position

				var_36_6.forward = Vector3.New(var_36_11.x, var_36_11.y, var_36_11.z)

				local var_36_12 = var_36_6.localEulerAngles

				var_36_12.z = 0
				var_36_12.x = 0
				var_36_6.localEulerAngles = var_36_12
			end

			if arg_33_1.time_ >= var_36_7 + var_36_8 and arg_33_1.time_ < var_36_7 + var_36_8 + arg_36_0 then
				var_36_6.localPosition = Vector3.New(0, 100, 0)

				local var_36_13 = manager.ui.mainCamera.transform.position - var_36_6.position

				var_36_6.forward = Vector3.New(var_36_13.x, var_36_13.y, var_36_13.z)

				local var_36_14 = var_36_6.localEulerAngles

				var_36_14.z = 0
				var_36_14.x = 0
				var_36_6.localEulerAngles = var_36_14
			end

			local var_36_15 = manager.ui.mainCamera.transform
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_15.localPosition
			end

			local var_36_17 = 0.633333333333333

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / 0.066
				local var_36_19, var_36_20 = math.modf(var_36_18)

				var_36_15.localPosition = Vector3.New(var_36_20 * 0.13, var_36_20 * 0.13, var_36_20 * 0.13) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 then
				var_36_15.localPosition = arg_33_1.var_.shakeOldPos
			end

			local var_36_21 = 0
			local var_36_22 = 1

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				local var_36_23 = "play"
				local var_36_24 = "effect"

				arg_33_1:AudioAction(var_36_23, var_36_24, "se_story_131", "se_story_131__explosion", "")
			end

			local var_36_25 = 0
			local var_36_26 = 1.3

			if var_36_25 < arg_33_1.time_ and arg_33_1.time_ <= var_36_25 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_27 = arg_33_1:GetWordFromCfg(411111008)
				local var_36_28 = arg_33_1:FormatText(var_36_27.content)

				arg_33_1.text_.text = var_36_28

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_29 = 52
				local var_36_30 = utf8.len(var_36_28)
				local var_36_31 = var_36_29 <= 0 and var_36_26 or var_36_26 * (var_36_30 / var_36_29)

				if var_36_31 > 0 and var_36_26 < var_36_31 then
					arg_33_1.talkMaxDuration = var_36_31

					if var_36_31 + var_36_25 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_31 + var_36_25
					end
				end

				arg_33_1.text_.text = var_36_28
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_32 = math.max(var_36_26, arg_33_1.talkMaxDuration)

			if var_36_25 <= arg_33_1.time_ and arg_33_1.time_ < var_36_25 + var_36_32 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_25) / var_36_32

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_25 + var_36_32 and arg_33_1.time_ < var_36_25 + var_36_32 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411111009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411111009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play411111010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.375

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(411111009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 55
				local var_40_5 = utf8.len(var_40_3)
				local var_40_6 = var_40_4 <= 0 and var_40_1 or var_40_1 * (var_40_5 / var_40_4)

				if var_40_6 > 0 and var_40_1 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_7 and arg_37_1.time_ < var_40_0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play411111010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411111010
		arg_41_1.duration_ = 6.03

		local var_41_0 = {
			zh = 6.033,
			ja = 2.833
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
				arg_41_0:Play411111011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1095ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1095ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0, -0.98, -6.1)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1095ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1095ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect1095ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1095ui_story then
				arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action8_2")
			end

			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_44_15 = 0
			local var_44_16 = 0.625

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[471].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(411111010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 25
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111010", "story_v_out_411111.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_411111", "411111010", "story_v_out_411111.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_411111", "411111010", "story_v_out_411111.awb")

						arg_41_1:RecordAudio("411111010", var_44_24)
						arg_41_1:RecordAudio("411111010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_411111", "411111010", "story_v_out_411111.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_411111", "411111010", "story_v_out_411111.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play411111011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 411111011
		arg_45_1.duration_ = 4.97

		local var_45_0 = {
			zh = 3.4,
			ja = 4.966
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
				arg_45_0:Play411111012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.375

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[471].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(411111011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 15
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111011", "story_v_out_411111.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111011", "story_v_out_411111.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_411111", "411111011", "story_v_out_411111.awb")

						arg_45_1:RecordAudio("411111011", var_48_9)
						arg_45_1:RecordAudio("411111011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_411111", "411111011", "story_v_out_411111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_411111", "411111011", "story_v_out_411111.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play411111012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 411111012
		arg_49_1.duration_ = 10.23

		local var_49_0 = {
			zh = 6.366,
			ja = 10.233
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
				arg_49_0:Play411111013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.7

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[471].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(411111012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 28
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111012", "story_v_out_411111.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111012", "story_v_out_411111.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_411111", "411111012", "story_v_out_411111.awb")

						arg_49_1:RecordAudio("411111012", var_52_9)
						arg_49_1:RecordAudio("411111012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_411111", "411111012", "story_v_out_411111.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_411111", "411111012", "story_v_out_411111.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play411111013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 411111013
		arg_53_1.duration_ = 4.3

		local var_53_0 = {
			zh = 2.1,
			ja = 4.3
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
				arg_53_0:Play411111014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = manager.ui.mainCamera.transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_0.localPosition
			end

			local var_56_2 = 0.366666666666667

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / 0.066
				local var_56_4, var_56_5 = math.modf(var_56_3)

				var_56_0.localPosition = Vector3.New(var_56_5 * 0.13, var_56_5 * 0.13, var_56_5 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_6 = arg_53_1.actors_["1095ui_story"].transform
			local var_56_7 = 0

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.var_.moveOldPos1095ui_story = var_56_6.localPosition
			end

			local var_56_8 = 0.001

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_8 then
				local var_56_9 = (arg_53_1.time_ - var_56_7) / var_56_8
				local var_56_10 = Vector3.New(0, 100, 0)

				var_56_6.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1095ui_story, var_56_10, var_56_9)

				local var_56_11 = manager.ui.mainCamera.transform.position - var_56_6.position

				var_56_6.forward = Vector3.New(var_56_11.x, var_56_11.y, var_56_11.z)

				local var_56_12 = var_56_6.localEulerAngles

				var_56_12.z = 0
				var_56_12.x = 0
				var_56_6.localEulerAngles = var_56_12
			end

			if arg_53_1.time_ >= var_56_7 + var_56_8 and arg_53_1.time_ < var_56_7 + var_56_8 + arg_56_0 then
				var_56_6.localPosition = Vector3.New(0, 100, 0)

				local var_56_13 = manager.ui.mainCamera.transform.position - var_56_6.position

				var_56_6.forward = Vector3.New(var_56_13.x, var_56_13.y, var_56_13.z)

				local var_56_14 = var_56_6.localEulerAngles

				var_56_14.z = 0
				var_56_14.x = 0
				var_56_6.localEulerAngles = var_56_14
			end

			local var_56_15 = arg_53_1.actors_["1095ui_story"]
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.characterEffect1095ui_story == nil then
				arg_53_1.var_.characterEffect1095ui_story = var_56_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_17 = 0.200000002980232

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 and not isNil(var_56_15) then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17

				if arg_53_1.var_.characterEffect1095ui_story and not isNil(var_56_15) then
					local var_56_19 = Mathf.Lerp(0, 0.5, var_56_18)

					arg_53_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1095ui_story.fillRatio = var_56_19
				end
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.characterEffect1095ui_story then
				local var_56_20 = 0.5

				arg_53_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1095ui_story.fillRatio = var_56_20
			end

			local var_56_21 = 0
			local var_56_22 = 0.175

			if var_56_21 < arg_53_1.time_ and arg_53_1.time_ <= var_56_21 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_23 = arg_53_1:FormatText(StoryNameCfg[29].name)

				arg_53_1.leftNameTxt_.text = var_56_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_24 = arg_53_1:GetWordFromCfg(411111013)
				local var_56_25 = arg_53_1:FormatText(var_56_24.content)

				arg_53_1.text_.text = var_56_25

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_26 = 7
				local var_56_27 = utf8.len(var_56_25)
				local var_56_28 = var_56_26 <= 0 and var_56_22 or var_56_22 * (var_56_27 / var_56_26)

				if var_56_28 > 0 and var_56_22 < var_56_28 then
					arg_53_1.talkMaxDuration = var_56_28

					if var_56_28 + var_56_21 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_28 + var_56_21
					end
				end

				arg_53_1.text_.text = var_56_25
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111013", "story_v_out_411111.awb") ~= 0 then
					local var_56_29 = manager.audio:GetVoiceLength("story_v_out_411111", "411111013", "story_v_out_411111.awb") / 1000

					if var_56_29 + var_56_21 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_29 + var_56_21
					end

					if var_56_24.prefab_name ~= "" and arg_53_1.actors_[var_56_24.prefab_name] ~= nil then
						local var_56_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_24.prefab_name].transform, "story_v_out_411111", "411111013", "story_v_out_411111.awb")

						arg_53_1:RecordAudio("411111013", var_56_30)
						arg_53_1:RecordAudio("411111013", var_56_30)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_411111", "411111013", "story_v_out_411111.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_411111", "411111013", "story_v_out_411111.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_31 = math.max(var_56_22, arg_53_1.talkMaxDuration)

			if var_56_21 <= arg_53_1.time_ and arg_53_1.time_ < var_56_21 + var_56_31 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_21) / var_56_31

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_21 + var_56_31 and arg_53_1.time_ < var_56_21 + var_56_31 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play411111014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 411111014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play411111015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1095ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1095ui_story == nil then
				arg_57_1.var_.characterEffect1095ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1095ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1095ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1095ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1095ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 1.1

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(411111014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 44
				local var_60_11 = utf8.len(var_60_9)
				local var_60_12 = var_60_10 <= 0 and var_60_7 or var_60_7 * (var_60_11 / var_60_10)

				if var_60_12 > 0 and var_60_7 < var_60_12 then
					arg_57_1.talkMaxDuration = var_60_12

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_13 and arg_57_1.time_ < var_60_6 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play411111015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 411111015
		arg_61_1.duration_ = 3.6

		local var_61_0 = {
			zh = 2.566,
			ja = 3.6
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
				arg_61_0:Play411111016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1095ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1095ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, -0.98, -6.1)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1095ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1095ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1095ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1095ui_story then
				arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_64_14 = 0
			local var_64_15 = 0.2

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_16 = arg_61_1:FormatText(StoryNameCfg[471].name)

				arg_61_1.leftNameTxt_.text = var_64_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_17 = arg_61_1:GetWordFromCfg(411111015)
				local var_64_18 = arg_61_1:FormatText(var_64_17.content)

				arg_61_1.text_.text = var_64_18

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_19 = 8
				local var_64_20 = utf8.len(var_64_18)
				local var_64_21 = var_64_19 <= 0 and var_64_15 or var_64_15 * (var_64_20 / var_64_19)

				if var_64_21 > 0 and var_64_15 < var_64_21 then
					arg_61_1.talkMaxDuration = var_64_21

					if var_64_21 + var_64_14 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_21 + var_64_14
					end
				end

				arg_61_1.text_.text = var_64_18
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111015", "story_v_out_411111.awb") ~= 0 then
					local var_64_22 = manager.audio:GetVoiceLength("story_v_out_411111", "411111015", "story_v_out_411111.awb") / 1000

					if var_64_22 + var_64_14 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_14
					end

					if var_64_17.prefab_name ~= "" and arg_61_1.actors_[var_64_17.prefab_name] ~= nil then
						local var_64_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_17.prefab_name].transform, "story_v_out_411111", "411111015", "story_v_out_411111.awb")

						arg_61_1:RecordAudio("411111015", var_64_23)
						arg_61_1:RecordAudio("411111015", var_64_23)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_411111", "411111015", "story_v_out_411111.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_411111", "411111015", "story_v_out_411111.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_24 = math.max(var_64_15, arg_61_1.talkMaxDuration)

			if var_64_14 <= arg_61_1.time_ and arg_61_1.time_ < var_64_14 + var_64_24 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_14) / var_64_24

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_14 + var_64_24 and arg_61_1.time_ < var_64_14 + var_64_24 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play411111016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 411111016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play411111017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1095ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1095ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1095ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1095ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1095ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 1.275

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(411111016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 51
				local var_68_11 = utf8.len(var_68_9)
				local var_68_12 = var_68_10 <= 0 and var_68_7 or var_68_7 * (var_68_11 / var_68_10)

				if var_68_12 > 0 and var_68_7 < var_68_12 then
					arg_65_1.talkMaxDuration = var_68_12

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_13 and arg_65_1.time_ < var_68_6 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play411111017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 411111017
		arg_69_1.duration_ = 4.87

		local var_69_0 = {
			zh = 4.63266666666667,
			ja = 4.86666666666667
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
				arg_69_0:Play411111018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1095ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1095ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, 100, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1095ui_story, var_72_4, var_72_3)

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

			local var_72_9 = arg_69_1.actors_["1095ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1095ui_story == nil then
				arg_69_1.var_.characterEffect1095ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect1095ui_story and not isNil(var_72_9) then
					local var_72_13 = Mathf.Lerp(0, 0.5, var_72_12)

					arg_69_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1095ui_story.fillRatio = var_72_13
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1095ui_story then
				local var_72_14 = 0.5

				arg_69_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1095ui_story.fillRatio = var_72_14
			end

			local var_72_15 = 0

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				local var_72_16 = manager.ui.mainCamera.transform.localPosition
				local var_72_17 = Vector3.New(0, 0, 10) + Vector3.New(var_72_16.x, var_72_16.y, 0)
				local var_72_18 = arg_69_1.bgs_.B04g

				var_72_18.transform.localPosition = var_72_17
				var_72_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_19 = var_72_18:GetComponent("SpriteRenderer")

				if var_72_19 and var_72_19.sprite then
					local var_72_20 = (var_72_18.transform.localPosition - var_72_16).z
					local var_72_21 = manager.ui.mainCameraCom_
					local var_72_22 = 2 * var_72_20 * Mathf.Tan(var_72_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_23 = var_72_22 * var_72_21.aspect
					local var_72_24 = var_72_19.sprite.bounds.size.x
					local var_72_25 = var_72_19.sprite.bounds.size.y
					local var_72_26 = var_72_23 / var_72_24
					local var_72_27 = var_72_22 / var_72_25
					local var_72_28 = var_72_27 < var_72_26 and var_72_26 or var_72_27

					var_72_18.transform.localScale = Vector3.New(var_72_28, var_72_28, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "B04g" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_29 = "B04g_blur"

			if arg_69_1.bgs_[var_72_29] == nil then
				local var_72_30 = Object.Instantiate(arg_69_1.blurPaintGo_)
				local var_72_31 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_29)

				var_72_30:GetComponent("SpriteRenderer").sprite = var_72_31
				var_72_30.name = var_72_29
				var_72_30.transform.parent = arg_69_1.stage_.transform
				var_72_30.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_29] = var_72_30
			end

			local var_72_32 = 0
			local var_72_33 = arg_69_1.bgs_[var_72_29]

			if var_72_32 < arg_69_1.time_ and arg_69_1.time_ <= var_72_32 + arg_72_0 then
				local var_72_34 = manager.ui.mainCamera.transform.localPosition
				local var_72_35 = Vector3.New(0, 0, 10) + Vector3.New(var_72_34.x, var_72_34.y, 0)

				var_72_33.transform.localPosition = var_72_35
				var_72_33.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_36 = var_72_33:GetComponent("SpriteRenderer")

				if var_72_36 and var_72_36.sprite then
					local var_72_37 = (var_72_33.transform.localPosition - var_72_34).z
					local var_72_38 = manager.ui.mainCameraCom_
					local var_72_39 = 2 * var_72_37 * Mathf.Tan(var_72_38.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_40 = var_72_39 * var_72_38.aspect
					local var_72_41 = var_72_36.sprite.bounds.size.x
					local var_72_42 = var_72_36.sprite.bounds.size.y
					local var_72_43 = var_72_40 / var_72_41
					local var_72_44 = var_72_39 / var_72_42
					local var_72_45 = var_72_44 < var_72_43 and var_72_43 or var_72_44

					var_72_33.transform.localScale = Vector3.New(var_72_45, var_72_45, 0)
				end
			end

			local var_72_46 = 3.06666666666667

			if var_72_32 <= arg_69_1.time_ and arg_69_1.time_ < var_72_32 + var_72_46 then
				local var_72_47 = (arg_69_1.time_ - var_72_32) / var_72_46
				local var_72_48 = Color.New(1, 1, 1)

				var_72_48.a = Mathf.Lerp(0, 1, var_72_47)

				var_72_33:GetComponent("SpriteRenderer").material:SetColor("_Color", var_72_48)
			end

			local var_72_49 = 0

			if var_72_49 < arg_69_1.time_ and arg_69_1.time_ <= var_72_49 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			local var_72_50 = 3.06666666666667

			if arg_69_1.time_ >= var_72_49 + var_72_50 and arg_69_1.time_ < var_72_49 + var_72_50 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_51 = 0
			local var_72_52 = 0.366666666666667

			if var_72_51 < arg_69_1.time_ and arg_69_1.time_ <= var_72_51 + arg_72_0 then
				local var_72_53 = "play"
				local var_72_54 = "music"

				arg_69_1:AudioAction(var_72_53, var_72_54, "ui_battle", "ui_battle_stopbgm", "")

				local var_72_55 = ""
				local var_72_56 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_72_56 ~= "" then
					if arg_69_1.bgmTxt_.text ~= var_72_56 and arg_69_1.bgmTxt_.text ~= "" then
						if arg_69_1.bgmTxt2_.text ~= "" then
							arg_69_1.bgmTxt_.text = arg_69_1.bgmTxt2_.text
						end

						arg_69_1.bgmTxt2_.text = var_72_56

						arg_69_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_69_1.bgmTxt_.text = var_72_56
						arg_69_1.bgmTxt2_.text = var_72_56
					end

					if arg_69_1.bgmTimer then
						arg_69_1.bgmTimer:Stop()

						arg_69_1.bgmTimer = nil
					end

					if arg_69_1.settingData.show_music_name == 1 then
						arg_69_1.musicController:SetSelectedState("show")
						arg_69_1.musicAnimator_:Play("open", 0, 0)

						if arg_69_1.settingData.music_time ~= 0 then
							arg_69_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_69_1.settingData.music_time), function()
								if arg_69_1 == nil or isNil(arg_69_1.bgmTxt_) then
									return
								end

								arg_69_1.musicController:SetSelectedState("hide")
								arg_69_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_72_57 = 3.06666666666667
			local var_72_58 = 0.2

			if var_72_57 < arg_69_1.time_ and arg_69_1.time_ <= var_72_57 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_59 = arg_69_1:FormatText(StoryNameCfg[687].name)

				arg_69_1.leftNameTxt_.text = var_72_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_60 = arg_69_1:GetWordFromCfg(411111017)
				local var_72_61 = arg_69_1:FormatText(var_72_60.content)

				arg_69_1.text_.text = var_72_61

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_62 = 8
				local var_72_63 = utf8.len(var_72_61)
				local var_72_64 = var_72_62 <= 0 and var_72_58 or var_72_58 * (var_72_63 / var_72_62)

				if var_72_64 > 0 and var_72_58 < var_72_64 then
					arg_69_1.talkMaxDuration = var_72_64

					if var_72_64 + var_72_57 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_64 + var_72_57
					end
				end

				arg_69_1.text_.text = var_72_61
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111017", "story_v_out_411111.awb") ~= 0 then
					local var_72_65 = manager.audio:GetVoiceLength("story_v_out_411111", "411111017", "story_v_out_411111.awb") / 1000

					if var_72_65 + var_72_57 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_65 + var_72_57
					end

					if var_72_60.prefab_name ~= "" and arg_69_1.actors_[var_72_60.prefab_name] ~= nil then
						local var_72_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_60.prefab_name].transform, "story_v_out_411111", "411111017", "story_v_out_411111.awb")

						arg_69_1:RecordAudio("411111017", var_72_66)
						arg_69_1:RecordAudio("411111017", var_72_66)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_411111", "411111017", "story_v_out_411111.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_411111", "411111017", "story_v_out_411111.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_67 = math.max(var_72_58, arg_69_1.talkMaxDuration)

			if var_72_57 <= arg_69_1.time_ and arg_69_1.time_ < var_72_57 + var_72_67 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_57) / var_72_67

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_57 + var_72_67 and arg_69_1.time_ < var_72_57 + var_72_67 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play411111018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 411111018
		arg_74_1.duration_ = 5.03

		local var_74_0 = {
			zh = 4.999999999999,
			ja = 5.033
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play411111019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = "STwhite"

			if arg_74_1.bgs_[var_77_0] == nil then
				local var_77_1 = Object.Instantiate(arg_74_1.paintGo_)

				var_77_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_77_0)
				var_77_1.name = var_77_0
				var_77_1.transform.parent = arg_74_1.stage_.transform
				var_77_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_74_1.bgs_[var_77_0] = var_77_1
			end

			local var_77_2 = 0

			if var_77_2 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				local var_77_3 = manager.ui.mainCamera.transform.localPosition
				local var_77_4 = Vector3.New(0, 0, 10) + Vector3.New(var_77_3.x, var_77_3.y, 0)
				local var_77_5 = arg_74_1.bgs_.STwhite

				var_77_5.transform.localPosition = var_77_4
				var_77_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_77_6 = var_77_5:GetComponent("SpriteRenderer")

				if var_77_6 and var_77_6.sprite then
					local var_77_7 = (var_77_5.transform.localPosition - var_77_3).z
					local var_77_8 = manager.ui.mainCameraCom_
					local var_77_9 = 2 * var_77_7 * Mathf.Tan(var_77_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_77_10 = var_77_9 * var_77_8.aspect
					local var_77_11 = var_77_6.sprite.bounds.size.x
					local var_77_12 = var_77_6.sprite.bounds.size.y
					local var_77_13 = var_77_10 / var_77_11
					local var_77_14 = var_77_9 / var_77_12
					local var_77_15 = var_77_14 < var_77_13 and var_77_13 or var_77_14

					var_77_5.transform.localScale = Vector3.New(var_77_15, var_77_15, 0)
				end

				for iter_77_0, iter_77_1 in pairs(arg_74_1.bgs_) do
					if iter_77_0 ~= "STwhite" then
						iter_77_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_77_16 = 0

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_17 = 3

			if var_77_16 <= arg_74_1.time_ and arg_74_1.time_ < var_77_16 + var_77_17 then
				local var_77_18 = (arg_74_1.time_ - var_77_16) / var_77_17
				local var_77_19 = Color.New(1, 1, 1)

				var_77_19.a = Mathf.Lerp(1, 0, var_77_18)
				arg_74_1.mask_.color = var_77_19
			end

			if arg_74_1.time_ >= var_77_16 + var_77_17 and arg_74_1.time_ < var_77_16 + var_77_17 + arg_77_0 then
				local var_77_20 = Color.New(1, 1, 1)
				local var_77_21 = 0

				arg_74_1.mask_.enabled = false
				var_77_20.a = var_77_21
				arg_74_1.mask_.color = var_77_20
			end

			local var_77_22 = arg_74_1.actors_["1095ui_story"].transform
			local var_77_23 = 3

			if var_77_23 < arg_74_1.time_ and arg_74_1.time_ <= var_77_23 + arg_77_0 then
				arg_74_1.var_.moveOldPos1095ui_story = var_77_22.localPosition
			end

			local var_77_24 = 0.001

			if var_77_23 <= arg_74_1.time_ and arg_74_1.time_ < var_77_23 + var_77_24 then
				local var_77_25 = (arg_74_1.time_ - var_77_23) / var_77_24
				local var_77_26 = Vector3.New(0, -0.98, -6.1)

				var_77_22.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1095ui_story, var_77_26, var_77_25)

				local var_77_27 = manager.ui.mainCamera.transform.position - var_77_22.position

				var_77_22.forward = Vector3.New(var_77_27.x, var_77_27.y, var_77_27.z)

				local var_77_28 = var_77_22.localEulerAngles

				var_77_28.z = 0
				var_77_28.x = 0
				var_77_22.localEulerAngles = var_77_28
			end

			if arg_74_1.time_ >= var_77_23 + var_77_24 and arg_74_1.time_ < var_77_23 + var_77_24 + arg_77_0 then
				var_77_22.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_77_29 = manager.ui.mainCamera.transform.position - var_77_22.position

				var_77_22.forward = Vector3.New(var_77_29.x, var_77_29.y, var_77_29.z)

				local var_77_30 = var_77_22.localEulerAngles

				var_77_30.z = 0
				var_77_30.x = 0
				var_77_22.localEulerAngles = var_77_30
			end

			local var_77_31 = arg_74_1.actors_["1095ui_story"]
			local var_77_32 = 3

			if var_77_32 < arg_74_1.time_ and arg_74_1.time_ <= var_77_32 + arg_77_0 and not isNil(var_77_31) and arg_74_1.var_.characterEffect1095ui_story == nil then
				arg_74_1.var_.characterEffect1095ui_story = var_77_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_33 = 0.200000002980232

			if var_77_32 <= arg_74_1.time_ and arg_74_1.time_ < var_77_32 + var_77_33 and not isNil(var_77_31) then
				local var_77_34 = (arg_74_1.time_ - var_77_32) / var_77_33

				if arg_74_1.var_.characterEffect1095ui_story and not isNil(var_77_31) then
					arg_74_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_32 + var_77_33 and arg_74_1.time_ < var_77_32 + var_77_33 + arg_77_0 and not isNil(var_77_31) and arg_74_1.var_.characterEffect1095ui_story then
				arg_74_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_77_35 = 3

			if var_77_35 < arg_74_1.time_ and arg_74_1.time_ <= var_77_35 + arg_77_0 then
				arg_74_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_77_36 = 3

			if var_77_36 < arg_74_1.time_ and arg_74_1.time_ <= var_77_36 + arg_77_0 then
				arg_74_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			if arg_74_1.frameCnt_ <= 1 then
				arg_74_1.dialog_:SetActive(false)
			end

			local var_77_37 = 3
			local var_77_38 = 0.1

			if var_77_37 < arg_74_1.time_ and arg_74_1.time_ <= var_77_37 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				arg_74_1.dialog_:SetActive(true)

				arg_74_1.dialogCg_.alpha = 0

				local var_77_39 = LeanTween.value(arg_74_1.dialog_, 0, 1, 0.3)

				var_77_39:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_74_1.dialogCg_.alpha = arg_78_0
				end))
				var_77_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_74_1.dialog_)
					var_77_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_74_1.duration_ = arg_74_1.duration_ + 0.3

				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_40 = arg_74_1:FormatText(StoryNameCfg[471].name)

				arg_74_1.leftNameTxt_.text = var_77_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_41 = arg_74_1:GetWordFromCfg(411111018)
				local var_77_42 = arg_74_1:FormatText(var_77_41.content)

				arg_74_1.text_.text = var_77_42

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_43 = 4
				local var_77_44 = utf8.len(var_77_42)
				local var_77_45 = var_77_43 <= 0 and var_77_38 or var_77_38 * (var_77_44 / var_77_43)

				if var_77_45 > 0 and var_77_38 < var_77_45 then
					arg_74_1.talkMaxDuration = var_77_45
					var_77_37 = var_77_37 + 0.3

					if var_77_45 + var_77_37 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_45 + var_77_37
					end
				end

				arg_74_1.text_.text = var_77_42
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111018", "story_v_out_411111.awb") ~= 0 then
					local var_77_46 = manager.audio:GetVoiceLength("story_v_out_411111", "411111018", "story_v_out_411111.awb") / 1000

					if var_77_46 + var_77_37 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_46 + var_77_37
					end

					if var_77_41.prefab_name ~= "" and arg_74_1.actors_[var_77_41.prefab_name] ~= nil then
						local var_77_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_41.prefab_name].transform, "story_v_out_411111", "411111018", "story_v_out_411111.awb")

						arg_74_1:RecordAudio("411111018", var_77_47)
						arg_74_1:RecordAudio("411111018", var_77_47)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_411111", "411111018", "story_v_out_411111.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_411111", "411111018", "story_v_out_411111.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_48 = var_77_37 + 0.3
			local var_77_49 = math.max(var_77_38, arg_74_1.talkMaxDuration)

			if var_77_48 <= arg_74_1.time_ and arg_74_1.time_ < var_77_48 + var_77_49 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_48) / var_77_49

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_48 + var_77_49 and arg_74_1.time_ < var_77_48 + var_77_49 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play411111019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 411111019
		arg_80_1.duration_ = 3.5

		local var_80_0 = {
			zh = 3.5,
			ja = 3.033
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
				arg_80_0:Play411111020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.175

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[471].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(411111019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 7
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111019", "story_v_out_411111.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111019", "story_v_out_411111.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_411111", "411111019", "story_v_out_411111.awb")

						arg_80_1:RecordAudio("411111019", var_83_9)
						arg_80_1:RecordAudio("411111019", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_411111", "411111019", "story_v_out_411111.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_411111", "411111019", "story_v_out_411111.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play411111020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 411111020
		arg_84_1.duration_ = 3.73

		local var_84_0 = {
			zh = 1.966,
			ja = 3.733
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
				arg_84_0:Play411111021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.15

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[471].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:GetWordFromCfg(411111020)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 6
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111020", "story_v_out_411111.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111020", "story_v_out_411111.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_411111", "411111020", "story_v_out_411111.awb")

						arg_84_1:RecordAudio("411111020", var_87_9)
						arg_84_1:RecordAudio("411111020", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_411111", "411111020", "story_v_out_411111.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_411111", "411111020", "story_v_out_411111.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play411111021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 411111021
		arg_88_1.duration_ = 4.5

		local var_88_0 = {
			zh = 3.3,
			ja = 4.5
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
				arg_88_0:Play411111022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1095ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1095ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, -0.98, -6.1)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1095ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = arg_88_1.actors_["1095ui_story"]
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1095ui_story == nil then
				arg_88_1.var_.characterEffect1095ui_story = var_91_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_11 = 0.200000002980232

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 and not isNil(var_91_9) then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11

				if arg_88_1.var_.characterEffect1095ui_story and not isNil(var_91_9) then
					arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1095ui_story then
				arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_91_13 = 0

			if var_91_13 < arg_88_1.time_ and arg_88_1.time_ <= var_91_13 + arg_91_0 then
				arg_88_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_91_14 = 0
			local var_91_15 = 0.175

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_16 = arg_88_1:FormatText(StoryNameCfg[471].name)

				arg_88_1.leftNameTxt_.text = var_91_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_17 = arg_88_1:GetWordFromCfg(411111021)
				local var_91_18 = arg_88_1:FormatText(var_91_17.content)

				arg_88_1.text_.text = var_91_18

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_19 = 7
				local var_91_20 = utf8.len(var_91_18)
				local var_91_21 = var_91_19 <= 0 and var_91_15 or var_91_15 * (var_91_20 / var_91_19)

				if var_91_21 > 0 and var_91_15 < var_91_21 then
					arg_88_1.talkMaxDuration = var_91_21

					if var_91_21 + var_91_14 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_21 + var_91_14
					end
				end

				arg_88_1.text_.text = var_91_18
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111021", "story_v_out_411111.awb") ~= 0 then
					local var_91_22 = manager.audio:GetVoiceLength("story_v_out_411111", "411111021", "story_v_out_411111.awb") / 1000

					if var_91_22 + var_91_14 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_22 + var_91_14
					end

					if var_91_17.prefab_name ~= "" and arg_88_1.actors_[var_91_17.prefab_name] ~= nil then
						local var_91_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_17.prefab_name].transform, "story_v_out_411111", "411111021", "story_v_out_411111.awb")

						arg_88_1:RecordAudio("411111021", var_91_23)
						arg_88_1:RecordAudio("411111021", var_91_23)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_411111", "411111021", "story_v_out_411111.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_411111", "411111021", "story_v_out_411111.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_24 = math.max(var_91_15, arg_88_1.talkMaxDuration)

			if var_91_14 <= arg_88_1.time_ and arg_88_1.time_ < var_91_14 + var_91_24 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_14) / var_91_24

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_14 + var_91_24 and arg_88_1.time_ < var_91_14 + var_91_24 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play411111022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 411111022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play411111023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1095ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1095ui_story == nil then
				arg_92_1.var_.characterEffect1095ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1095ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1095ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1095ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1095ui_story.fillRatio = var_95_5
			end

			local var_95_6 = 0
			local var_95_7 = 1.3

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_8 = arg_92_1:GetWordFromCfg(411111022)
				local var_95_9 = arg_92_1:FormatText(var_95_8.content)

				arg_92_1.text_.text = var_95_9

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 52
				local var_95_11 = utf8.len(var_95_9)
				local var_95_12 = var_95_10 <= 0 and var_95_7 or var_95_7 * (var_95_11 / var_95_10)

				if var_95_12 > 0 and var_95_7 < var_95_12 then
					arg_92_1.talkMaxDuration = var_95_12

					if var_95_12 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_9
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_13 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_13 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_13

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_13 and arg_92_1.time_ < var_95_6 + var_95_13 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play411111023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 411111023
		arg_96_1.duration_ = 3.9

		local var_96_0 = {
			zh = 3.133,
			ja = 3.9
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
				arg_96_0:Play411111024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1095ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1095ui_story == nil then
				arg_96_1.var_.characterEffect1095ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1095ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1095ui_story then
				arg_96_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_99_4 = 0

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_99_5 = 0
			local var_99_6 = 0.25

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_7 = arg_96_1:FormatText(StoryNameCfg[471].name)

				arg_96_1.leftNameTxt_.text = var_99_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_8 = arg_96_1:GetWordFromCfg(411111023)
				local var_99_9 = arg_96_1:FormatText(var_99_8.content)

				arg_96_1.text_.text = var_99_9

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_10 = 10
				local var_99_11 = utf8.len(var_99_9)
				local var_99_12 = var_99_10 <= 0 and var_99_6 or var_99_6 * (var_99_11 / var_99_10)

				if var_99_12 > 0 and var_99_6 < var_99_12 then
					arg_96_1.talkMaxDuration = var_99_12

					if var_99_12 + var_99_5 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_5
					end
				end

				arg_96_1.text_.text = var_99_9
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111023", "story_v_out_411111.awb") ~= 0 then
					local var_99_13 = manager.audio:GetVoiceLength("story_v_out_411111", "411111023", "story_v_out_411111.awb") / 1000

					if var_99_13 + var_99_5 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_5
					end

					if var_99_8.prefab_name ~= "" and arg_96_1.actors_[var_99_8.prefab_name] ~= nil then
						local var_99_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_8.prefab_name].transform, "story_v_out_411111", "411111023", "story_v_out_411111.awb")

						arg_96_1:RecordAudio("411111023", var_99_14)
						arg_96_1:RecordAudio("411111023", var_99_14)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_411111", "411111023", "story_v_out_411111.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_411111", "411111023", "story_v_out_411111.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_15 = math.max(var_99_6, arg_96_1.talkMaxDuration)

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_15 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_5) / var_99_15

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_5 + var_99_15 and arg_96_1.time_ < var_99_5 + var_99_15 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play411111024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 411111024
		arg_100_1.duration_ = 9

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play411111025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = "I11o"

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
				local var_103_5 = arg_100_1.bgs_.I11o

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
					if iter_103_0 ~= "I11o" then
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

			local var_103_27 = arg_100_1.actors_["1095ui_story"].transform
			local var_103_28 = 2

			if var_103_28 < arg_100_1.time_ and arg_100_1.time_ <= var_103_28 + arg_103_0 then
				arg_100_1.var_.moveOldPos1095ui_story = var_103_27.localPosition
			end

			local var_103_29 = 0.001

			if var_103_28 <= arg_100_1.time_ and arg_100_1.time_ < var_103_28 + var_103_29 then
				local var_103_30 = (arg_100_1.time_ - var_103_28) / var_103_29
				local var_103_31 = Vector3.New(0, 100, 0)

				var_103_27.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1095ui_story, var_103_31, var_103_30)

				local var_103_32 = manager.ui.mainCamera.transform.position - var_103_27.position

				var_103_27.forward = Vector3.New(var_103_32.x, var_103_32.y, var_103_32.z)

				local var_103_33 = var_103_27.localEulerAngles

				var_103_33.z = 0
				var_103_33.x = 0
				var_103_27.localEulerAngles = var_103_33
			end

			if arg_100_1.time_ >= var_103_28 + var_103_29 and arg_100_1.time_ < var_103_28 + var_103_29 + arg_103_0 then
				var_103_27.localPosition = Vector3.New(0, 100, 0)

				local var_103_34 = manager.ui.mainCamera.transform.position - var_103_27.position

				var_103_27.forward = Vector3.New(var_103_34.x, var_103_34.y, var_103_34.z)

				local var_103_35 = var_103_27.localEulerAngles

				var_103_35.z = 0
				var_103_35.x = 0
				var_103_27.localEulerAngles = var_103_35
			end

			local var_103_36 = arg_100_1.actors_["1095ui_story"]
			local var_103_37 = 0

			if var_103_37 < arg_100_1.time_ and arg_100_1.time_ <= var_103_37 + arg_103_0 and not isNil(var_103_36) and arg_100_1.var_.characterEffect1095ui_story == nil then
				arg_100_1.var_.characterEffect1095ui_story = var_103_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_38 = 0.200000002980232

			if var_103_37 <= arg_100_1.time_ and arg_100_1.time_ < var_103_37 + var_103_38 and not isNil(var_103_36) then
				local var_103_39 = (arg_100_1.time_ - var_103_37) / var_103_38

				if arg_100_1.var_.characterEffect1095ui_story and not isNil(var_103_36) then
					local var_103_40 = Mathf.Lerp(0, 0.5, var_103_39)

					arg_100_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1095ui_story.fillRatio = var_103_40
				end
			end

			if arg_100_1.time_ >= var_103_37 + var_103_38 and arg_100_1.time_ < var_103_37 + var_103_38 + arg_103_0 and not isNil(var_103_36) and arg_100_1.var_.characterEffect1095ui_story then
				local var_103_41 = 0.5

				arg_100_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1095ui_story.fillRatio = var_103_41
			end

			local var_103_42 = 0

			if var_103_42 < arg_100_1.time_ and arg_100_1.time_ <= var_103_42 + arg_103_0 then
				local var_103_43 = manager.ui.mainCamera.transform.localPosition
				local var_103_44 = Vector3.New(0, 0, 10) + Vector3.New(var_103_43.x, var_103_43.y, 0)
				local var_103_45 = arg_100_1.bgs_.STwhite

				var_103_45.transform.localPosition = var_103_44
				var_103_45.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_103_46 = var_103_45:GetComponent("SpriteRenderer")

				if var_103_46 and var_103_46.sprite then
					local var_103_47 = (var_103_45.transform.localPosition - var_103_43).z
					local var_103_48 = manager.ui.mainCameraCom_
					local var_103_49 = 2 * var_103_47 * Mathf.Tan(var_103_48.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_103_50 = var_103_49 * var_103_48.aspect
					local var_103_51 = var_103_46.sprite.bounds.size.x
					local var_103_52 = var_103_46.sprite.bounds.size.y
					local var_103_53 = var_103_50 / var_103_51
					local var_103_54 = var_103_49 / var_103_52
					local var_103_55 = var_103_54 < var_103_53 and var_103_53 or var_103_54

					var_103_45.transform.localScale = Vector3.New(var_103_55, var_103_55, 0)
				end

				for iter_103_2, iter_103_3 in pairs(arg_100_1.bgs_) do
					if iter_103_2 ~= "STwhite" then
						iter_103_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_100_1.frameCnt_ <= 1 then
				arg_100_1.dialog_:SetActive(false)
			end

			local var_103_56 = 4
			local var_103_57 = 1.075

			if var_103_56 < arg_100_1.time_ and arg_100_1.time_ <= var_103_56 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0

				arg_100_1.dialog_:SetActive(true)

				arg_100_1.dialogCg_.alpha = 0

				local var_103_58 = LeanTween.value(arg_100_1.dialog_, 0, 1, 0.3)

				var_103_58:setOnUpdate(LuaHelper.FloatAction(function(arg_104_0)
					arg_100_1.dialogCg_.alpha = arg_104_0
				end))
				var_103_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_100_1.dialog_)
					var_103_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_100_1.duration_ = arg_100_1.duration_ + 0.3

				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_59 = arg_100_1:GetWordFromCfg(411111024)
				local var_103_60 = arg_100_1:FormatText(var_103_59.content)

				arg_100_1.text_.text = var_103_60

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_61 = 43
				local var_103_62 = utf8.len(var_103_60)
				local var_103_63 = var_103_61 <= 0 and var_103_57 or var_103_57 * (var_103_62 / var_103_61)

				if var_103_63 > 0 and var_103_57 < var_103_63 then
					arg_100_1.talkMaxDuration = var_103_63
					var_103_56 = var_103_56 + 0.3

					if var_103_63 + var_103_56 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_63 + var_103_56
					end
				end

				arg_100_1.text_.text = var_103_60
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_64 = var_103_56 + 0.3
			local var_103_65 = math.max(var_103_57, arg_100_1.talkMaxDuration)

			if var_103_64 <= arg_100_1.time_ and arg_100_1.time_ < var_103_64 + var_103_65 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_64) / var_103_65

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_64 + var_103_65 and arg_100_1.time_ < var_103_64 + var_103_65 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play411111025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 411111025
		arg_106_1.duration_ = 5.37

		local var_106_0 = {
			zh = 5.366,
			ja = 3.266
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play411111026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1095ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos1095ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(0, -0.98, -6.1)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1095ui_story, var_109_4, var_109_3)

				local var_109_5 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_5.x, var_109_5.y, var_109_5.z)

				local var_109_6 = var_109_0.localEulerAngles

				var_109_6.z = 0
				var_109_6.x = 0
				var_109_0.localEulerAngles = var_109_6
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_109_7 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_7.x, var_109_7.y, var_109_7.z)

				local var_109_8 = var_109_0.localEulerAngles

				var_109_8.z = 0
				var_109_8.x = 0
				var_109_0.localEulerAngles = var_109_8
			end

			local var_109_9 = arg_106_1.actors_["1095ui_story"]
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1095ui_story == nil then
				arg_106_1.var_.characterEffect1095ui_story = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_11 = 0.200000002980232

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 and not isNil(var_109_9) then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11

				if arg_106_1.var_.characterEffect1095ui_story and not isNil(var_109_9) then
					arg_106_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1095ui_story then
				arg_106_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_109_13 = 0

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 then
				arg_106_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_109_14 = 0

			if var_109_14 < arg_106_1.time_ and arg_106_1.time_ <= var_109_14 + arg_109_0 then
				arg_106_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_109_15 = 0
			local var_109_16 = 0.425

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_17 = arg_106_1:FormatText(StoryNameCfg[471].name)

				arg_106_1.leftNameTxt_.text = var_109_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_18 = arg_106_1:GetWordFromCfg(411111025)
				local var_109_19 = arg_106_1:FormatText(var_109_18.content)

				arg_106_1.text_.text = var_109_19

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_20 = 17
				local var_109_21 = utf8.len(var_109_19)
				local var_109_22 = var_109_20 <= 0 and var_109_16 or var_109_16 * (var_109_21 / var_109_20)

				if var_109_22 > 0 and var_109_16 < var_109_22 then
					arg_106_1.talkMaxDuration = var_109_22

					if var_109_22 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_22 + var_109_15
					end
				end

				arg_106_1.text_.text = var_109_19
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111025", "story_v_out_411111.awb") ~= 0 then
					local var_109_23 = manager.audio:GetVoiceLength("story_v_out_411111", "411111025", "story_v_out_411111.awb") / 1000

					if var_109_23 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_23 + var_109_15
					end

					if var_109_18.prefab_name ~= "" and arg_106_1.actors_[var_109_18.prefab_name] ~= nil then
						local var_109_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_18.prefab_name].transform, "story_v_out_411111", "411111025", "story_v_out_411111.awb")

						arg_106_1:RecordAudio("411111025", var_109_24)
						arg_106_1:RecordAudio("411111025", var_109_24)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_411111", "411111025", "story_v_out_411111.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_411111", "411111025", "story_v_out_411111.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_25 = math.max(var_109_16, arg_106_1.talkMaxDuration)

			if var_109_15 <= arg_106_1.time_ and arg_106_1.time_ < var_109_15 + var_109_25 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_15) / var_109_25

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_15 + var_109_25 and arg_106_1.time_ < var_109_15 + var_109_25 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play411111026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 411111026
		arg_110_1.duration_ = 2.03

		local var_110_0 = {
			zh = 1.566,
			ja = 2.033
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
				arg_110_0:Play411111027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.2

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[471].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(411111026)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 8
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111026", "story_v_out_411111.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111026", "story_v_out_411111.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_411111", "411111026", "story_v_out_411111.awb")

						arg_110_1:RecordAudio("411111026", var_113_9)
						arg_110_1:RecordAudio("411111026", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_411111", "411111026", "story_v_out_411111.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_411111", "411111026", "story_v_out_411111.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play411111027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 411111027
		arg_114_1.duration_ = 5.67

		local var_114_0 = {
			zh = 5.666,
			ja = 3.9
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play411111028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.6

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[471].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:GetWordFromCfg(411111027)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 24
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111027", "story_v_out_411111.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111027", "story_v_out_411111.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_411111", "411111027", "story_v_out_411111.awb")

						arg_114_1:RecordAudio("411111027", var_117_9)
						arg_114_1:RecordAudio("411111027", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_411111", "411111027", "story_v_out_411111.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_411111", "411111027", "story_v_out_411111.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_10 and arg_114_1.time_ < var_117_0 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play411111028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 411111028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play411111029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				local var_121_1 = manager.ui.mainCamera.transform.localPosition
				local var_121_2 = Vector3.New(0, 0, 10) + Vector3.New(var_121_1.x, var_121_1.y, 0)
				local var_121_3 = arg_118_1.bgs_.I11o

				var_121_3.transform.localPosition = var_121_2
				var_121_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_121_4 = var_121_3:GetComponent("SpriteRenderer")

				if var_121_4 and var_121_4.sprite then
					local var_121_5 = (var_121_3.transform.localPosition - var_121_1).z
					local var_121_6 = manager.ui.mainCameraCom_
					local var_121_7 = 2 * var_121_5 * Mathf.Tan(var_121_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_121_8 = var_121_7 * var_121_6.aspect
					local var_121_9 = var_121_4.sprite.bounds.size.x
					local var_121_10 = var_121_4.sprite.bounds.size.y
					local var_121_11 = var_121_8 / var_121_9
					local var_121_12 = var_121_7 / var_121_10
					local var_121_13 = var_121_12 < var_121_11 and var_121_11 or var_121_12

					var_121_3.transform.localScale = Vector3.New(var_121_13, var_121_13, 0)
				end

				for iter_121_0, iter_121_1 in pairs(arg_118_1.bgs_) do
					if iter_121_0 ~= "I11o" then
						iter_121_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_14 = 1.5

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				local var_121_15 = manager.ui.mainCamera.transform.localPosition
				local var_121_16 = Vector3.New(0, 0, 10) + Vector3.New(var_121_15.x, var_121_15.y, 0)
				local var_121_17 = arg_118_1.bgs_.I11o

				var_121_17.transform.localPosition = var_121_16
				var_121_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_121_18 = var_121_17:GetComponent("SpriteRenderer")

				if var_121_18 and var_121_18.sprite then
					local var_121_19 = (var_121_17.transform.localPosition - var_121_15).z
					local var_121_20 = manager.ui.mainCameraCom_
					local var_121_21 = 2 * var_121_19 * Mathf.Tan(var_121_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_121_22 = var_121_21 * var_121_20.aspect
					local var_121_23 = var_121_18.sprite.bounds.size.x
					local var_121_24 = var_121_18.sprite.bounds.size.y
					local var_121_25 = var_121_22 / var_121_23
					local var_121_26 = var_121_21 / var_121_24
					local var_121_27 = var_121_26 < var_121_25 and var_121_25 or var_121_26

					var_121_17.transform.localScale = Vector3.New(var_121_27, var_121_27, 0)
				end

				for iter_121_2, iter_121_3 in pairs(arg_118_1.bgs_) do
					if iter_121_2 ~= "I11o" then
						iter_121_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_28 = 0

			if var_121_28 < arg_118_1.time_ and arg_118_1.time_ <= var_121_28 + arg_121_0 then
				arg_118_1.allBtn_.enabled = false
			end

			local var_121_29 = 0.3

			if arg_118_1.time_ >= var_121_28 + var_121_29 and arg_118_1.time_ < var_121_28 + var_121_29 + arg_121_0 then
				arg_118_1.allBtn_.enabled = true
			end

			local var_121_30 = 0

			if var_121_30 < arg_118_1.time_ and arg_118_1.time_ <= var_121_30 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_31 = 1.5

			if var_121_30 <= arg_118_1.time_ and arg_118_1.time_ < var_121_30 + var_121_31 then
				local var_121_32 = (arg_118_1.time_ - var_121_30) / var_121_31
				local var_121_33 = Color.New(0, 0, 0)

				var_121_33.a = Mathf.Lerp(0, 1, var_121_32)
				arg_118_1.mask_.color = var_121_33
			end

			if arg_118_1.time_ >= var_121_30 + var_121_31 and arg_118_1.time_ < var_121_30 + var_121_31 + arg_121_0 then
				local var_121_34 = Color.New(0, 0, 0)

				var_121_34.a = 1
				arg_118_1.mask_.color = var_121_34
			end

			local var_121_35 = 1.5

			if var_121_35 < arg_118_1.time_ and arg_118_1.time_ <= var_121_35 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_36 = 1.5

			if var_121_35 <= arg_118_1.time_ and arg_118_1.time_ < var_121_35 + var_121_36 then
				local var_121_37 = (arg_118_1.time_ - var_121_35) / var_121_36
				local var_121_38 = Color.New(0, 0, 0)

				var_121_38.a = Mathf.Lerp(1, 0, var_121_37)
				arg_118_1.mask_.color = var_121_38
			end

			if arg_118_1.time_ >= var_121_35 + var_121_36 and arg_118_1.time_ < var_121_35 + var_121_36 + arg_121_0 then
				local var_121_39 = Color.New(0, 0, 0)
				local var_121_40 = 0

				arg_118_1.mask_.enabled = false
				var_121_39.a = var_121_40
				arg_118_1.mask_.color = var_121_39
			end

			local var_121_41 = 3

			if var_121_41 < arg_118_1.time_ and arg_118_1.time_ <= var_121_41 + arg_121_0 then
				arg_118_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_121_42 = 3

			if var_121_42 < arg_118_1.time_ and arg_118_1.time_ <= var_121_42 + arg_121_0 then
				arg_118_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_121_43 = arg_118_1.actors_["1095ui_story"].transform
			local var_121_44 = 1.5

			if var_121_44 < arg_118_1.time_ and arg_118_1.time_ <= var_121_44 + arg_121_0 then
				arg_118_1.var_.moveOldPos1095ui_story = var_121_43.localPosition
			end

			local var_121_45 = 0.001

			if var_121_44 <= arg_118_1.time_ and arg_118_1.time_ < var_121_44 + var_121_45 then
				local var_121_46 = (arg_118_1.time_ - var_121_44) / var_121_45
				local var_121_47 = Vector3.New(0, 100, 0)

				var_121_43.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1095ui_story, var_121_47, var_121_46)

				local var_121_48 = manager.ui.mainCamera.transform.position - var_121_43.position

				var_121_43.forward = Vector3.New(var_121_48.x, var_121_48.y, var_121_48.z)

				local var_121_49 = var_121_43.localEulerAngles

				var_121_49.z = 0
				var_121_49.x = 0
				var_121_43.localEulerAngles = var_121_49
			end

			if arg_118_1.time_ >= var_121_44 + var_121_45 and arg_118_1.time_ < var_121_44 + var_121_45 + arg_121_0 then
				var_121_43.localPosition = Vector3.New(0, 100, 0)

				local var_121_50 = manager.ui.mainCamera.transform.position - var_121_43.position

				var_121_43.forward = Vector3.New(var_121_50.x, var_121_50.y, var_121_50.z)

				local var_121_51 = var_121_43.localEulerAngles

				var_121_51.z = 0
				var_121_51.x = 0
				var_121_43.localEulerAngles = var_121_51
			end

			local var_121_52 = arg_118_1.actors_["1095ui_story"]
			local var_121_53 = 0

			if var_121_53 < arg_118_1.time_ and arg_118_1.time_ <= var_121_53 + arg_121_0 and not isNil(var_121_52) and arg_118_1.var_.characterEffect1095ui_story == nil then
				arg_118_1.var_.characterEffect1095ui_story = var_121_52:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_54 = 0.200000002980232

			if var_121_53 <= arg_118_1.time_ and arg_118_1.time_ < var_121_53 + var_121_54 and not isNil(var_121_52) then
				local var_121_55 = (arg_118_1.time_ - var_121_53) / var_121_54

				if arg_118_1.var_.characterEffect1095ui_story and not isNil(var_121_52) then
					arg_118_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_53 + var_121_54 and arg_118_1.time_ < var_121_53 + var_121_54 + arg_121_0 and not isNil(var_121_52) and arg_118_1.var_.characterEffect1095ui_story then
				arg_118_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_121_56 = arg_118_1.actors_["1095ui_story"].transform
			local var_121_57 = 3

			if var_121_57 < arg_118_1.time_ and arg_118_1.time_ <= var_121_57 + arg_121_0 then
				arg_118_1.var_.moveOldPos1095ui_story = var_121_56.localPosition
			end

			local var_121_58 = 0.001

			if var_121_57 <= arg_118_1.time_ and arg_118_1.time_ < var_121_57 + var_121_58 then
				local var_121_59 = (arg_118_1.time_ - var_121_57) / var_121_58
				local var_121_60 = Vector3.New(0, -0.98, -6.1)

				var_121_56.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1095ui_story, var_121_60, var_121_59)

				local var_121_61 = manager.ui.mainCamera.transform.position - var_121_56.position

				var_121_56.forward = Vector3.New(var_121_61.x, var_121_61.y, var_121_61.z)

				local var_121_62 = var_121_56.localEulerAngles

				var_121_62.z = 0
				var_121_62.x = 0
				var_121_56.localEulerAngles = var_121_62
			end

			if arg_118_1.time_ >= var_121_57 + var_121_58 and arg_118_1.time_ < var_121_57 + var_121_58 + arg_121_0 then
				var_121_56.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_121_63 = manager.ui.mainCamera.transform.position - var_121_56.position

				var_121_56.forward = Vector3.New(var_121_63.x, var_121_63.y, var_121_63.z)

				local var_121_64 = var_121_56.localEulerAngles

				var_121_64.z = 0
				var_121_64.x = 0
				var_121_56.localEulerAngles = var_121_64
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_65 = 3
			local var_121_66 = 0.15

			if var_121_65 < arg_118_1.time_ and arg_118_1.time_ <= var_121_65 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_67 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_67:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_68 = arg_118_1:FormatText(StoryNameCfg[471].name)

				arg_118_1.leftNameTxt_.text = var_121_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_69 = arg_118_1:GetWordFromCfg(411111028)
				local var_121_70 = arg_118_1:FormatText(var_121_69.content)

				arg_118_1.text_.text = var_121_70

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_71 = 6
				local var_121_72 = utf8.len(var_121_70)
				local var_121_73 = var_121_71 <= 0 and var_121_66 or var_121_66 * (var_121_72 / var_121_71)

				if var_121_73 > 0 and var_121_66 < var_121_73 then
					arg_118_1.talkMaxDuration = var_121_73
					var_121_65 = var_121_65 + 0.3

					if var_121_73 + var_121_65 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_73 + var_121_65
					end
				end

				arg_118_1.text_.text = var_121_70
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111028", "story_v_out_411111.awb") ~= 0 then
					local var_121_74 = manager.audio:GetVoiceLength("story_v_out_411111", "411111028", "story_v_out_411111.awb") / 1000

					if var_121_74 + var_121_65 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_74 + var_121_65
					end

					if var_121_69.prefab_name ~= "" and arg_118_1.actors_[var_121_69.prefab_name] ~= nil then
						local var_121_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_69.prefab_name].transform, "story_v_out_411111", "411111028", "story_v_out_411111.awb")

						arg_118_1:RecordAudio("411111028", var_121_75)
						arg_118_1:RecordAudio("411111028", var_121_75)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_411111", "411111028", "story_v_out_411111.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_411111", "411111028", "story_v_out_411111.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_76 = var_121_65 + 0.3
			local var_121_77 = math.max(var_121_66, arg_118_1.talkMaxDuration)

			if var_121_76 <= arg_118_1.time_ and arg_118_1.time_ < var_121_76 + var_121_77 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_76) / var_121_77

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_76 + var_121_77 and arg_118_1.time_ < var_121_76 + var_121_77 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play411111029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 411111029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play411111030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1095ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1095ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1095ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, 100, 0)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = arg_124_1.actors_["1095ui_story"]
			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 and not isNil(var_127_9) and arg_124_1.var_.characterEffect1095ui_story == nil then
				arg_124_1.var_.characterEffect1095ui_story = var_127_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_11 = 0.200000002980232

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_11 and not isNil(var_127_9) then
				local var_127_12 = (arg_124_1.time_ - var_127_10) / var_127_11

				if arg_124_1.var_.characterEffect1095ui_story and not isNil(var_127_9) then
					arg_124_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_10 + var_127_11 and arg_124_1.time_ < var_127_10 + var_127_11 + arg_127_0 and not isNil(var_127_9) and arg_124_1.var_.characterEffect1095ui_story then
				arg_124_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_127_13 = 0
			local var_127_14 = 1.375

			if var_127_13 < arg_124_1.time_ and arg_124_1.time_ <= var_127_13 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_15 = arg_124_1:GetWordFromCfg(411111029)
				local var_127_16 = arg_124_1:FormatText(var_127_15.content)

				arg_124_1.text_.text = var_127_16

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_17 = 55
				local var_127_18 = utf8.len(var_127_16)
				local var_127_19 = var_127_17 <= 0 and var_127_14 or var_127_14 * (var_127_18 / var_127_17)

				if var_127_19 > 0 and var_127_14 < var_127_19 then
					arg_124_1.talkMaxDuration = var_127_19

					if var_127_19 + var_127_13 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_19 + var_127_13
					end
				end

				arg_124_1.text_.text = var_127_16
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_20 = math.max(var_127_14, arg_124_1.talkMaxDuration)

			if var_127_13 <= arg_124_1.time_ and arg_124_1.time_ < var_127_13 + var_127_20 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_13) / var_127_20

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_13 + var_127_20 and arg_124_1.time_ < var_127_13 + var_127_20 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play411111030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 411111030
		arg_128_1.duration_ = 5.93

		local var_128_0 = {
			zh = 5.7,
			ja = 5.933
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
				arg_128_0:Play411111031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				local var_131_1 = manager.ui.mainCamera.transform.localPosition
				local var_131_2 = Vector3.New(0, 0, 10) + Vector3.New(var_131_1.x, var_131_1.y, 0)
				local var_131_3 = arg_128_1.bgs_.I11o

				var_131_3.transform.localPosition = var_131_2
				var_131_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_4 = var_131_3:GetComponent("SpriteRenderer")

				if var_131_4 and var_131_4.sprite then
					local var_131_5 = (var_131_3.transform.localPosition - var_131_1).z
					local var_131_6 = manager.ui.mainCameraCom_
					local var_131_7 = 2 * var_131_5 * Mathf.Tan(var_131_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_131_8 = var_131_7 * var_131_6.aspect
					local var_131_9 = var_131_4.sprite.bounds.size.x
					local var_131_10 = var_131_4.sprite.bounds.size.y
					local var_131_11 = var_131_8 / var_131_9
					local var_131_12 = var_131_7 / var_131_10
					local var_131_13 = var_131_12 < var_131_11 and var_131_11 or var_131_12

					var_131_3.transform.localScale = Vector3.New(var_131_13, var_131_13, 0)
				end

				for iter_131_0, iter_131_1 in pairs(arg_128_1.bgs_) do
					if iter_131_0 ~= "I11o" then
						iter_131_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_131_14 = "ST74"

			if arg_128_1.bgs_[var_131_14] == nil then
				local var_131_15 = Object.Instantiate(arg_128_1.paintGo_)

				var_131_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_131_14)
				var_131_15.name = var_131_14
				var_131_15.transform.parent = arg_128_1.stage_.transform
				var_131_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.bgs_[var_131_14] = var_131_15
			end

			local var_131_16 = 2

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				local var_131_17 = manager.ui.mainCamera.transform.localPosition
				local var_131_18 = Vector3.New(0, 0, 10) + Vector3.New(var_131_17.x, var_131_17.y, 0)
				local var_131_19 = arg_128_1.bgs_.ST74

				var_131_19.transform.localPosition = var_131_18
				var_131_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_20 = var_131_19:GetComponent("SpriteRenderer")

				if var_131_20 and var_131_20.sprite then
					local var_131_21 = (var_131_19.transform.localPosition - var_131_17).z
					local var_131_22 = manager.ui.mainCameraCom_
					local var_131_23 = 2 * var_131_21 * Mathf.Tan(var_131_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_131_24 = var_131_23 * var_131_22.aspect
					local var_131_25 = var_131_20.sprite.bounds.size.x
					local var_131_26 = var_131_20.sprite.bounds.size.y
					local var_131_27 = var_131_24 / var_131_25
					local var_131_28 = var_131_23 / var_131_26
					local var_131_29 = var_131_28 < var_131_27 and var_131_27 or var_131_28

					var_131_19.transform.localScale = Vector3.New(var_131_29, var_131_29, 0)
				end

				for iter_131_2, iter_131_3 in pairs(arg_128_1.bgs_) do
					if iter_131_2 ~= "ST74" then
						iter_131_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_131_30 = 0

			if var_131_30 < arg_128_1.time_ and arg_128_1.time_ <= var_131_30 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_31 = 2

			if var_131_30 <= arg_128_1.time_ and arg_128_1.time_ < var_131_30 + var_131_31 then
				local var_131_32 = (arg_128_1.time_ - var_131_30) / var_131_31
				local var_131_33 = Color.New(0, 0, 0)

				var_131_33.a = Mathf.Lerp(0, 1, var_131_32)
				arg_128_1.mask_.color = var_131_33
			end

			if arg_128_1.time_ >= var_131_30 + var_131_31 and arg_128_1.time_ < var_131_30 + var_131_31 + arg_131_0 then
				local var_131_34 = Color.New(0, 0, 0)

				var_131_34.a = 1
				arg_128_1.mask_.color = var_131_34
			end

			local var_131_35 = 2

			if var_131_35 < arg_128_1.time_ and arg_128_1.time_ <= var_131_35 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_36 = 2

			if var_131_35 <= arg_128_1.time_ and arg_128_1.time_ < var_131_35 + var_131_36 then
				local var_131_37 = (arg_128_1.time_ - var_131_35) / var_131_36
				local var_131_38 = Color.New(0, 0, 0)

				var_131_38.a = Mathf.Lerp(1, 0, var_131_37)
				arg_128_1.mask_.color = var_131_38
			end

			if arg_128_1.time_ >= var_131_35 + var_131_36 and arg_128_1.time_ < var_131_35 + var_131_36 + arg_131_0 then
				local var_131_39 = Color.New(0, 0, 0)
				local var_131_40 = 0

				arg_128_1.mask_.enabled = false
				var_131_39.a = var_131_40
				arg_128_1.mask_.color = var_131_39
			end

			local var_131_41 = 0
			local var_131_42 = 0.366666666666667

			if var_131_41 < arg_128_1.time_ and arg_128_1.time_ <= var_131_41 + arg_131_0 then
				local var_131_43 = "play"
				local var_131_44 = "music"

				arg_128_1:AudioAction(var_131_43, var_131_44, "ui_battle", "ui_battle_stopbgm", "")

				local var_131_45 = ""
				local var_131_46 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_131_46 ~= "" then
					if arg_128_1.bgmTxt_.text ~= var_131_46 and arg_128_1.bgmTxt_.text ~= "" then
						if arg_128_1.bgmTxt2_.text ~= "" then
							arg_128_1.bgmTxt_.text = arg_128_1.bgmTxt2_.text
						end

						arg_128_1.bgmTxt2_.text = var_131_46

						arg_128_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_128_1.bgmTxt_.text = var_131_46
						arg_128_1.bgmTxt2_.text = var_131_46
					end

					if arg_128_1.bgmTimer then
						arg_128_1.bgmTimer:Stop()

						arg_128_1.bgmTimer = nil
					end

					if arg_128_1.settingData.show_music_name == 1 then
						arg_128_1.musicController:SetSelectedState("show")
						arg_128_1.musicAnimator_:Play("open", 0, 0)

						if arg_128_1.settingData.music_time ~= 0 then
							arg_128_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_128_1.settingData.music_time), function()
								if arg_128_1 == nil or isNil(arg_128_1.bgmTxt_) then
									return
								end

								arg_128_1.musicController:SetSelectedState("hide")
								arg_128_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_131_47 = 0.6
			local var_131_48 = 1

			if var_131_47 < arg_128_1.time_ and arg_128_1.time_ <= var_131_47 + arg_131_0 then
				local var_131_49 = "play"
				local var_131_50 = "music"

				arg_128_1:AudioAction(var_131_49, var_131_50, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_131_51 = ""
				local var_131_52 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_131_52 ~= "" then
					if arg_128_1.bgmTxt_.text ~= var_131_52 and arg_128_1.bgmTxt_.text ~= "" then
						if arg_128_1.bgmTxt2_.text ~= "" then
							arg_128_1.bgmTxt_.text = arg_128_1.bgmTxt2_.text
						end

						arg_128_1.bgmTxt2_.text = var_131_52

						arg_128_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_128_1.bgmTxt_.text = var_131_52
						arg_128_1.bgmTxt2_.text = var_131_52
					end

					if arg_128_1.bgmTimer then
						arg_128_1.bgmTimer:Stop()

						arg_128_1.bgmTimer = nil
					end

					if arg_128_1.settingData.show_music_name == 1 then
						arg_128_1.musicController:SetSelectedState("show")
						arg_128_1.musicAnimator_:Play("open", 0, 0)

						if arg_128_1.settingData.music_time ~= 0 then
							arg_128_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_128_1.settingData.music_time), function()
								if arg_128_1 == nil or isNil(arg_128_1.bgmTxt_) then
									return
								end

								arg_128_1.musicController:SetSelectedState("hide")
								arg_128_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_128_1.frameCnt_ <= 1 then
				arg_128_1.dialog_:SetActive(false)
			end

			local var_131_53 = 4
			local var_131_54 = 0.225

			if var_131_53 < arg_128_1.time_ and arg_128_1.time_ <= var_131_53 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0

				arg_128_1.dialog_:SetActive(true)

				arg_128_1.dialogCg_.alpha = 0

				local var_131_55 = LeanTween.value(arg_128_1.dialog_, 0, 1, 0.3)

				var_131_55:setOnUpdate(LuaHelper.FloatAction(function(arg_134_0)
					arg_128_1.dialogCg_.alpha = arg_134_0
				end))
				var_131_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_128_1.dialog_)
					var_131_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_128_1.duration_ = arg_128_1.duration_ + 0.3

				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_56 = arg_128_1:FormatText(StoryNameCfg[526].name)

				arg_128_1.leftNameTxt_.text = var_131_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_57 = arg_128_1:GetWordFromCfg(411111030)
				local var_131_58 = arg_128_1:FormatText(var_131_57.content)

				arg_128_1.text_.text = var_131_58

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_59 = 9
				local var_131_60 = utf8.len(var_131_58)
				local var_131_61 = var_131_59 <= 0 and var_131_54 or var_131_54 * (var_131_60 / var_131_59)

				if var_131_61 > 0 and var_131_54 < var_131_61 then
					arg_128_1.talkMaxDuration = var_131_61
					var_131_53 = var_131_53 + 0.3

					if var_131_61 + var_131_53 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_61 + var_131_53
					end
				end

				arg_128_1.text_.text = var_131_58
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111030", "story_v_out_411111.awb") ~= 0 then
					local var_131_62 = manager.audio:GetVoiceLength("story_v_out_411111", "411111030", "story_v_out_411111.awb") / 1000

					if var_131_62 + var_131_53 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_62 + var_131_53
					end

					if var_131_57.prefab_name ~= "" and arg_128_1.actors_[var_131_57.prefab_name] ~= nil then
						local var_131_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_57.prefab_name].transform, "story_v_out_411111", "411111030", "story_v_out_411111.awb")

						arg_128_1:RecordAudio("411111030", var_131_63)
						arg_128_1:RecordAudio("411111030", var_131_63)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_411111", "411111030", "story_v_out_411111.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_411111", "411111030", "story_v_out_411111.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_64 = var_131_53 + 0.3
			local var_131_65 = math.max(var_131_54, arg_128_1.talkMaxDuration)

			if var_131_64 <= arg_128_1.time_ and arg_128_1.time_ < var_131_64 + var_131_65 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_64) / var_131_65

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_64 + var_131_65 and arg_128_1.time_ < var_131_64 + var_131_65 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play411111031 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 411111031
		arg_136_1.duration_ = 2.93

		local var_136_0 = {
			zh = 2.933,
			ja = 1.999999999999
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
				arg_136_0:Play411111032(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = "10071ui_story"

			if arg_136_1.actors_[var_139_0] == nil then
				local var_139_1 = Asset.Load("Char/" .. "10071ui_story")

				if not isNil(var_139_1) then
					local var_139_2 = Object.Instantiate(Asset.Load("Char/" .. "10071ui_story"), arg_136_1.stage_.transform)

					var_139_2.name = var_139_0
					var_139_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_136_1.actors_[var_139_0] = var_139_2

					local var_139_3 = var_139_2:GetComponentInChildren(typeof(CharacterEffect))

					var_139_3.enabled = true

					local var_139_4 = GameObjectTools.GetOrAddComponent(var_139_2, typeof(DynamicBoneHelper))

					if var_139_4 then
						var_139_4:EnableDynamicBone(false)
					end

					arg_136_1:ShowWeapon(var_139_3.transform, false)

					arg_136_1.var_[var_139_0 .. "Animator"] = var_139_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_136_1.var_[var_139_0 .. "Animator"].applyRootMotion = true
					arg_136_1.var_[var_139_0 .. "LipSync"] = var_139_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_139_5 = arg_136_1.actors_["10071ui_story"].transform
			local var_139_6 = 0

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.var_.moveOldPos10071ui_story = var_139_5.localPosition
			end

			local var_139_7 = 0.001

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_7 then
				local var_139_8 = (arg_136_1.time_ - var_139_6) / var_139_7
				local var_139_9 = Vector3.New(0, -0.9, -6.26)

				var_139_5.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10071ui_story, var_139_9, var_139_8)

				local var_139_10 = manager.ui.mainCamera.transform.position - var_139_5.position

				var_139_5.forward = Vector3.New(var_139_10.x, var_139_10.y, var_139_10.z)

				local var_139_11 = var_139_5.localEulerAngles

				var_139_11.z = 0
				var_139_11.x = 0
				var_139_5.localEulerAngles = var_139_11
			end

			if arg_136_1.time_ >= var_139_6 + var_139_7 and arg_136_1.time_ < var_139_6 + var_139_7 + arg_139_0 then
				var_139_5.localPosition = Vector3.New(0, -0.9, -6.26)

				local var_139_12 = manager.ui.mainCamera.transform.position - var_139_5.position

				var_139_5.forward = Vector3.New(var_139_12.x, var_139_12.y, var_139_12.z)

				local var_139_13 = var_139_5.localEulerAngles

				var_139_13.z = 0
				var_139_13.x = 0
				var_139_5.localEulerAngles = var_139_13
			end

			local var_139_14 = arg_136_1.actors_["10071ui_story"]
			local var_139_15 = 0

			if var_139_15 < arg_136_1.time_ and arg_136_1.time_ <= var_139_15 + arg_139_0 and not isNil(var_139_14) and arg_136_1.var_.characterEffect10071ui_story == nil then
				arg_136_1.var_.characterEffect10071ui_story = var_139_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_16 = 0.200000002980232

			if var_139_15 <= arg_136_1.time_ and arg_136_1.time_ < var_139_15 + var_139_16 and not isNil(var_139_14) then
				local var_139_17 = (arg_136_1.time_ - var_139_15) / var_139_16

				if arg_136_1.var_.characterEffect10071ui_story and not isNil(var_139_14) then
					arg_136_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_15 + var_139_16 and arg_136_1.time_ < var_139_15 + var_139_16 + arg_139_0 and not isNil(var_139_14) and arg_136_1.var_.characterEffect10071ui_story then
				arg_136_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_139_18 = 0

			if var_139_18 < arg_136_1.time_ and arg_136_1.time_ <= var_139_18 + arg_139_0 then
				arg_136_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action1_1")
			end

			local var_139_19 = 0

			if var_139_19 < arg_136_1.time_ and arg_136_1.time_ <= var_139_19 + arg_139_0 then
				arg_136_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_139_20 = 0
			local var_139_21 = 0.325

			if var_139_20 < arg_136_1.time_ and arg_136_1.time_ <= var_139_20 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_22 = arg_136_1:FormatText(StoryNameCfg[526].name)

				arg_136_1.leftNameTxt_.text = var_139_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_23 = arg_136_1:GetWordFromCfg(411111031)
				local var_139_24 = arg_136_1:FormatText(var_139_23.content)

				arg_136_1.text_.text = var_139_24

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_25 = 13
				local var_139_26 = utf8.len(var_139_24)
				local var_139_27 = var_139_25 <= 0 and var_139_21 or var_139_21 * (var_139_26 / var_139_25)

				if var_139_27 > 0 and var_139_21 < var_139_27 then
					arg_136_1.talkMaxDuration = var_139_27

					if var_139_27 + var_139_20 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_27 + var_139_20
					end
				end

				arg_136_1.text_.text = var_139_24
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111031", "story_v_out_411111.awb") ~= 0 then
					local var_139_28 = manager.audio:GetVoiceLength("story_v_out_411111", "411111031", "story_v_out_411111.awb") / 1000

					if var_139_28 + var_139_20 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_28 + var_139_20
					end

					if var_139_23.prefab_name ~= "" and arg_136_1.actors_[var_139_23.prefab_name] ~= nil then
						local var_139_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_23.prefab_name].transform, "story_v_out_411111", "411111031", "story_v_out_411111.awb")

						arg_136_1:RecordAudio("411111031", var_139_29)
						arg_136_1:RecordAudio("411111031", var_139_29)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_411111", "411111031", "story_v_out_411111.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_411111", "411111031", "story_v_out_411111.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_30 = math.max(var_139_21, arg_136_1.talkMaxDuration)

			if var_139_20 <= arg_136_1.time_ and arg_136_1.time_ < var_139_20 + var_139_30 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_20) / var_139_30

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_20 + var_139_30 and arg_136_1.time_ < var_139_20 + var_139_30 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play411111032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 411111032
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play411111033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10071ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos10071ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, 100, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10071ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, 100, 0)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = 0
			local var_143_10 = 1.15

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_11 = arg_140_1:GetWordFromCfg(411111032)
				local var_143_12 = arg_140_1:FormatText(var_143_11.content)

				arg_140_1.text_.text = var_143_12

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 46
				local var_143_14 = utf8.len(var_143_12)
				local var_143_15 = var_143_13 <= 0 and var_143_10 or var_143_10 * (var_143_14 / var_143_13)

				if var_143_15 > 0 and var_143_10 < var_143_15 then
					arg_140_1.talkMaxDuration = var_143_15

					if var_143_15 + var_143_9 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_15 + var_143_9
					end
				end

				arg_140_1.text_.text = var_143_12
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_10, arg_140_1.talkMaxDuration)

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_9) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_9 + var_143_16 and arg_140_1.time_ < var_143_9 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play411111033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 411111033
		arg_144_1.duration_ = 4.3

		local var_144_0 = {
			zh = 2.666,
			ja = 4.3
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
				arg_144_0:Play411111034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1095ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1095ui_story = var_147_0.localPosition
			end

			local var_147_2 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(0, -0.98, -6.1)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1095ui_story, var_147_4, var_147_3)

				local var_147_5 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_5.x, var_147_5.y, var_147_5.z)

				local var_147_6 = var_147_0.localEulerAngles

				var_147_6.z = 0
				var_147_6.x = 0
				var_147_0.localEulerAngles = var_147_6
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_147_7 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_7.x, var_147_7.y, var_147_7.z)

				local var_147_8 = var_147_0.localEulerAngles

				var_147_8.z = 0
				var_147_8.x = 0
				var_147_0.localEulerAngles = var_147_8
			end

			local var_147_9 = arg_144_1.actors_["1095ui_story"]
			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 and not isNil(var_147_9) and arg_144_1.var_.characterEffect1095ui_story == nil then
				arg_144_1.var_.characterEffect1095ui_story = var_147_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_11 = 0.200000002980232

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_11 and not isNil(var_147_9) then
				local var_147_12 = (arg_144_1.time_ - var_147_10) / var_147_11

				if arg_144_1.var_.characterEffect1095ui_story and not isNil(var_147_9) then
					arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_10 + var_147_11 and arg_144_1.time_ < var_147_10 + var_147_11 + arg_147_0 and not isNil(var_147_9) and arg_144_1.var_.characterEffect1095ui_story then
				arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_147_13 = 0

			if var_147_13 < arg_144_1.time_ and arg_144_1.time_ <= var_147_13 + arg_147_0 then
				arg_144_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_147_14 = 0

			if var_147_14 < arg_144_1.time_ and arg_144_1.time_ <= var_147_14 + arg_147_0 then
				arg_144_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_147_15 = 0
			local var_147_16 = 0.275

			if var_147_15 < arg_144_1.time_ and arg_144_1.time_ <= var_147_15 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_17 = arg_144_1:FormatText(StoryNameCfg[471].name)

				arg_144_1.leftNameTxt_.text = var_147_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_18 = arg_144_1:GetWordFromCfg(411111033)
				local var_147_19 = arg_144_1:FormatText(var_147_18.content)

				arg_144_1.text_.text = var_147_19

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_20 = 11
				local var_147_21 = utf8.len(var_147_19)
				local var_147_22 = var_147_20 <= 0 and var_147_16 or var_147_16 * (var_147_21 / var_147_20)

				if var_147_22 > 0 and var_147_16 < var_147_22 then
					arg_144_1.talkMaxDuration = var_147_22

					if var_147_22 + var_147_15 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_22 + var_147_15
					end
				end

				arg_144_1.text_.text = var_147_19
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111033", "story_v_out_411111.awb") ~= 0 then
					local var_147_23 = manager.audio:GetVoiceLength("story_v_out_411111", "411111033", "story_v_out_411111.awb") / 1000

					if var_147_23 + var_147_15 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_23 + var_147_15
					end

					if var_147_18.prefab_name ~= "" and arg_144_1.actors_[var_147_18.prefab_name] ~= nil then
						local var_147_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_18.prefab_name].transform, "story_v_out_411111", "411111033", "story_v_out_411111.awb")

						arg_144_1:RecordAudio("411111033", var_147_24)
						arg_144_1:RecordAudio("411111033", var_147_24)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_411111", "411111033", "story_v_out_411111.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_411111", "411111033", "story_v_out_411111.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_25 = math.max(var_147_16, arg_144_1.talkMaxDuration)

			if var_147_15 <= arg_144_1.time_ and arg_144_1.time_ < var_147_15 + var_147_25 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_15) / var_147_25

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_15 + var_147_25 and arg_144_1.time_ < var_147_15 + var_147_25 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play411111034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 411111034
		arg_148_1.duration_ = 1.8

		local var_148_0 = {
			zh = 1.566,
			ja = 1.8
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play411111035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.2

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[471].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:GetWordFromCfg(411111034)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 8
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111034", "story_v_out_411111.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111034", "story_v_out_411111.awb") / 1000

					if var_151_8 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_0
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_411111", "411111034", "story_v_out_411111.awb")

						arg_148_1:RecordAudio("411111034", var_151_9)
						arg_148_1:RecordAudio("411111034", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_411111", "411111034", "story_v_out_411111.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_411111", "411111034", "story_v_out_411111.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_10 and arg_148_1.time_ < var_151_0 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play411111035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 411111035
		arg_152_1.duration_ = 8.9

		local var_152_0 = {
			zh = 5.2,
			ja = 8.9
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
				arg_152_0:Play411111036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10071ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos10071ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0, -0.9, -6.26)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10071ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -0.9, -6.26)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = arg_152_1.actors_["10071ui_story"]
			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect10071ui_story == nil then
				arg_152_1.var_.characterEffect10071ui_story = var_155_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.200000002980232

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_11 and not isNil(var_155_9) then
				local var_155_12 = (arg_152_1.time_ - var_155_10) / var_155_11

				if arg_152_1.var_.characterEffect10071ui_story and not isNil(var_155_9) then
					arg_152_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_10 + var_155_11 and arg_152_1.time_ < var_155_10 + var_155_11 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect10071ui_story then
				arg_152_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_155_13 = 0

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				arg_152_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action4_1")
			end

			local var_155_14 = 0

			if var_155_14 < arg_152_1.time_ and arg_152_1.time_ <= var_155_14 + arg_155_0 then
				arg_152_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_155_15 = arg_152_1.actors_["1095ui_story"].transform
			local var_155_16 = 0

			if var_155_16 < arg_152_1.time_ and arg_152_1.time_ <= var_155_16 + arg_155_0 then
				arg_152_1.var_.moveOldPos1095ui_story = var_155_15.localPosition
			end

			local var_155_17 = 0.001

			if var_155_16 <= arg_152_1.time_ and arg_152_1.time_ < var_155_16 + var_155_17 then
				local var_155_18 = (arg_152_1.time_ - var_155_16) / var_155_17
				local var_155_19 = Vector3.New(0, 100, 0)

				var_155_15.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1095ui_story, var_155_19, var_155_18)

				local var_155_20 = manager.ui.mainCamera.transform.position - var_155_15.position

				var_155_15.forward = Vector3.New(var_155_20.x, var_155_20.y, var_155_20.z)

				local var_155_21 = var_155_15.localEulerAngles

				var_155_21.z = 0
				var_155_21.x = 0
				var_155_15.localEulerAngles = var_155_21
			end

			if arg_152_1.time_ >= var_155_16 + var_155_17 and arg_152_1.time_ < var_155_16 + var_155_17 + arg_155_0 then
				var_155_15.localPosition = Vector3.New(0, 100, 0)

				local var_155_22 = manager.ui.mainCamera.transform.position - var_155_15.position

				var_155_15.forward = Vector3.New(var_155_22.x, var_155_22.y, var_155_22.z)

				local var_155_23 = var_155_15.localEulerAngles

				var_155_23.z = 0
				var_155_23.x = 0
				var_155_15.localEulerAngles = var_155_23
			end

			local var_155_24 = 0
			local var_155_25 = 0.675

			if var_155_24 < arg_152_1.time_ and arg_152_1.time_ <= var_155_24 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_26 = arg_152_1:FormatText(StoryNameCfg[526].name)

				arg_152_1.leftNameTxt_.text = var_155_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_27 = arg_152_1:GetWordFromCfg(411111035)
				local var_155_28 = arg_152_1:FormatText(var_155_27.content)

				arg_152_1.text_.text = var_155_28

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_29 = 27
				local var_155_30 = utf8.len(var_155_28)
				local var_155_31 = var_155_29 <= 0 and var_155_25 or var_155_25 * (var_155_30 / var_155_29)

				if var_155_31 > 0 and var_155_25 < var_155_31 then
					arg_152_1.talkMaxDuration = var_155_31

					if var_155_31 + var_155_24 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_31 + var_155_24
					end
				end

				arg_152_1.text_.text = var_155_28
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111035", "story_v_out_411111.awb") ~= 0 then
					local var_155_32 = manager.audio:GetVoiceLength("story_v_out_411111", "411111035", "story_v_out_411111.awb") / 1000

					if var_155_32 + var_155_24 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_32 + var_155_24
					end

					if var_155_27.prefab_name ~= "" and arg_152_1.actors_[var_155_27.prefab_name] ~= nil then
						local var_155_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_27.prefab_name].transform, "story_v_out_411111", "411111035", "story_v_out_411111.awb")

						arg_152_1:RecordAudio("411111035", var_155_33)
						arg_152_1:RecordAudio("411111035", var_155_33)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_411111", "411111035", "story_v_out_411111.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_411111", "411111035", "story_v_out_411111.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_34 = math.max(var_155_25, arg_152_1.talkMaxDuration)

			if var_155_24 <= arg_152_1.time_ and arg_152_1.time_ < var_155_24 + var_155_34 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_24) / var_155_34

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_24 + var_155_34 and arg_152_1.time_ < var_155_24 + var_155_34 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play411111036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 411111036
		arg_156_1.duration_ = 3.6

		local var_156_0 = {
			zh = 2.9,
			ja = 3.6
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
				arg_156_0:Play411111037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10071ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos10071ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(0.7, -0.9, -6.26)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10071ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["10071ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect10071ui_story == nil then
				arg_156_1.var_.characterEffect10071ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect10071ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect10071ui_story then
				arg_156_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_159_13 = arg_156_1.actors_["1095ui_story"].transform
			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1.var_.moveOldPos1095ui_story = var_159_13.localPosition
			end

			local var_159_15 = 0.001

			if var_159_14 <= arg_156_1.time_ and arg_156_1.time_ < var_159_14 + var_159_15 then
				local var_159_16 = (arg_156_1.time_ - var_159_14) / var_159_15
				local var_159_17 = Vector3.New(-0.7, -0.98, -6.1)

				var_159_13.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1095ui_story, var_159_17, var_159_16)

				local var_159_18 = manager.ui.mainCamera.transform.position - var_159_13.position

				var_159_13.forward = Vector3.New(var_159_18.x, var_159_18.y, var_159_18.z)

				local var_159_19 = var_159_13.localEulerAngles

				var_159_19.z = 0
				var_159_19.x = 0
				var_159_13.localEulerAngles = var_159_19
			end

			if arg_156_1.time_ >= var_159_14 + var_159_15 and arg_156_1.time_ < var_159_14 + var_159_15 + arg_159_0 then
				var_159_13.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_159_20 = manager.ui.mainCamera.transform.position - var_159_13.position

				var_159_13.forward = Vector3.New(var_159_20.x, var_159_20.y, var_159_20.z)

				local var_159_21 = var_159_13.localEulerAngles

				var_159_21.z = 0
				var_159_21.x = 0
				var_159_13.localEulerAngles = var_159_21
			end

			local var_159_22 = arg_156_1.actors_["1095ui_story"]
			local var_159_23 = 0

			if var_159_23 < arg_156_1.time_ and arg_156_1.time_ <= var_159_23 + arg_159_0 and not isNil(var_159_22) and arg_156_1.var_.characterEffect1095ui_story == nil then
				arg_156_1.var_.characterEffect1095ui_story = var_159_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_24 = 0.200000002980232

			if var_159_23 <= arg_156_1.time_ and arg_156_1.time_ < var_159_23 + var_159_24 and not isNil(var_159_22) then
				local var_159_25 = (arg_156_1.time_ - var_159_23) / var_159_24

				if arg_156_1.var_.characterEffect1095ui_story and not isNil(var_159_22) then
					local var_159_26 = Mathf.Lerp(0, 0.5, var_159_25)

					arg_156_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1095ui_story.fillRatio = var_159_26
				end
			end

			if arg_156_1.time_ >= var_159_23 + var_159_24 and arg_156_1.time_ < var_159_23 + var_159_24 + arg_159_0 and not isNil(var_159_22) and arg_156_1.var_.characterEffect1095ui_story then
				local var_159_27 = 0.5

				arg_156_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1095ui_story.fillRatio = var_159_27
			end

			local var_159_28 = 0
			local var_159_29 = 0.35

			if var_159_28 < arg_156_1.time_ and arg_156_1.time_ <= var_159_28 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_30 = arg_156_1:FormatText(StoryNameCfg[670].name)

				arg_156_1.leftNameTxt_.text = var_159_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_31 = arg_156_1:GetWordFromCfg(411111036)
				local var_159_32 = arg_156_1:FormatText(var_159_31.content)

				arg_156_1.text_.text = var_159_32

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_33 = 14
				local var_159_34 = utf8.len(var_159_32)
				local var_159_35 = var_159_33 <= 0 and var_159_29 or var_159_29 * (var_159_34 / var_159_33)

				if var_159_35 > 0 and var_159_29 < var_159_35 then
					arg_156_1.talkMaxDuration = var_159_35

					if var_159_35 + var_159_28 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_35 + var_159_28
					end
				end

				arg_156_1.text_.text = var_159_32
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111036", "story_v_out_411111.awb") ~= 0 then
					local var_159_36 = manager.audio:GetVoiceLength("story_v_out_411111", "411111036", "story_v_out_411111.awb") / 1000

					if var_159_36 + var_159_28 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_36 + var_159_28
					end

					if var_159_31.prefab_name ~= "" and arg_156_1.actors_[var_159_31.prefab_name] ~= nil then
						local var_159_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_31.prefab_name].transform, "story_v_out_411111", "411111036", "story_v_out_411111.awb")

						arg_156_1:RecordAudio("411111036", var_159_37)
						arg_156_1:RecordAudio("411111036", var_159_37)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_411111", "411111036", "story_v_out_411111.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_411111", "411111036", "story_v_out_411111.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_38 = math.max(var_159_29, arg_156_1.talkMaxDuration)

			if var_159_28 <= arg_156_1.time_ and arg_156_1.time_ < var_159_28 + var_159_38 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_28) / var_159_38

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_28 + var_159_38 and arg_156_1.time_ < var_159_28 + var_159_38 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play411111037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 411111037
		arg_160_1.duration_ = 1.7

		local var_160_0 = {
			zh = 1.566,
			ja = 1.7
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play411111038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10071ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10071ui_story == nil then
				arg_160_1.var_.characterEffect10071ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect10071ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_160_1.var_.characterEffect10071ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10071ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_160_1.var_.characterEffect10071ui_story.fillRatio = var_163_5
			end

			local var_163_6 = arg_160_1.actors_["1095ui_story"]
			local var_163_7 = 0

			if var_163_7 < arg_160_1.time_ and arg_160_1.time_ <= var_163_7 + arg_163_0 and not isNil(var_163_6) and arg_160_1.var_.characterEffect1095ui_story == nil then
				arg_160_1.var_.characterEffect1095ui_story = var_163_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_8 = 0.200000002980232

			if var_163_7 <= arg_160_1.time_ and arg_160_1.time_ < var_163_7 + var_163_8 and not isNil(var_163_6) then
				local var_163_9 = (arg_160_1.time_ - var_163_7) / var_163_8

				if arg_160_1.var_.characterEffect1095ui_story and not isNil(var_163_6) then
					arg_160_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_7 + var_163_8 and arg_160_1.time_ < var_163_7 + var_163_8 + arg_163_0 and not isNil(var_163_6) and arg_160_1.var_.characterEffect1095ui_story then
				arg_160_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_163_10 = 0
			local var_163_11 = 0.15

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_12 = arg_160_1:FormatText(StoryNameCfg[471].name)

				arg_160_1.leftNameTxt_.text = var_163_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_13 = arg_160_1:GetWordFromCfg(411111037)
				local var_163_14 = arg_160_1:FormatText(var_163_13.content)

				arg_160_1.text_.text = var_163_14

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_15 = 6
				local var_163_16 = utf8.len(var_163_14)
				local var_163_17 = var_163_15 <= 0 and var_163_11 or var_163_11 * (var_163_16 / var_163_15)

				if var_163_17 > 0 and var_163_11 < var_163_17 then
					arg_160_1.talkMaxDuration = var_163_17

					if var_163_17 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_17 + var_163_10
					end
				end

				arg_160_1.text_.text = var_163_14
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111037", "story_v_out_411111.awb") ~= 0 then
					local var_163_18 = manager.audio:GetVoiceLength("story_v_out_411111", "411111037", "story_v_out_411111.awb") / 1000

					if var_163_18 + var_163_10 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_18 + var_163_10
					end

					if var_163_13.prefab_name ~= "" and arg_160_1.actors_[var_163_13.prefab_name] ~= nil then
						local var_163_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_13.prefab_name].transform, "story_v_out_411111", "411111037", "story_v_out_411111.awb")

						arg_160_1:RecordAudio("411111037", var_163_19)
						arg_160_1:RecordAudio("411111037", var_163_19)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_411111", "411111037", "story_v_out_411111.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_411111", "411111037", "story_v_out_411111.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_20 = math.max(var_163_11, arg_160_1.talkMaxDuration)

			if var_163_10 <= arg_160_1.time_ and arg_160_1.time_ < var_163_10 + var_163_20 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_10) / var_163_20

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_10 + var_163_20 and arg_160_1.time_ < var_163_10 + var_163_20 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play411111038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 411111038
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play411111039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1095ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1095ui_story == nil then
				arg_164_1.var_.characterEffect1095ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1095ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1095ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1095ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1095ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 0.825

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_8 = arg_164_1:GetWordFromCfg(411111038)
				local var_167_9 = arg_164_1:FormatText(var_167_8.content)

				arg_164_1.text_.text = var_167_9

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_10 = 33
				local var_167_11 = utf8.len(var_167_9)
				local var_167_12 = var_167_10 <= 0 and var_167_7 or var_167_7 * (var_167_11 / var_167_10)

				if var_167_12 > 0 and var_167_7 < var_167_12 then
					arg_164_1.talkMaxDuration = var_167_12

					if var_167_12 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_12 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_9
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_13 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_13 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_13

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_13 and arg_164_1.time_ < var_167_6 + var_167_13 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play411111039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 411111039
		arg_168_1.duration_ = 6.37

		local var_168_0 = {
			zh = 3.5,
			ja = 6.366
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
				arg_168_0:Play411111040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1095ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos1095ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1095ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = arg_168_1.actors_["1095ui_story"]
			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect1095ui_story == nil then
				arg_168_1.var_.characterEffect1095ui_story = var_171_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_11 = 0.200000002980232

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_11 and not isNil(var_171_9) then
				local var_171_12 = (arg_168_1.time_ - var_171_10) / var_171_11

				if arg_168_1.var_.characterEffect1095ui_story and not isNil(var_171_9) then
					arg_168_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_10 + var_171_11 and arg_168_1.time_ < var_171_10 + var_171_11 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect1095ui_story then
				arg_168_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_171_13 = 0

			if var_171_13 < arg_168_1.time_ and arg_168_1.time_ <= var_171_13 + arg_171_0 then
				arg_168_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_171_14 = 0

			if var_171_14 < arg_168_1.time_ and arg_168_1.time_ <= var_171_14 + arg_171_0 then
				arg_168_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_171_15 = 0
			local var_171_16 = 0.35

			if var_171_15 < arg_168_1.time_ and arg_168_1.time_ <= var_171_15 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_17 = arg_168_1:FormatText(StoryNameCfg[471].name)

				arg_168_1.leftNameTxt_.text = var_171_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_18 = arg_168_1:GetWordFromCfg(411111039)
				local var_171_19 = arg_168_1:FormatText(var_171_18.content)

				arg_168_1.text_.text = var_171_19

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_20 = 14
				local var_171_21 = utf8.len(var_171_19)
				local var_171_22 = var_171_20 <= 0 and var_171_16 or var_171_16 * (var_171_21 / var_171_20)

				if var_171_22 > 0 and var_171_16 < var_171_22 then
					arg_168_1.talkMaxDuration = var_171_22

					if var_171_22 + var_171_15 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_22 + var_171_15
					end
				end

				arg_168_1.text_.text = var_171_19
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111039", "story_v_out_411111.awb") ~= 0 then
					local var_171_23 = manager.audio:GetVoiceLength("story_v_out_411111", "411111039", "story_v_out_411111.awb") / 1000

					if var_171_23 + var_171_15 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_23 + var_171_15
					end

					if var_171_18.prefab_name ~= "" and arg_168_1.actors_[var_171_18.prefab_name] ~= nil then
						local var_171_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_18.prefab_name].transform, "story_v_out_411111", "411111039", "story_v_out_411111.awb")

						arg_168_1:RecordAudio("411111039", var_171_24)
						arg_168_1:RecordAudio("411111039", var_171_24)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_411111", "411111039", "story_v_out_411111.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_411111", "411111039", "story_v_out_411111.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_25 = math.max(var_171_16, arg_168_1.talkMaxDuration)

			if var_171_15 <= arg_168_1.time_ and arg_168_1.time_ < var_171_15 + var_171_25 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_15) / var_171_25

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_15 + var_171_25 and arg_168_1.time_ < var_171_15 + var_171_25 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play411111040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 411111040
		arg_172_1.duration_ = 5.93

		local var_172_0 = {
			zh = 5.933,
			ja = 5.2
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play411111041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10071ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos10071ui_story = var_175_0.localPosition
			end

			local var_175_2 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2
				local var_175_4 = Vector3.New(0.7, -0.9, -6.26)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10071ui_story, var_175_4, var_175_3)

				local var_175_5 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_5.x, var_175_5.y, var_175_5.z)

				local var_175_6 = var_175_0.localEulerAngles

				var_175_6.z = 0
				var_175_6.x = 0
				var_175_0.localEulerAngles = var_175_6
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_175_7 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_7.x, var_175_7.y, var_175_7.z)

				local var_175_8 = var_175_0.localEulerAngles

				var_175_8.z = 0
				var_175_8.x = 0
				var_175_0.localEulerAngles = var_175_8
			end

			local var_175_9 = arg_172_1.actors_["10071ui_story"]
			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect10071ui_story == nil then
				arg_172_1.var_.characterEffect10071ui_story = var_175_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_11 = 0.200000002980232

			if var_175_10 <= arg_172_1.time_ and arg_172_1.time_ < var_175_10 + var_175_11 and not isNil(var_175_9) then
				local var_175_12 = (arg_172_1.time_ - var_175_10) / var_175_11

				if arg_172_1.var_.characterEffect10071ui_story and not isNil(var_175_9) then
					arg_172_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_10 + var_175_11 and arg_172_1.time_ < var_175_10 + var_175_11 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect10071ui_story then
				arg_172_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_175_13 = 0

			if var_175_13 < arg_172_1.time_ and arg_172_1.time_ <= var_175_13 + arg_175_0 then
				arg_172_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action4_2")
			end

			local var_175_14 = 0

			if var_175_14 < arg_172_1.time_ and arg_172_1.time_ <= var_175_14 + arg_175_0 then
				arg_172_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_175_15 = arg_172_1.actors_["1095ui_story"]
			local var_175_16 = 0

			if var_175_16 < arg_172_1.time_ and arg_172_1.time_ <= var_175_16 + arg_175_0 and not isNil(var_175_15) and arg_172_1.var_.characterEffect1095ui_story == nil then
				arg_172_1.var_.characterEffect1095ui_story = var_175_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_17 = 0.200000002980232

			if var_175_16 <= arg_172_1.time_ and arg_172_1.time_ < var_175_16 + var_175_17 and not isNil(var_175_15) then
				local var_175_18 = (arg_172_1.time_ - var_175_16) / var_175_17

				if arg_172_1.var_.characterEffect1095ui_story and not isNil(var_175_15) then
					local var_175_19 = Mathf.Lerp(0, 0.5, var_175_18)

					arg_172_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1095ui_story.fillRatio = var_175_19
				end
			end

			if arg_172_1.time_ >= var_175_16 + var_175_17 and arg_172_1.time_ < var_175_16 + var_175_17 + arg_175_0 and not isNil(var_175_15) and arg_172_1.var_.characterEffect1095ui_story then
				local var_175_20 = 0.5

				arg_172_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1095ui_story.fillRatio = var_175_20
			end

			local var_175_21 = 0
			local var_175_22 = 0.4

			if var_175_21 < arg_172_1.time_ and arg_172_1.time_ <= var_175_21 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_23 = arg_172_1:FormatText(StoryNameCfg[670].name)

				arg_172_1.leftNameTxt_.text = var_175_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_24 = arg_172_1:GetWordFromCfg(411111040)
				local var_175_25 = arg_172_1:FormatText(var_175_24.content)

				arg_172_1.text_.text = var_175_25

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_26 = 16
				local var_175_27 = utf8.len(var_175_25)
				local var_175_28 = var_175_26 <= 0 and var_175_22 or var_175_22 * (var_175_27 / var_175_26)

				if var_175_28 > 0 and var_175_22 < var_175_28 then
					arg_172_1.talkMaxDuration = var_175_28

					if var_175_28 + var_175_21 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_28 + var_175_21
					end
				end

				arg_172_1.text_.text = var_175_25
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111040", "story_v_out_411111.awb") ~= 0 then
					local var_175_29 = manager.audio:GetVoiceLength("story_v_out_411111", "411111040", "story_v_out_411111.awb") / 1000

					if var_175_29 + var_175_21 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_29 + var_175_21
					end

					if var_175_24.prefab_name ~= "" and arg_172_1.actors_[var_175_24.prefab_name] ~= nil then
						local var_175_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_24.prefab_name].transform, "story_v_out_411111", "411111040", "story_v_out_411111.awb")

						arg_172_1:RecordAudio("411111040", var_175_30)
						arg_172_1:RecordAudio("411111040", var_175_30)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_411111", "411111040", "story_v_out_411111.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_411111", "411111040", "story_v_out_411111.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_31 = math.max(var_175_22, arg_172_1.talkMaxDuration)

			if var_175_21 <= arg_172_1.time_ and arg_172_1.time_ < var_175_21 + var_175_31 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_21) / var_175_31

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_21 + var_175_31 and arg_172_1.time_ < var_175_21 + var_175_31 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play411111041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 411111041
		arg_176_1.duration_ = 5.13

		local var_176_0 = {
			zh = 1.333,
			ja = 5.133
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
				arg_176_0:Play411111042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10071ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10071ui_story == nil then
				arg_176_1.var_.characterEffect10071ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect10071ui_story and not isNil(var_179_0) then
					local var_179_4 = Mathf.Lerp(0, 0.5, var_179_3)

					arg_176_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_176_1.var_.characterEffect10071ui_story.fillRatio = var_179_4
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10071ui_story then
				local var_179_5 = 0.5

				arg_176_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_176_1.var_.characterEffect10071ui_story.fillRatio = var_179_5
			end

			local var_179_6 = arg_176_1.actors_["1095ui_story"]
			local var_179_7 = 0

			if var_179_7 < arg_176_1.time_ and arg_176_1.time_ <= var_179_7 + arg_179_0 and not isNil(var_179_6) and arg_176_1.var_.characterEffect1095ui_story == nil then
				arg_176_1.var_.characterEffect1095ui_story = var_179_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_8 = 0.200000002980232

			if var_179_7 <= arg_176_1.time_ and arg_176_1.time_ < var_179_7 + var_179_8 and not isNil(var_179_6) then
				local var_179_9 = (arg_176_1.time_ - var_179_7) / var_179_8

				if arg_176_1.var_.characterEffect1095ui_story and not isNil(var_179_6) then
					arg_176_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_7 + var_179_8 and arg_176_1.time_ < var_179_7 + var_179_8 + arg_179_0 and not isNil(var_179_6) and arg_176_1.var_.characterEffect1095ui_story then
				arg_176_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_179_10 = 0
			local var_179_11 = 0.15

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_12 = arg_176_1:FormatText(StoryNameCfg[471].name)

				arg_176_1.leftNameTxt_.text = var_179_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_13 = arg_176_1:GetWordFromCfg(411111041)
				local var_179_14 = arg_176_1:FormatText(var_179_13.content)

				arg_176_1.text_.text = var_179_14

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_15 = 6
				local var_179_16 = utf8.len(var_179_14)
				local var_179_17 = var_179_15 <= 0 and var_179_11 or var_179_11 * (var_179_16 / var_179_15)

				if var_179_17 > 0 and var_179_11 < var_179_17 then
					arg_176_1.talkMaxDuration = var_179_17

					if var_179_17 + var_179_10 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_17 + var_179_10
					end
				end

				arg_176_1.text_.text = var_179_14
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111041", "story_v_out_411111.awb") ~= 0 then
					local var_179_18 = manager.audio:GetVoiceLength("story_v_out_411111", "411111041", "story_v_out_411111.awb") / 1000

					if var_179_18 + var_179_10 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_18 + var_179_10
					end

					if var_179_13.prefab_name ~= "" and arg_176_1.actors_[var_179_13.prefab_name] ~= nil then
						local var_179_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_13.prefab_name].transform, "story_v_out_411111", "411111041", "story_v_out_411111.awb")

						arg_176_1:RecordAudio("411111041", var_179_19)
						arg_176_1:RecordAudio("411111041", var_179_19)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_411111", "411111041", "story_v_out_411111.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_411111", "411111041", "story_v_out_411111.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_20 = math.max(var_179_11, arg_176_1.talkMaxDuration)

			if var_179_10 <= arg_176_1.time_ and arg_176_1.time_ < var_179_10 + var_179_20 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_10) / var_179_20

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_10 + var_179_20 and arg_176_1.time_ < var_179_10 + var_179_20 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play411111042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 411111042
		arg_180_1.duration_ = 10.87

		local var_180_0 = {
			zh = 8.1,
			ja = 10.866
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play411111043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10071ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10071ui_story == nil then
				arg_180_1.var_.characterEffect10071ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect10071ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10071ui_story then
				arg_180_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_183_4 = arg_180_1.actors_["1095ui_story"]
			local var_183_5 = 0

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect1095ui_story == nil then
				arg_180_1.var_.characterEffect1095ui_story = var_183_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_6 = 0.200000002980232

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_6 and not isNil(var_183_4) then
				local var_183_7 = (arg_180_1.time_ - var_183_5) / var_183_6

				if arg_180_1.var_.characterEffect1095ui_story and not isNil(var_183_4) then
					local var_183_8 = Mathf.Lerp(0, 0.5, var_183_7)

					arg_180_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1095ui_story.fillRatio = var_183_8
				end
			end

			if arg_180_1.time_ >= var_183_5 + var_183_6 and arg_180_1.time_ < var_183_5 + var_183_6 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect1095ui_story then
				local var_183_9 = 0.5

				arg_180_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1095ui_story.fillRatio = var_183_9
			end

			local var_183_10 = 0
			local var_183_11 = 1

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_12 = arg_180_1:FormatText(StoryNameCfg[670].name)

				arg_180_1.leftNameTxt_.text = var_183_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_13 = arg_180_1:GetWordFromCfg(411111042)
				local var_183_14 = arg_180_1:FormatText(var_183_13.content)

				arg_180_1.text_.text = var_183_14

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_15 = 40
				local var_183_16 = utf8.len(var_183_14)
				local var_183_17 = var_183_15 <= 0 and var_183_11 or var_183_11 * (var_183_16 / var_183_15)

				if var_183_17 > 0 and var_183_11 < var_183_17 then
					arg_180_1.talkMaxDuration = var_183_17

					if var_183_17 + var_183_10 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_17 + var_183_10
					end
				end

				arg_180_1.text_.text = var_183_14
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111042", "story_v_out_411111.awb") ~= 0 then
					local var_183_18 = manager.audio:GetVoiceLength("story_v_out_411111", "411111042", "story_v_out_411111.awb") / 1000

					if var_183_18 + var_183_10 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_18 + var_183_10
					end

					if var_183_13.prefab_name ~= "" and arg_180_1.actors_[var_183_13.prefab_name] ~= nil then
						local var_183_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_13.prefab_name].transform, "story_v_out_411111", "411111042", "story_v_out_411111.awb")

						arg_180_1:RecordAudio("411111042", var_183_19)
						arg_180_1:RecordAudio("411111042", var_183_19)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_411111", "411111042", "story_v_out_411111.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_411111", "411111042", "story_v_out_411111.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_20 = math.max(var_183_11, arg_180_1.talkMaxDuration)

			if var_183_10 <= arg_180_1.time_ and arg_180_1.time_ < var_183_10 + var_183_20 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_10) / var_183_20

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_10 + var_183_20 and arg_180_1.time_ < var_183_10 + var_183_20 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play411111043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 411111043
		arg_184_1.duration_ = 7.2

		local var_184_0 = {
			zh = 6.266,
			ja = 7.2
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
				arg_184_0:Play411111044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10071ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10071ui_story == nil then
				arg_184_1.var_.characterEffect10071ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect10071ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_184_1.var_.characterEffect10071ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10071ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_184_1.var_.characterEffect10071ui_story.fillRatio = var_187_5
			end

			local var_187_6 = arg_184_1.actors_["1095ui_story"]
			local var_187_7 = 0

			if var_187_7 < arg_184_1.time_ and arg_184_1.time_ <= var_187_7 + arg_187_0 and not isNil(var_187_6) and arg_184_1.var_.characterEffect1095ui_story == nil then
				arg_184_1.var_.characterEffect1095ui_story = var_187_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_8 = 0.200000002980232

			if var_187_7 <= arg_184_1.time_ and arg_184_1.time_ < var_187_7 + var_187_8 and not isNil(var_187_6) then
				local var_187_9 = (arg_184_1.time_ - var_187_7) / var_187_8

				if arg_184_1.var_.characterEffect1095ui_story and not isNil(var_187_6) then
					arg_184_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_7 + var_187_8 and arg_184_1.time_ < var_187_7 + var_187_8 + arg_187_0 and not isNil(var_187_6) and arg_184_1.var_.characterEffect1095ui_story then
				arg_184_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_187_10 = 0
			local var_187_11 = 0.375

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_12 = arg_184_1:FormatText(StoryNameCfg[471].name)

				arg_184_1.leftNameTxt_.text = var_187_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_13 = arg_184_1:GetWordFromCfg(411111043)
				local var_187_14 = arg_184_1:FormatText(var_187_13.content)

				arg_184_1.text_.text = var_187_14

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_15 = 15
				local var_187_16 = utf8.len(var_187_14)
				local var_187_17 = var_187_15 <= 0 and var_187_11 or var_187_11 * (var_187_16 / var_187_15)

				if var_187_17 > 0 and var_187_11 < var_187_17 then
					arg_184_1.talkMaxDuration = var_187_17

					if var_187_17 + var_187_10 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_17 + var_187_10
					end
				end

				arg_184_1.text_.text = var_187_14
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111043", "story_v_out_411111.awb") ~= 0 then
					local var_187_18 = manager.audio:GetVoiceLength("story_v_out_411111", "411111043", "story_v_out_411111.awb") / 1000

					if var_187_18 + var_187_10 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_18 + var_187_10
					end

					if var_187_13.prefab_name ~= "" and arg_184_1.actors_[var_187_13.prefab_name] ~= nil then
						local var_187_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_13.prefab_name].transform, "story_v_out_411111", "411111043", "story_v_out_411111.awb")

						arg_184_1:RecordAudio("411111043", var_187_19)
						arg_184_1:RecordAudio("411111043", var_187_19)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_411111", "411111043", "story_v_out_411111.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_411111", "411111043", "story_v_out_411111.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_20 = math.max(var_187_11, arg_184_1.talkMaxDuration)

			if var_187_10 <= arg_184_1.time_ and arg_184_1.time_ < var_187_10 + var_187_20 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_10) / var_187_20

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_10 + var_187_20 and arg_184_1.time_ < var_187_10 + var_187_20 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play411111044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 411111044
		arg_188_1.duration_ = 8.73

		local var_188_0 = {
			zh = 6.5,
			ja = 8.733
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
				arg_188_0:Play411111045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1095ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos1095ui_story = var_191_0.localPosition
			end

			local var_191_2 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2
				local var_191_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1095ui_story, var_191_4, var_191_3)

				local var_191_5 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_5.x, var_191_5.y, var_191_5.z)

				local var_191_6 = var_191_0.localEulerAngles

				var_191_6.z = 0
				var_191_6.x = 0
				var_191_0.localEulerAngles = var_191_6
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_191_7 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_7.x, var_191_7.y, var_191_7.z)

				local var_191_8 = var_191_0.localEulerAngles

				var_191_8.z = 0
				var_191_8.x = 0
				var_191_0.localEulerAngles = var_191_8
			end

			local var_191_9 = arg_188_1.actors_["1095ui_story"]
			local var_191_10 = 0

			if var_191_10 < arg_188_1.time_ and arg_188_1.time_ <= var_191_10 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect1095ui_story == nil then
				arg_188_1.var_.characterEffect1095ui_story = var_191_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_11 = 0.200000002980232

			if var_191_10 <= arg_188_1.time_ and arg_188_1.time_ < var_191_10 + var_191_11 and not isNil(var_191_9) then
				local var_191_12 = (arg_188_1.time_ - var_191_10) / var_191_11

				if arg_188_1.var_.characterEffect1095ui_story and not isNil(var_191_9) then
					arg_188_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_10 + var_191_11 and arg_188_1.time_ < var_191_10 + var_191_11 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect1095ui_story then
				arg_188_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_191_13 = 0

			if var_191_13 < arg_188_1.time_ and arg_188_1.time_ <= var_191_13 + arg_191_0 then
				arg_188_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_191_14 = 0

			if var_191_14 < arg_188_1.time_ and arg_188_1.time_ <= var_191_14 + arg_191_0 then
				arg_188_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_191_15 = 0
			local var_191_16 = 0.65

			if var_191_15 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_17 = arg_188_1:FormatText(StoryNameCfg[471].name)

				arg_188_1.leftNameTxt_.text = var_191_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_18 = arg_188_1:GetWordFromCfg(411111044)
				local var_191_19 = arg_188_1:FormatText(var_191_18.content)

				arg_188_1.text_.text = var_191_19

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_20 = 26
				local var_191_21 = utf8.len(var_191_19)
				local var_191_22 = var_191_20 <= 0 and var_191_16 or var_191_16 * (var_191_21 / var_191_20)

				if var_191_22 > 0 and var_191_16 < var_191_22 then
					arg_188_1.talkMaxDuration = var_191_22

					if var_191_22 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_22 + var_191_15
					end
				end

				arg_188_1.text_.text = var_191_19
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111044", "story_v_out_411111.awb") ~= 0 then
					local var_191_23 = manager.audio:GetVoiceLength("story_v_out_411111", "411111044", "story_v_out_411111.awb") / 1000

					if var_191_23 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_23 + var_191_15
					end

					if var_191_18.prefab_name ~= "" and arg_188_1.actors_[var_191_18.prefab_name] ~= nil then
						local var_191_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_18.prefab_name].transform, "story_v_out_411111", "411111044", "story_v_out_411111.awb")

						arg_188_1:RecordAudio("411111044", var_191_24)
						arg_188_1:RecordAudio("411111044", var_191_24)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_411111", "411111044", "story_v_out_411111.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_411111", "411111044", "story_v_out_411111.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_25 = math.max(var_191_16, arg_188_1.talkMaxDuration)

			if var_191_15 <= arg_188_1.time_ and arg_188_1.time_ < var_191_15 + var_191_25 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_15) / var_191_25

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_15 + var_191_25 and arg_188_1.time_ < var_191_15 + var_191_25 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play411111045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 411111045
		arg_192_1.duration_ = 9.03

		local var_192_0 = {
			zh = 7.3,
			ja = 9.033
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
				arg_192_0:Play411111046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.75

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[471].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:GetWordFromCfg(411111045)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 30
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111045", "story_v_out_411111.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111045", "story_v_out_411111.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_411111", "411111045", "story_v_out_411111.awb")

						arg_192_1:RecordAudio("411111045", var_195_9)
						arg_192_1:RecordAudio("411111045", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_411111", "411111045", "story_v_out_411111.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_411111", "411111045", "story_v_out_411111.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play411111046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 411111046
		arg_196_1.duration_ = 4.87

		local var_196_0 = {
			zh = 4.7,
			ja = 4.866
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
				arg_196_0:Play411111047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.425

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[471].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_3 = arg_196_1:GetWordFromCfg(411111046)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 17
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111046", "story_v_out_411111.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111046", "story_v_out_411111.awb") / 1000

					if var_199_8 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_0
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_out_411111", "411111046", "story_v_out_411111.awb")

						arg_196_1:RecordAudio("411111046", var_199_9)
						arg_196_1:RecordAudio("411111046", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_411111", "411111046", "story_v_out_411111.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_411111", "411111046", "story_v_out_411111.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_10 and arg_196_1.time_ < var_199_0 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play411111047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 411111047
		arg_200_1.duration_ = 9

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play411111048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 2

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				local var_203_1 = manager.ui.mainCamera.transform.localPosition
				local var_203_2 = Vector3.New(0, 0, 10) + Vector3.New(var_203_1.x, var_203_1.y, 0)
				local var_203_3 = arg_200_1.bgs_.ST74

				var_203_3.transform.localPosition = var_203_2
				var_203_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_203_4 = var_203_3:GetComponent("SpriteRenderer")

				if var_203_4 and var_203_4.sprite then
					local var_203_5 = (var_203_3.transform.localPosition - var_203_1).z
					local var_203_6 = manager.ui.mainCameraCom_
					local var_203_7 = 2 * var_203_5 * Mathf.Tan(var_203_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_203_8 = var_203_7 * var_203_6.aspect
					local var_203_9 = var_203_4.sprite.bounds.size.x
					local var_203_10 = var_203_4.sprite.bounds.size.y
					local var_203_11 = var_203_8 / var_203_9
					local var_203_12 = var_203_7 / var_203_10
					local var_203_13 = var_203_12 < var_203_11 and var_203_11 or var_203_12

					var_203_3.transform.localScale = Vector3.New(var_203_13, var_203_13, 0)
				end

				for iter_203_0, iter_203_1 in pairs(arg_200_1.bgs_) do
					if iter_203_0 ~= "ST74" then
						iter_203_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_203_14 = 0

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_15 = 2

			if var_203_14 <= arg_200_1.time_ and arg_200_1.time_ < var_203_14 + var_203_15 then
				local var_203_16 = (arg_200_1.time_ - var_203_14) / var_203_15
				local var_203_17 = Color.New(0, 0, 0)

				var_203_17.a = Mathf.Lerp(0, 1, var_203_16)
				arg_200_1.mask_.color = var_203_17
			end

			if arg_200_1.time_ >= var_203_14 + var_203_15 and arg_200_1.time_ < var_203_14 + var_203_15 + arg_203_0 then
				local var_203_18 = Color.New(0, 0, 0)

				var_203_18.a = 1
				arg_200_1.mask_.color = var_203_18
			end

			local var_203_19 = 2

			if var_203_19 < arg_200_1.time_ and arg_200_1.time_ <= var_203_19 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_20 = 2

			if var_203_19 <= arg_200_1.time_ and arg_200_1.time_ < var_203_19 + var_203_20 then
				local var_203_21 = (arg_200_1.time_ - var_203_19) / var_203_20
				local var_203_22 = Color.New(0, 0, 0)

				var_203_22.a = Mathf.Lerp(1, 0, var_203_21)
				arg_200_1.mask_.color = var_203_22
			end

			if arg_200_1.time_ >= var_203_19 + var_203_20 and arg_200_1.time_ < var_203_19 + var_203_20 + arg_203_0 then
				local var_203_23 = Color.New(0, 0, 0)
				local var_203_24 = 0

				arg_200_1.mask_.enabled = false
				var_203_23.a = var_203_24
				arg_200_1.mask_.color = var_203_23
			end

			local var_203_25 = arg_200_1.actors_["1095ui_story"].transform
			local var_203_26 = 2

			if var_203_26 < arg_200_1.time_ and arg_200_1.time_ <= var_203_26 + arg_203_0 then
				arg_200_1.var_.moveOldPos1095ui_story = var_203_25.localPosition
			end

			local var_203_27 = 0.001

			if var_203_26 <= arg_200_1.time_ and arg_200_1.time_ < var_203_26 + var_203_27 then
				local var_203_28 = (arg_200_1.time_ - var_203_26) / var_203_27
				local var_203_29 = Vector3.New(0, 100, 0)

				var_203_25.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1095ui_story, var_203_29, var_203_28)

				local var_203_30 = manager.ui.mainCamera.transform.position - var_203_25.position

				var_203_25.forward = Vector3.New(var_203_30.x, var_203_30.y, var_203_30.z)

				local var_203_31 = var_203_25.localEulerAngles

				var_203_31.z = 0
				var_203_31.x = 0
				var_203_25.localEulerAngles = var_203_31
			end

			if arg_200_1.time_ >= var_203_26 + var_203_27 and arg_200_1.time_ < var_203_26 + var_203_27 + arg_203_0 then
				var_203_25.localPosition = Vector3.New(0, 100, 0)

				local var_203_32 = manager.ui.mainCamera.transform.position - var_203_25.position

				var_203_25.forward = Vector3.New(var_203_32.x, var_203_32.y, var_203_32.z)

				local var_203_33 = var_203_25.localEulerAngles

				var_203_33.z = 0
				var_203_33.x = 0
				var_203_25.localEulerAngles = var_203_33
			end

			local var_203_34 = arg_200_1.actors_["10071ui_story"].transform
			local var_203_35 = 2

			if var_203_35 < arg_200_1.time_ and arg_200_1.time_ <= var_203_35 + arg_203_0 then
				arg_200_1.var_.moveOldPos10071ui_story = var_203_34.localPosition
			end

			local var_203_36 = 0.001

			if var_203_35 <= arg_200_1.time_ and arg_200_1.time_ < var_203_35 + var_203_36 then
				local var_203_37 = (arg_200_1.time_ - var_203_35) / var_203_36
				local var_203_38 = Vector3.New(0, 100, 0)

				var_203_34.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10071ui_story, var_203_38, var_203_37)

				local var_203_39 = manager.ui.mainCamera.transform.position - var_203_34.position

				var_203_34.forward = Vector3.New(var_203_39.x, var_203_39.y, var_203_39.z)

				local var_203_40 = var_203_34.localEulerAngles

				var_203_40.z = 0
				var_203_40.x = 0
				var_203_34.localEulerAngles = var_203_40
			end

			if arg_200_1.time_ >= var_203_35 + var_203_36 and arg_200_1.time_ < var_203_35 + var_203_36 + arg_203_0 then
				var_203_34.localPosition = Vector3.New(0, 100, 0)

				local var_203_41 = manager.ui.mainCamera.transform.position - var_203_34.position

				var_203_34.forward = Vector3.New(var_203_41.x, var_203_41.y, var_203_41.z)

				local var_203_42 = var_203_34.localEulerAngles

				var_203_42.z = 0
				var_203_42.x = 0
				var_203_34.localEulerAngles = var_203_42
			end

			if arg_200_1.frameCnt_ <= 1 then
				arg_200_1.dialog_:SetActive(false)
			end

			local var_203_43 = 4
			local var_203_44 = 1.5

			if var_203_43 < arg_200_1.time_ and arg_200_1.time_ <= var_203_43 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				arg_200_1.dialog_:SetActive(true)

				arg_200_1.dialogCg_.alpha = 0

				local var_203_45 = LeanTween.value(arg_200_1.dialog_, 0, 1, 0.3)

				var_203_45:setOnUpdate(LuaHelper.FloatAction(function(arg_204_0)
					arg_200_1.dialogCg_.alpha = arg_204_0
				end))
				var_203_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_200_1.dialog_)
					var_203_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_200_1.duration_ = arg_200_1.duration_ + 0.3

				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_46 = arg_200_1:GetWordFromCfg(411111047)
				local var_203_47 = arg_200_1:FormatText(var_203_46.content)

				arg_200_1.text_.text = var_203_47

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_48 = 60
				local var_203_49 = utf8.len(var_203_47)
				local var_203_50 = var_203_48 <= 0 and var_203_44 or var_203_44 * (var_203_49 / var_203_48)

				if var_203_50 > 0 and var_203_44 < var_203_50 then
					arg_200_1.talkMaxDuration = var_203_50
					var_203_43 = var_203_43 + 0.3

					if var_203_50 + var_203_43 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_50 + var_203_43
					end
				end

				arg_200_1.text_.text = var_203_47
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_51 = var_203_43 + 0.3
			local var_203_52 = math.max(var_203_44, arg_200_1.talkMaxDuration)

			if var_203_51 <= arg_200_1.time_ and arg_200_1.time_ < var_203_51 + var_203_52 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_51) / var_203_52

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_51 + var_203_52 and arg_200_1.time_ < var_203_51 + var_203_52 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play411111048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 411111048
		arg_206_1.duration_ = 6.7

		local var_206_0 = {
			zh = 6.7,
			ja = 5.7
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play411111049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1095ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1095ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, -0.98, -6.1)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1095ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = arg_206_1.actors_["1095ui_story"]
			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1095ui_story == nil then
				arg_206_1.var_.characterEffect1095ui_story = var_209_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_11 = 0.200000002980232

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_11 and not isNil(var_209_9) then
				local var_209_12 = (arg_206_1.time_ - var_209_10) / var_209_11

				if arg_206_1.var_.characterEffect1095ui_story and not isNil(var_209_9) then
					arg_206_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_10 + var_209_11 and arg_206_1.time_ < var_209_10 + var_209_11 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1095ui_story then
				arg_206_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_209_13 = 0

			if var_209_13 < arg_206_1.time_ and arg_206_1.time_ <= var_209_13 + arg_209_0 then
				arg_206_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_209_14 = 0

			if var_209_14 < arg_206_1.time_ and arg_206_1.time_ <= var_209_14 + arg_209_0 then
				arg_206_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_209_15 = 0
			local var_209_16 = 0.75

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[471].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(411111048)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 30
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111048", "story_v_out_411111.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_out_411111", "411111048", "story_v_out_411111.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_out_411111", "411111048", "story_v_out_411111.awb")

						arg_206_1:RecordAudio("411111048", var_209_24)
						arg_206_1:RecordAudio("411111048", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_411111", "411111048", "story_v_out_411111.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_411111", "411111048", "story_v_out_411111.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play411111049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 411111049
		arg_210_1.duration_ = 6.2

		local var_210_0 = {
			zh = 5.4,
			ja = 6.2
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play411111050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 0.55

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_2 = arg_210_1:FormatText(StoryNameCfg[471].name)

				arg_210_1.leftNameTxt_.text = var_213_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_3 = arg_210_1:GetWordFromCfg(411111049)
				local var_213_4 = arg_210_1:FormatText(var_213_3.content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 22
				local var_213_6 = utf8.len(var_213_4)
				local var_213_7 = var_213_5 <= 0 and var_213_1 or var_213_1 * (var_213_6 / var_213_5)

				if var_213_7 > 0 and var_213_1 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111049", "story_v_out_411111.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111049", "story_v_out_411111.awb") / 1000

					if var_213_8 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_0
					end

					if var_213_3.prefab_name ~= "" and arg_210_1.actors_[var_213_3.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_3.prefab_name].transform, "story_v_out_411111", "411111049", "story_v_out_411111.awb")

						arg_210_1:RecordAudio("411111049", var_213_9)
						arg_210_1:RecordAudio("411111049", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_411111", "411111049", "story_v_out_411111.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_411111", "411111049", "story_v_out_411111.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_10 and arg_210_1.time_ < var_213_0 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play411111050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 411111050
		arg_214_1.duration_ = 7.6

		local var_214_0 = {
			zh = 7.133,
			ja = 7.6
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play411111051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_217_1 = 0
			local var_217_2 = 0.725

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_3 = arg_214_1:FormatText(StoryNameCfg[471].name)

				arg_214_1.leftNameTxt_.text = var_217_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_4 = arg_214_1:GetWordFromCfg(411111050)
				local var_217_5 = arg_214_1:FormatText(var_217_4.content)

				arg_214_1.text_.text = var_217_5

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_6 = 29
				local var_217_7 = utf8.len(var_217_5)
				local var_217_8 = var_217_6 <= 0 and var_217_2 or var_217_2 * (var_217_7 / var_217_6)

				if var_217_8 > 0 and var_217_2 < var_217_8 then
					arg_214_1.talkMaxDuration = var_217_8

					if var_217_8 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_5
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111050", "story_v_out_411111.awb") ~= 0 then
					local var_217_9 = manager.audio:GetVoiceLength("story_v_out_411111", "411111050", "story_v_out_411111.awb") / 1000

					if var_217_9 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_1
					end

					if var_217_4.prefab_name ~= "" and arg_214_1.actors_[var_217_4.prefab_name] ~= nil then
						local var_217_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_4.prefab_name].transform, "story_v_out_411111", "411111050", "story_v_out_411111.awb")

						arg_214_1:RecordAudio("411111050", var_217_10)
						arg_214_1:RecordAudio("411111050", var_217_10)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_411111", "411111050", "story_v_out_411111.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_411111", "411111050", "story_v_out_411111.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_11 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_11 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_11

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_11 and arg_214_1.time_ < var_217_1 + var_217_11 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play411111051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 411111051
		arg_218_1.duration_ = 9

		local var_218_0 = {
			zh = 9,
			ja = 6.1
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play411111052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 0.825

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_2 = arg_218_1:FormatText(StoryNameCfg[471].name)

				arg_218_1.leftNameTxt_.text = var_221_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_3 = arg_218_1:GetWordFromCfg(411111051)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 33
				local var_221_6 = utf8.len(var_221_4)
				local var_221_7 = var_221_5 <= 0 and var_221_1 or var_221_1 * (var_221_6 / var_221_5)

				if var_221_7 > 0 and var_221_1 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111051", "story_v_out_411111.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111051", "story_v_out_411111.awb") / 1000

					if var_221_8 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_0
					end

					if var_221_3.prefab_name ~= "" and arg_218_1.actors_[var_221_3.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_3.prefab_name].transform, "story_v_out_411111", "411111051", "story_v_out_411111.awb")

						arg_218_1:RecordAudio("411111051", var_221_9)
						arg_218_1:RecordAudio("411111051", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_411111", "411111051", "story_v_out_411111.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_411111", "411111051", "story_v_out_411111.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_10 and arg_218_1.time_ < var_221_0 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play411111052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 411111052
		arg_222_1.duration_ = 2

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play411111053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10071ui_story"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos10071ui_story = var_225_0.localPosition
			end

			local var_225_2 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2
				local var_225_4 = Vector3.New(0, -0.9, -6.26)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10071ui_story, var_225_4, var_225_3)

				local var_225_5 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_5.x, var_225_5.y, var_225_5.z)

				local var_225_6 = var_225_0.localEulerAngles

				var_225_6.z = 0
				var_225_6.x = 0
				var_225_0.localEulerAngles = var_225_6
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(0, -0.9, -6.26)

				local var_225_7 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_7.x, var_225_7.y, var_225_7.z)

				local var_225_8 = var_225_0.localEulerAngles

				var_225_8.z = 0
				var_225_8.x = 0
				var_225_0.localEulerAngles = var_225_8
			end

			local var_225_9 = arg_222_1.actors_["10071ui_story"]
			local var_225_10 = 0

			if var_225_10 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect10071ui_story == nil then
				arg_222_1.var_.characterEffect10071ui_story = var_225_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_11 = 0.200000002980232

			if var_225_10 <= arg_222_1.time_ and arg_222_1.time_ < var_225_10 + var_225_11 and not isNil(var_225_9) then
				local var_225_12 = (arg_222_1.time_ - var_225_10) / var_225_11

				if arg_222_1.var_.characterEffect10071ui_story and not isNil(var_225_9) then
					arg_222_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_10 + var_225_11 and arg_222_1.time_ < var_225_10 + var_225_11 + arg_225_0 and not isNil(var_225_9) and arg_222_1.var_.characterEffect10071ui_story then
				arg_222_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_225_13 = arg_222_1.actors_["1095ui_story"].transform
			local var_225_14 = 0

			if var_225_14 < arg_222_1.time_ and arg_222_1.time_ <= var_225_14 + arg_225_0 then
				arg_222_1.var_.moveOldPos1095ui_story = var_225_13.localPosition
			end

			local var_225_15 = 0.001

			if var_225_14 <= arg_222_1.time_ and arg_222_1.time_ < var_225_14 + var_225_15 then
				local var_225_16 = (arg_222_1.time_ - var_225_14) / var_225_15
				local var_225_17 = Vector3.New(0, 100, 0)

				var_225_13.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1095ui_story, var_225_17, var_225_16)

				local var_225_18 = manager.ui.mainCamera.transform.position - var_225_13.position

				var_225_13.forward = Vector3.New(var_225_18.x, var_225_18.y, var_225_18.z)

				local var_225_19 = var_225_13.localEulerAngles

				var_225_19.z = 0
				var_225_19.x = 0
				var_225_13.localEulerAngles = var_225_19
			end

			if arg_222_1.time_ >= var_225_14 + var_225_15 and arg_222_1.time_ < var_225_14 + var_225_15 + arg_225_0 then
				var_225_13.localPosition = Vector3.New(0, 100, 0)

				local var_225_20 = manager.ui.mainCamera.transform.position - var_225_13.position

				var_225_13.forward = Vector3.New(var_225_20.x, var_225_20.y, var_225_20.z)

				local var_225_21 = var_225_13.localEulerAngles

				var_225_21.z = 0
				var_225_21.x = 0
				var_225_13.localEulerAngles = var_225_21
			end

			local var_225_22 = 0

			if var_225_22 < arg_222_1.time_ and arg_222_1.time_ <= var_225_22 + arg_225_0 then
				arg_222_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_225_23 = 0

			if var_225_23 < arg_222_1.time_ and arg_222_1.time_ <= var_225_23 + arg_225_0 then
				arg_222_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action1_1")
			end

			local var_225_24 = 0
			local var_225_25 = 0.075

			if var_225_24 < arg_222_1.time_ and arg_222_1.time_ <= var_225_24 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_26 = arg_222_1:FormatText(StoryNameCfg[670].name)

				arg_222_1.leftNameTxt_.text = var_225_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_27 = arg_222_1:GetWordFromCfg(411111052)
				local var_225_28 = arg_222_1:FormatText(var_225_27.content)

				arg_222_1.text_.text = var_225_28

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_29 = 3
				local var_225_30 = utf8.len(var_225_28)
				local var_225_31 = var_225_29 <= 0 and var_225_25 or var_225_25 * (var_225_30 / var_225_29)

				if var_225_31 > 0 and var_225_25 < var_225_31 then
					arg_222_1.talkMaxDuration = var_225_31

					if var_225_31 + var_225_24 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_31 + var_225_24
					end
				end

				arg_222_1.text_.text = var_225_28
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111052", "story_v_out_411111.awb") ~= 0 then
					local var_225_32 = manager.audio:GetVoiceLength("story_v_out_411111", "411111052", "story_v_out_411111.awb") / 1000

					if var_225_32 + var_225_24 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_32 + var_225_24
					end

					if var_225_27.prefab_name ~= "" and arg_222_1.actors_[var_225_27.prefab_name] ~= nil then
						local var_225_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_27.prefab_name].transform, "story_v_out_411111", "411111052", "story_v_out_411111.awb")

						arg_222_1:RecordAudio("411111052", var_225_33)
						arg_222_1:RecordAudio("411111052", var_225_33)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_411111", "411111052", "story_v_out_411111.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_411111", "411111052", "story_v_out_411111.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_34 = math.max(var_225_25, arg_222_1.talkMaxDuration)

			if var_225_24 <= arg_222_1.time_ and arg_222_1.time_ < var_225_24 + var_225_34 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_24) / var_225_34

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_24 + var_225_34 and arg_222_1.time_ < var_225_24 + var_225_34 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play411111053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 411111053
		arg_226_1.duration_ = 3.1

		local var_226_0 = {
			zh = 3.1,
			ja = 1.933
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play411111054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["10071ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect10071ui_story == nil then
				arg_226_1.var_.characterEffect10071ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect10071ui_story and not isNil(var_229_0) then
					local var_229_4 = Mathf.Lerp(0, 0.5, var_229_3)

					arg_226_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_226_1.var_.characterEffect10071ui_story.fillRatio = var_229_4
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect10071ui_story then
				local var_229_5 = 0.5

				arg_226_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_226_1.var_.characterEffect10071ui_story.fillRatio = var_229_5
			end

			local var_229_6 = arg_226_1.actors_["1095ui_story"].transform
			local var_229_7 = 0

			if var_229_7 < arg_226_1.time_ and arg_226_1.time_ <= var_229_7 + arg_229_0 then
				arg_226_1.var_.moveOldPos1095ui_story = var_229_6.localPosition
			end

			local var_229_8 = 0.001

			if var_229_7 <= arg_226_1.time_ and arg_226_1.time_ < var_229_7 + var_229_8 then
				local var_229_9 = (arg_226_1.time_ - var_229_7) / var_229_8
				local var_229_10 = Vector3.New(-0.7, -0.98, -6.1)

				var_229_6.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1095ui_story, var_229_10, var_229_9)

				local var_229_11 = manager.ui.mainCamera.transform.position - var_229_6.position

				var_229_6.forward = Vector3.New(var_229_11.x, var_229_11.y, var_229_11.z)

				local var_229_12 = var_229_6.localEulerAngles

				var_229_12.z = 0
				var_229_12.x = 0
				var_229_6.localEulerAngles = var_229_12
			end

			if arg_226_1.time_ >= var_229_7 + var_229_8 and arg_226_1.time_ < var_229_7 + var_229_8 + arg_229_0 then
				var_229_6.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_229_13 = manager.ui.mainCamera.transform.position - var_229_6.position

				var_229_6.forward = Vector3.New(var_229_13.x, var_229_13.y, var_229_13.z)

				local var_229_14 = var_229_6.localEulerAngles

				var_229_14.z = 0
				var_229_14.x = 0
				var_229_6.localEulerAngles = var_229_14
			end

			local var_229_15 = arg_226_1.actors_["1095ui_story"]
			local var_229_16 = 0

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 and not isNil(var_229_15) and arg_226_1.var_.characterEffect1095ui_story == nil then
				arg_226_1.var_.characterEffect1095ui_story = var_229_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_17 = 0.200000002980232

			if var_229_16 <= arg_226_1.time_ and arg_226_1.time_ < var_229_16 + var_229_17 and not isNil(var_229_15) then
				local var_229_18 = (arg_226_1.time_ - var_229_16) / var_229_17

				if arg_226_1.var_.characterEffect1095ui_story and not isNil(var_229_15) then
					arg_226_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_16 + var_229_17 and arg_226_1.time_ < var_229_16 + var_229_17 + arg_229_0 and not isNil(var_229_15) and arg_226_1.var_.characterEffect1095ui_story then
				arg_226_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_229_19 = arg_226_1.actors_["10071ui_story"].transform
			local var_229_20 = 0

			if var_229_20 < arg_226_1.time_ and arg_226_1.time_ <= var_229_20 + arg_229_0 then
				arg_226_1.var_.moveOldPos10071ui_story = var_229_19.localPosition
			end

			local var_229_21 = 0.001

			if var_229_20 <= arg_226_1.time_ and arg_226_1.time_ < var_229_20 + var_229_21 then
				local var_229_22 = (arg_226_1.time_ - var_229_20) / var_229_21
				local var_229_23 = Vector3.New(0.7, -0.9, -6.26)

				var_229_19.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10071ui_story, var_229_23, var_229_22)

				local var_229_24 = manager.ui.mainCamera.transform.position - var_229_19.position

				var_229_19.forward = Vector3.New(var_229_24.x, var_229_24.y, var_229_24.z)

				local var_229_25 = var_229_19.localEulerAngles

				var_229_25.z = 0
				var_229_25.x = 0
				var_229_19.localEulerAngles = var_229_25
			end

			if arg_226_1.time_ >= var_229_20 + var_229_21 and arg_226_1.time_ < var_229_20 + var_229_21 + arg_229_0 then
				var_229_19.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_229_26 = manager.ui.mainCamera.transform.position - var_229_19.position

				var_229_19.forward = Vector3.New(var_229_26.x, var_229_26.y, var_229_26.z)

				local var_229_27 = var_229_19.localEulerAngles

				var_229_27.z = 0
				var_229_27.x = 0
				var_229_19.localEulerAngles = var_229_27
			end

			local var_229_28 = 0
			local var_229_29 = 0.2

			if var_229_28 < arg_226_1.time_ and arg_226_1.time_ <= var_229_28 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_30 = arg_226_1:FormatText(StoryNameCfg[471].name)

				arg_226_1.leftNameTxt_.text = var_229_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_31 = arg_226_1:GetWordFromCfg(411111053)
				local var_229_32 = arg_226_1:FormatText(var_229_31.content)

				arg_226_1.text_.text = var_229_32

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_33 = 8
				local var_229_34 = utf8.len(var_229_32)
				local var_229_35 = var_229_33 <= 0 and var_229_29 or var_229_29 * (var_229_34 / var_229_33)

				if var_229_35 > 0 and var_229_29 < var_229_35 then
					arg_226_1.talkMaxDuration = var_229_35

					if var_229_35 + var_229_28 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_35 + var_229_28
					end
				end

				arg_226_1.text_.text = var_229_32
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111053", "story_v_out_411111.awb") ~= 0 then
					local var_229_36 = manager.audio:GetVoiceLength("story_v_out_411111", "411111053", "story_v_out_411111.awb") / 1000

					if var_229_36 + var_229_28 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_36 + var_229_28
					end

					if var_229_31.prefab_name ~= "" and arg_226_1.actors_[var_229_31.prefab_name] ~= nil then
						local var_229_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_31.prefab_name].transform, "story_v_out_411111", "411111053", "story_v_out_411111.awb")

						arg_226_1:RecordAudio("411111053", var_229_37)
						arg_226_1:RecordAudio("411111053", var_229_37)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_411111", "411111053", "story_v_out_411111.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_411111", "411111053", "story_v_out_411111.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_38 = math.max(var_229_29, arg_226_1.talkMaxDuration)

			if var_229_28 <= arg_226_1.time_ and arg_226_1.time_ < var_229_28 + var_229_38 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_28) / var_229_38

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_28 + var_229_38 and arg_226_1.time_ < var_229_28 + var_229_38 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play411111054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 411111054
		arg_230_1.duration_ = 2.07

		local var_230_0 = {
			zh = 2.066,
			ja = 1.999999999999
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play411111055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action4_1")
			end

			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_233_2 = arg_230_1.actors_["10071ui_story"]
			local var_233_3 = 0

			if var_233_3 < arg_230_1.time_ and arg_230_1.time_ <= var_233_3 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.characterEffect10071ui_story == nil then
				arg_230_1.var_.characterEffect10071ui_story = var_233_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_4 = 0.200000002980232

			if var_233_3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_3 + var_233_4 and not isNil(var_233_2) then
				local var_233_5 = (arg_230_1.time_ - var_233_3) / var_233_4

				if arg_230_1.var_.characterEffect10071ui_story and not isNil(var_233_2) then
					arg_230_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_3 + var_233_4 and arg_230_1.time_ < var_233_3 + var_233_4 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.characterEffect10071ui_story then
				arg_230_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_233_6 = arg_230_1.actors_["1095ui_story"]
			local var_233_7 = 0

			if var_233_7 < arg_230_1.time_ and arg_230_1.time_ <= var_233_7 + arg_233_0 and not isNil(var_233_6) and arg_230_1.var_.characterEffect1095ui_story == nil then
				arg_230_1.var_.characterEffect1095ui_story = var_233_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_8 = 0.200000002980232

			if var_233_7 <= arg_230_1.time_ and arg_230_1.time_ < var_233_7 + var_233_8 and not isNil(var_233_6) then
				local var_233_9 = (arg_230_1.time_ - var_233_7) / var_233_8

				if arg_230_1.var_.characterEffect1095ui_story and not isNil(var_233_6) then
					local var_233_10 = Mathf.Lerp(0, 0.5, var_233_9)

					arg_230_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1095ui_story.fillRatio = var_233_10
				end
			end

			if arg_230_1.time_ >= var_233_7 + var_233_8 and arg_230_1.time_ < var_233_7 + var_233_8 + arg_233_0 and not isNil(var_233_6) and arg_230_1.var_.characterEffect1095ui_story then
				local var_233_11 = 0.5

				arg_230_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1095ui_story.fillRatio = var_233_11
			end

			local var_233_12 = 0
			local var_233_13 = 0.2

			if var_233_12 < arg_230_1.time_ and arg_230_1.time_ <= var_233_12 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_14 = arg_230_1:FormatText(StoryNameCfg[670].name)

				arg_230_1.leftNameTxt_.text = var_233_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_15 = arg_230_1:GetWordFromCfg(411111054)
				local var_233_16 = arg_230_1:FormatText(var_233_15.content)

				arg_230_1.text_.text = var_233_16

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_17 = 8
				local var_233_18 = utf8.len(var_233_16)
				local var_233_19 = var_233_17 <= 0 and var_233_13 or var_233_13 * (var_233_18 / var_233_17)

				if var_233_19 > 0 and var_233_13 < var_233_19 then
					arg_230_1.talkMaxDuration = var_233_19

					if var_233_19 + var_233_12 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_19 + var_233_12
					end
				end

				arg_230_1.text_.text = var_233_16
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111054", "story_v_out_411111.awb") ~= 0 then
					local var_233_20 = manager.audio:GetVoiceLength("story_v_out_411111", "411111054", "story_v_out_411111.awb") / 1000

					if var_233_20 + var_233_12 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_20 + var_233_12
					end

					if var_233_15.prefab_name ~= "" and arg_230_1.actors_[var_233_15.prefab_name] ~= nil then
						local var_233_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_15.prefab_name].transform, "story_v_out_411111", "411111054", "story_v_out_411111.awb")

						arg_230_1:RecordAudio("411111054", var_233_21)
						arg_230_1:RecordAudio("411111054", var_233_21)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_411111", "411111054", "story_v_out_411111.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_411111", "411111054", "story_v_out_411111.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_22 = math.max(var_233_13, arg_230_1.talkMaxDuration)

			if var_233_12 <= arg_230_1.time_ and arg_230_1.time_ < var_233_12 + var_233_22 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_12) / var_233_22

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_12 + var_233_22 and arg_230_1.time_ < var_233_12 + var_233_22 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play411111055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 411111055
		arg_234_1.duration_ = 8.67

		local var_234_0 = {
			zh = 8.066,
			ja = 8.666
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play411111056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0
			local var_237_1 = 0.8

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_2 = arg_234_1:FormatText(StoryNameCfg[670].name)

				arg_234_1.leftNameTxt_.text = var_237_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_3 = arg_234_1:GetWordFromCfg(411111055)
				local var_237_4 = arg_234_1:FormatText(var_237_3.content)

				arg_234_1.text_.text = var_237_4

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 32
				local var_237_6 = utf8.len(var_237_4)
				local var_237_7 = var_237_5 <= 0 and var_237_1 or var_237_1 * (var_237_6 / var_237_5)

				if var_237_7 > 0 and var_237_1 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_4
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111055", "story_v_out_411111.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111055", "story_v_out_411111.awb") / 1000

					if var_237_8 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_0
					end

					if var_237_3.prefab_name ~= "" and arg_234_1.actors_[var_237_3.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_3.prefab_name].transform, "story_v_out_411111", "411111055", "story_v_out_411111.awb")

						arg_234_1:RecordAudio("411111055", var_237_9)
						arg_234_1:RecordAudio("411111055", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_411111", "411111055", "story_v_out_411111.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_411111", "411111055", "story_v_out_411111.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_10 and arg_234_1.time_ < var_237_0 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play411111056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 411111056
		arg_238_1.duration_ = 2.73

		local var_238_0 = {
			zh = 2.733,
			ja = 2.466
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play411111057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1095ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos1095ui_story = var_241_0.localPosition
			end

			local var_241_2 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2
				local var_241_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1095ui_story, var_241_4, var_241_3)

				local var_241_5 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_5.x, var_241_5.y, var_241_5.z)

				local var_241_6 = var_241_0.localEulerAngles

				var_241_6.z = 0
				var_241_6.x = 0
				var_241_0.localEulerAngles = var_241_6
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_241_7 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_7.x, var_241_7.y, var_241_7.z)

				local var_241_8 = var_241_0.localEulerAngles

				var_241_8.z = 0
				var_241_8.x = 0
				var_241_0.localEulerAngles = var_241_8
			end

			local var_241_9 = arg_238_1.actors_["1095ui_story"]
			local var_241_10 = 0

			if var_241_10 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1095ui_story == nil then
				arg_238_1.var_.characterEffect1095ui_story = var_241_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_11 = 0.200000002980232

			if var_241_10 <= arg_238_1.time_ and arg_238_1.time_ < var_241_10 + var_241_11 and not isNil(var_241_9) then
				local var_241_12 = (arg_238_1.time_ - var_241_10) / var_241_11

				if arg_238_1.var_.characterEffect1095ui_story and not isNil(var_241_9) then
					arg_238_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_10 + var_241_11 and arg_238_1.time_ < var_241_10 + var_241_11 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1095ui_story then
				arg_238_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_241_13 = 0

			if var_241_13 < arg_238_1.time_ and arg_238_1.time_ <= var_241_13 + arg_241_0 then
				arg_238_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_241_14 = 0

			if var_241_14 < arg_238_1.time_ and arg_238_1.time_ <= var_241_14 + arg_241_0 then
				arg_238_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_241_15 = 0
			local var_241_16 = 0.15

			if var_241_15 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_17 = arg_238_1:FormatText(StoryNameCfg[471].name)

				arg_238_1.leftNameTxt_.text = var_241_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_18 = arg_238_1:GetWordFromCfg(411111056)
				local var_241_19 = arg_238_1:FormatText(var_241_18.content)

				arg_238_1.text_.text = var_241_19

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_20 = 6
				local var_241_21 = utf8.len(var_241_19)
				local var_241_22 = var_241_20 <= 0 and var_241_16 or var_241_16 * (var_241_21 / var_241_20)

				if var_241_22 > 0 and var_241_16 < var_241_22 then
					arg_238_1.talkMaxDuration = var_241_22

					if var_241_22 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_22 + var_241_15
					end
				end

				arg_238_1.text_.text = var_241_19
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111056", "story_v_out_411111.awb") ~= 0 then
					local var_241_23 = manager.audio:GetVoiceLength("story_v_out_411111", "411111056", "story_v_out_411111.awb") / 1000

					if var_241_23 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_23 + var_241_15
					end

					if var_241_18.prefab_name ~= "" and arg_238_1.actors_[var_241_18.prefab_name] ~= nil then
						local var_241_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_18.prefab_name].transform, "story_v_out_411111", "411111056", "story_v_out_411111.awb")

						arg_238_1:RecordAudio("411111056", var_241_24)
						arg_238_1:RecordAudio("411111056", var_241_24)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_411111", "411111056", "story_v_out_411111.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_411111", "411111056", "story_v_out_411111.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_25 = math.max(var_241_16, arg_238_1.talkMaxDuration)

			if var_241_15 <= arg_238_1.time_ and arg_238_1.time_ < var_241_15 + var_241_25 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_15) / var_241_25

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_15 + var_241_25 and arg_238_1.time_ < var_241_15 + var_241_25 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play411111057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 411111057
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play411111058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1095ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1095ui_story == nil then
				arg_242_1.var_.characterEffect1095ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect1095ui_story and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1095ui_story.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1095ui_story then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1095ui_story.fillRatio = var_245_5
			end

			local var_245_6 = arg_242_1.actors_["1095ui_story"].transform
			local var_245_7 = 0

			if var_245_7 < arg_242_1.time_ and arg_242_1.time_ <= var_245_7 + arg_245_0 then
				arg_242_1.var_.moveOldPos1095ui_story = var_245_6.localPosition
			end

			local var_245_8 = 0.001

			if var_245_7 <= arg_242_1.time_ and arg_242_1.time_ < var_245_7 + var_245_8 then
				local var_245_9 = (arg_242_1.time_ - var_245_7) / var_245_8
				local var_245_10 = Vector3.New(0, 100, 0)

				var_245_6.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1095ui_story, var_245_10, var_245_9)

				local var_245_11 = manager.ui.mainCamera.transform.position - var_245_6.position

				var_245_6.forward = Vector3.New(var_245_11.x, var_245_11.y, var_245_11.z)

				local var_245_12 = var_245_6.localEulerAngles

				var_245_12.z = 0
				var_245_12.x = 0
				var_245_6.localEulerAngles = var_245_12
			end

			if arg_242_1.time_ >= var_245_7 + var_245_8 and arg_242_1.time_ < var_245_7 + var_245_8 + arg_245_0 then
				var_245_6.localPosition = Vector3.New(0, 100, 0)

				local var_245_13 = manager.ui.mainCamera.transform.position - var_245_6.position

				var_245_6.forward = Vector3.New(var_245_13.x, var_245_13.y, var_245_13.z)

				local var_245_14 = var_245_6.localEulerAngles

				var_245_14.z = 0
				var_245_14.x = 0
				var_245_6.localEulerAngles = var_245_14
			end

			local var_245_15 = arg_242_1.actors_["10071ui_story"].transform
			local var_245_16 = 0

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 then
				arg_242_1.var_.moveOldPos10071ui_story = var_245_15.localPosition
			end

			local var_245_17 = 0.001

			if var_245_16 <= arg_242_1.time_ and arg_242_1.time_ < var_245_16 + var_245_17 then
				local var_245_18 = (arg_242_1.time_ - var_245_16) / var_245_17
				local var_245_19 = Vector3.New(0, 100, 0)

				var_245_15.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10071ui_story, var_245_19, var_245_18)

				local var_245_20 = manager.ui.mainCamera.transform.position - var_245_15.position

				var_245_15.forward = Vector3.New(var_245_20.x, var_245_20.y, var_245_20.z)

				local var_245_21 = var_245_15.localEulerAngles

				var_245_21.z = 0
				var_245_21.x = 0
				var_245_15.localEulerAngles = var_245_21
			end

			if arg_242_1.time_ >= var_245_16 + var_245_17 and arg_242_1.time_ < var_245_16 + var_245_17 + arg_245_0 then
				var_245_15.localPosition = Vector3.New(0, 100, 0)

				local var_245_22 = manager.ui.mainCamera.transform.position - var_245_15.position

				var_245_15.forward = Vector3.New(var_245_22.x, var_245_22.y, var_245_22.z)

				local var_245_23 = var_245_15.localEulerAngles

				var_245_23.z = 0
				var_245_23.x = 0
				var_245_15.localEulerAngles = var_245_23
			end

			local var_245_24 = 0
			local var_245_25 = 1.225

			if var_245_24 < arg_242_1.time_ and arg_242_1.time_ <= var_245_24 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_26 = arg_242_1:GetWordFromCfg(411111057)
				local var_245_27 = arg_242_1:FormatText(var_245_26.content)

				arg_242_1.text_.text = var_245_27

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_28 = 49
				local var_245_29 = utf8.len(var_245_27)
				local var_245_30 = var_245_28 <= 0 and var_245_25 or var_245_25 * (var_245_29 / var_245_28)

				if var_245_30 > 0 and var_245_25 < var_245_30 then
					arg_242_1.talkMaxDuration = var_245_30

					if var_245_30 + var_245_24 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_30 + var_245_24
					end
				end

				arg_242_1.text_.text = var_245_27
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_31 = math.max(var_245_25, arg_242_1.talkMaxDuration)

			if var_245_24 <= arg_242_1.time_ and arg_242_1.time_ < var_245_24 + var_245_31 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_24) / var_245_31

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_24 + var_245_31 and arg_242_1.time_ < var_245_24 + var_245_31 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play411111058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 411111058
		arg_246_1.duration_ = 2

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play411111059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1095ui_story"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos1095ui_story = var_249_0.localPosition
			end

			local var_249_2 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2
				local var_249_4 = Vector3.New(0, -0.98, -6.1)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1095ui_story, var_249_4, var_249_3)

				local var_249_5 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_5.x, var_249_5.y, var_249_5.z)

				local var_249_6 = var_249_0.localEulerAngles

				var_249_6.z = 0
				var_249_6.x = 0
				var_249_0.localEulerAngles = var_249_6
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_249_7 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_7.x, var_249_7.y, var_249_7.z)

				local var_249_8 = var_249_0.localEulerAngles

				var_249_8.z = 0
				var_249_8.x = 0
				var_249_0.localEulerAngles = var_249_8
			end

			local var_249_9 = arg_246_1.actors_["1095ui_story"]
			local var_249_10 = 0

			if var_249_10 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 and not isNil(var_249_9) and arg_246_1.var_.characterEffect1095ui_story == nil then
				arg_246_1.var_.characterEffect1095ui_story = var_249_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_11 = 0.200000002980232

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_11 and not isNil(var_249_9) then
				local var_249_12 = (arg_246_1.time_ - var_249_10) / var_249_11

				if arg_246_1.var_.characterEffect1095ui_story and not isNil(var_249_9) then
					arg_246_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_10 + var_249_11 and arg_246_1.time_ < var_249_10 + var_249_11 + arg_249_0 and not isNil(var_249_9) and arg_246_1.var_.characterEffect1095ui_story then
				arg_246_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_249_13 = 0

			if var_249_13 < arg_246_1.time_ and arg_246_1.time_ <= var_249_13 + arg_249_0 then
				arg_246_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_249_14 = 0

			if var_249_14 < arg_246_1.time_ and arg_246_1.time_ <= var_249_14 + arg_249_0 then
				arg_246_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_249_15 = 0
			local var_249_16 = 0.15

			if var_249_15 < arg_246_1.time_ and arg_246_1.time_ <= var_249_15 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_17 = arg_246_1:FormatText(StoryNameCfg[471].name)

				arg_246_1.leftNameTxt_.text = var_249_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_18 = arg_246_1:GetWordFromCfg(411111058)
				local var_249_19 = arg_246_1:FormatText(var_249_18.content)

				arg_246_1.text_.text = var_249_19

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_20 = 6
				local var_249_21 = utf8.len(var_249_19)
				local var_249_22 = var_249_20 <= 0 and var_249_16 or var_249_16 * (var_249_21 / var_249_20)

				if var_249_22 > 0 and var_249_16 < var_249_22 then
					arg_246_1.talkMaxDuration = var_249_22

					if var_249_22 + var_249_15 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_22 + var_249_15
					end
				end

				arg_246_1.text_.text = var_249_19
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111058", "story_v_out_411111.awb") ~= 0 then
					local var_249_23 = manager.audio:GetVoiceLength("story_v_out_411111", "411111058", "story_v_out_411111.awb") / 1000

					if var_249_23 + var_249_15 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_23 + var_249_15
					end

					if var_249_18.prefab_name ~= "" and arg_246_1.actors_[var_249_18.prefab_name] ~= nil then
						local var_249_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_18.prefab_name].transform, "story_v_out_411111", "411111058", "story_v_out_411111.awb")

						arg_246_1:RecordAudio("411111058", var_249_24)
						arg_246_1:RecordAudio("411111058", var_249_24)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_411111", "411111058", "story_v_out_411111.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_411111", "411111058", "story_v_out_411111.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_25 = math.max(var_249_16, arg_246_1.talkMaxDuration)

			if var_249_15 <= arg_246_1.time_ and arg_246_1.time_ < var_249_15 + var_249_25 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_15) / var_249_25

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_15 + var_249_25 and arg_246_1.time_ < var_249_15 + var_249_25 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play411111059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 411111059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play411111060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1095ui_story"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos1095ui_story = var_253_0.localPosition
			end

			local var_253_2 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2
				local var_253_4 = Vector3.New(0, 100, 0)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1095ui_story, var_253_4, var_253_3)

				local var_253_5 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_5.x, var_253_5.y, var_253_5.z)

				local var_253_6 = var_253_0.localEulerAngles

				var_253_6.z = 0
				var_253_6.x = 0
				var_253_0.localEulerAngles = var_253_6
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(0, 100, 0)

				local var_253_7 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_7.x, var_253_7.y, var_253_7.z)

				local var_253_8 = var_253_0.localEulerAngles

				var_253_8.z = 0
				var_253_8.x = 0
				var_253_0.localEulerAngles = var_253_8
			end

			local var_253_9 = 0
			local var_253_10 = 1.35

			if var_253_9 < arg_250_1.time_ and arg_250_1.time_ <= var_253_9 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_11 = arg_250_1:GetWordFromCfg(411111059)
				local var_253_12 = arg_250_1:FormatText(var_253_11.content)

				arg_250_1.text_.text = var_253_12

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_13 = 52
				local var_253_14 = utf8.len(var_253_12)
				local var_253_15 = var_253_13 <= 0 and var_253_10 or var_253_10 * (var_253_14 / var_253_13)

				if var_253_15 > 0 and var_253_10 < var_253_15 then
					arg_250_1.talkMaxDuration = var_253_15

					if var_253_15 + var_253_9 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_15 + var_253_9
					end
				end

				arg_250_1.text_.text = var_253_12
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_16 = math.max(var_253_10, arg_250_1.talkMaxDuration)

			if var_253_9 <= arg_250_1.time_ and arg_250_1.time_ < var_253_9 + var_253_16 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_9) / var_253_16

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_9 + var_253_16 and arg_250_1.time_ < var_253_9 + var_253_16 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play411111060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 411111060
		arg_254_1.duration_ = 3.1

		local var_254_0 = {
			zh = 1.999999999999,
			ja = 3.1
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
				arg_254_0:Play411111061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1095ui_story"].transform
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.var_.moveOldPos1095ui_story = var_257_0.localPosition
			end

			local var_257_2 = 0.001

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2
				local var_257_4 = Vector3.New(0, -0.98, -6.1)

				var_257_0.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1095ui_story, var_257_4, var_257_3)

				local var_257_5 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_5.x, var_257_5.y, var_257_5.z)

				local var_257_6 = var_257_0.localEulerAngles

				var_257_6.z = 0
				var_257_6.x = 0
				var_257_0.localEulerAngles = var_257_6
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 then
				var_257_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_257_7 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_7.x, var_257_7.y, var_257_7.z)

				local var_257_8 = var_257_0.localEulerAngles

				var_257_8.z = 0
				var_257_8.x = 0
				var_257_0.localEulerAngles = var_257_8
			end

			local var_257_9 = arg_254_1.actors_["1095ui_story"]
			local var_257_10 = 0

			if var_257_10 < arg_254_1.time_ and arg_254_1.time_ <= var_257_10 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect1095ui_story == nil then
				arg_254_1.var_.characterEffect1095ui_story = var_257_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_11 = 0.200000002980232

			if var_257_10 <= arg_254_1.time_ and arg_254_1.time_ < var_257_10 + var_257_11 and not isNil(var_257_9) then
				local var_257_12 = (arg_254_1.time_ - var_257_10) / var_257_11

				if arg_254_1.var_.characterEffect1095ui_story and not isNil(var_257_9) then
					arg_254_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_10 + var_257_11 and arg_254_1.time_ < var_257_10 + var_257_11 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect1095ui_story then
				arg_254_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_257_13 = 0

			if var_257_13 < arg_254_1.time_ and arg_254_1.time_ <= var_257_13 + arg_257_0 then
				arg_254_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_257_14 = 0

			if var_257_14 < arg_254_1.time_ and arg_254_1.time_ <= var_257_14 + arg_257_0 then
				arg_254_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_257_15 = arg_254_1.actors_["10071ui_story"].transform
			local var_257_16 = 0

			if var_257_16 < arg_254_1.time_ and arg_254_1.time_ <= var_257_16 + arg_257_0 then
				arg_254_1.var_.moveOldPos10071ui_story = var_257_15.localPosition
			end

			local var_257_17 = 0.001

			if var_257_16 <= arg_254_1.time_ and arg_254_1.time_ < var_257_16 + var_257_17 then
				local var_257_18 = (arg_254_1.time_ - var_257_16) / var_257_17
				local var_257_19 = Vector3.New(0, 100, 0)

				var_257_15.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10071ui_story, var_257_19, var_257_18)

				local var_257_20 = manager.ui.mainCamera.transform.position - var_257_15.position

				var_257_15.forward = Vector3.New(var_257_20.x, var_257_20.y, var_257_20.z)

				local var_257_21 = var_257_15.localEulerAngles

				var_257_21.z = 0
				var_257_21.x = 0
				var_257_15.localEulerAngles = var_257_21
			end

			if arg_254_1.time_ >= var_257_16 + var_257_17 and arg_254_1.time_ < var_257_16 + var_257_17 + arg_257_0 then
				var_257_15.localPosition = Vector3.New(0, 100, 0)

				local var_257_22 = manager.ui.mainCamera.transform.position - var_257_15.position

				var_257_15.forward = Vector3.New(var_257_22.x, var_257_22.y, var_257_22.z)

				local var_257_23 = var_257_15.localEulerAngles

				var_257_23.z = 0
				var_257_23.x = 0
				var_257_15.localEulerAngles = var_257_23
			end

			local var_257_24 = arg_254_1.actors_["10071ui_story"]
			local var_257_25 = 0

			if var_257_25 < arg_254_1.time_ and arg_254_1.time_ <= var_257_25 + arg_257_0 and not isNil(var_257_24) and arg_254_1.var_.characterEffect10071ui_story == nil then
				arg_254_1.var_.characterEffect10071ui_story = var_257_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_26 = 0.200000002980232

			if var_257_25 <= arg_254_1.time_ and arg_254_1.time_ < var_257_25 + var_257_26 and not isNil(var_257_24) then
				local var_257_27 = (arg_254_1.time_ - var_257_25) / var_257_26

				if arg_254_1.var_.characterEffect10071ui_story and not isNil(var_257_24) then
					local var_257_28 = Mathf.Lerp(0, 0.5, var_257_27)

					arg_254_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_254_1.var_.characterEffect10071ui_story.fillRatio = var_257_28
				end
			end

			if arg_254_1.time_ >= var_257_25 + var_257_26 and arg_254_1.time_ < var_257_25 + var_257_26 + arg_257_0 and not isNil(var_257_24) and arg_254_1.var_.characterEffect10071ui_story then
				local var_257_29 = 0.5

				arg_254_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_254_1.var_.characterEffect10071ui_story.fillRatio = var_257_29
			end

			local var_257_30 = 0
			local var_257_31 = 0.15

			if var_257_30 < arg_254_1.time_ and arg_254_1.time_ <= var_257_30 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_32 = arg_254_1:FormatText(StoryNameCfg[471].name)

				arg_254_1.leftNameTxt_.text = var_257_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_33 = arg_254_1:GetWordFromCfg(411111060)
				local var_257_34 = arg_254_1:FormatText(var_257_33.content)

				arg_254_1.text_.text = var_257_34

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_35 = 6
				local var_257_36 = utf8.len(var_257_34)
				local var_257_37 = var_257_35 <= 0 and var_257_31 or var_257_31 * (var_257_36 / var_257_35)

				if var_257_37 > 0 and var_257_31 < var_257_37 then
					arg_254_1.talkMaxDuration = var_257_37

					if var_257_37 + var_257_30 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_37 + var_257_30
					end
				end

				arg_254_1.text_.text = var_257_34
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111060", "story_v_out_411111.awb") ~= 0 then
					local var_257_38 = manager.audio:GetVoiceLength("story_v_out_411111", "411111060", "story_v_out_411111.awb") / 1000

					if var_257_38 + var_257_30 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_38 + var_257_30
					end

					if var_257_33.prefab_name ~= "" and arg_254_1.actors_[var_257_33.prefab_name] ~= nil then
						local var_257_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_33.prefab_name].transform, "story_v_out_411111", "411111060", "story_v_out_411111.awb")

						arg_254_1:RecordAudio("411111060", var_257_39)
						arg_254_1:RecordAudio("411111060", var_257_39)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_411111", "411111060", "story_v_out_411111.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_411111", "411111060", "story_v_out_411111.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_40 = math.max(var_257_31, arg_254_1.talkMaxDuration)

			if var_257_30 <= arg_254_1.time_ and arg_254_1.time_ < var_257_30 + var_257_40 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_30) / var_257_40

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_30 + var_257_40 and arg_254_1.time_ < var_257_30 + var_257_40 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play411111061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 411111061
		arg_258_1.duration_ = 8.2

		local var_258_0 = {
			zh = 8.2,
			ja = 7
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play411111062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				local var_261_1 = manager.ui.mainCamera.transform.localPosition
				local var_261_2 = Vector3.New(0, 0, 10) + Vector3.New(var_261_1.x, var_261_1.y, 0)
				local var_261_3 = arg_258_1.bgs_.ST74

				var_261_3.transform.localPosition = var_261_2
				var_261_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_261_4 = var_261_3:GetComponent("SpriteRenderer")

				if var_261_4 and var_261_4.sprite then
					local var_261_5 = (var_261_3.transform.localPosition - var_261_1).z
					local var_261_6 = manager.ui.mainCameraCom_
					local var_261_7 = 2 * var_261_5 * Mathf.Tan(var_261_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_261_8 = var_261_7 * var_261_6.aspect
					local var_261_9 = var_261_4.sprite.bounds.size.x
					local var_261_10 = var_261_4.sprite.bounds.size.y
					local var_261_11 = var_261_8 / var_261_9
					local var_261_12 = var_261_7 / var_261_10
					local var_261_13 = var_261_12 < var_261_11 and var_261_11 or var_261_12

					var_261_3.transform.localScale = Vector3.New(var_261_13, var_261_13, 0)
				end

				for iter_261_0, iter_261_1 in pairs(arg_258_1.bgs_) do
					if iter_261_0 ~= "ST74" then
						iter_261_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_261_14 = "STblack"

			if arg_258_1.bgs_[var_261_14] == nil then
				local var_261_15 = Object.Instantiate(arg_258_1.paintGo_)

				var_261_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_261_14)
				var_261_15.name = var_261_14
				var_261_15.transform.parent = arg_258_1.stage_.transform
				var_261_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_258_1.bgs_[var_261_14] = var_261_15
			end

			local var_261_16 = 2

			if var_261_16 < arg_258_1.time_ and arg_258_1.time_ <= var_261_16 + arg_261_0 then
				local var_261_17 = manager.ui.mainCamera.transform.localPosition
				local var_261_18 = Vector3.New(0, 0, 10) + Vector3.New(var_261_17.x, var_261_17.y, 0)
				local var_261_19 = arg_258_1.bgs_.STblack

				var_261_19.transform.localPosition = var_261_18
				var_261_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_261_20 = var_261_19:GetComponent("SpriteRenderer")

				if var_261_20 and var_261_20.sprite then
					local var_261_21 = (var_261_19.transform.localPosition - var_261_17).z
					local var_261_22 = manager.ui.mainCameraCom_
					local var_261_23 = 2 * var_261_21 * Mathf.Tan(var_261_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_261_24 = var_261_23 * var_261_22.aspect
					local var_261_25 = var_261_20.sprite.bounds.size.x
					local var_261_26 = var_261_20.sprite.bounds.size.y
					local var_261_27 = var_261_24 / var_261_25
					local var_261_28 = var_261_23 / var_261_26
					local var_261_29 = var_261_28 < var_261_27 and var_261_27 or var_261_28

					var_261_19.transform.localScale = Vector3.New(var_261_29, var_261_29, 0)
				end

				for iter_261_2, iter_261_3 in pairs(arg_258_1.bgs_) do
					if iter_261_2 ~= "STblack" then
						iter_261_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_261_30 = 0

			if var_261_30 < arg_258_1.time_ and arg_258_1.time_ <= var_261_30 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_31 = 2

			if var_261_30 <= arg_258_1.time_ and arg_258_1.time_ < var_261_30 + var_261_31 then
				local var_261_32 = (arg_258_1.time_ - var_261_30) / var_261_31
				local var_261_33 = Color.New(0, 0, 0)

				var_261_33.a = Mathf.Lerp(0, 1, var_261_32)
				arg_258_1.mask_.color = var_261_33
			end

			if arg_258_1.time_ >= var_261_30 + var_261_31 and arg_258_1.time_ < var_261_30 + var_261_31 + arg_261_0 then
				local var_261_34 = Color.New(0, 0, 0)

				var_261_34.a = 1
				arg_258_1.mask_.color = var_261_34
			end

			local var_261_35 = 2

			if var_261_35 < arg_258_1.time_ and arg_258_1.time_ <= var_261_35 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_36 = 2

			if var_261_35 <= arg_258_1.time_ and arg_258_1.time_ < var_261_35 + var_261_36 then
				local var_261_37 = (arg_258_1.time_ - var_261_35) / var_261_36
				local var_261_38 = Color.New(0, 0, 0)

				var_261_38.a = Mathf.Lerp(1, 0, var_261_37)
				arg_258_1.mask_.color = var_261_38
			end

			if arg_258_1.time_ >= var_261_35 + var_261_36 and arg_258_1.time_ < var_261_35 + var_261_36 + arg_261_0 then
				local var_261_39 = Color.New(0, 0, 0)
				local var_261_40 = 0

				arg_258_1.mask_.enabled = false
				var_261_39.a = var_261_40
				arg_258_1.mask_.color = var_261_39
			end

			local var_261_41 = arg_258_1.actors_["1095ui_story"].transform
			local var_261_42 = 2

			if var_261_42 < arg_258_1.time_ and arg_258_1.time_ <= var_261_42 + arg_261_0 then
				arg_258_1.var_.moveOldPos1095ui_story = var_261_41.localPosition
			end

			local var_261_43 = 0.001

			if var_261_42 <= arg_258_1.time_ and arg_258_1.time_ < var_261_42 + var_261_43 then
				local var_261_44 = (arg_258_1.time_ - var_261_42) / var_261_43
				local var_261_45 = Vector3.New(0, 100, 0)

				var_261_41.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1095ui_story, var_261_45, var_261_44)

				local var_261_46 = manager.ui.mainCamera.transform.position - var_261_41.position

				var_261_41.forward = Vector3.New(var_261_46.x, var_261_46.y, var_261_46.z)

				local var_261_47 = var_261_41.localEulerAngles

				var_261_47.z = 0
				var_261_47.x = 0
				var_261_41.localEulerAngles = var_261_47
			end

			if arg_258_1.time_ >= var_261_42 + var_261_43 and arg_258_1.time_ < var_261_42 + var_261_43 + arg_261_0 then
				var_261_41.localPosition = Vector3.New(0, 100, 0)

				local var_261_48 = manager.ui.mainCamera.transform.position - var_261_41.position

				var_261_41.forward = Vector3.New(var_261_48.x, var_261_48.y, var_261_48.z)

				local var_261_49 = var_261_41.localEulerAngles

				var_261_49.z = 0
				var_261_49.x = 0
				var_261_41.localEulerAngles = var_261_49
			end

			local var_261_50 = 0

			if var_261_50 < arg_258_1.time_ and arg_258_1.time_ <= var_261_50 + arg_261_0 then
				arg_258_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_261_51 = 0

			if var_261_51 < arg_258_1.time_ and arg_258_1.time_ <= var_261_51 + arg_261_0 then
				arg_258_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if arg_258_1.frameCnt_ <= 1 then
				arg_258_1.dialog_:SetActive(false)
			end

			local var_261_52 = 4
			local var_261_53 = 0.4

			if var_261_52 < arg_258_1.time_ and arg_258_1.time_ <= var_261_52 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0

				arg_258_1.dialog_:SetActive(true)

				arg_258_1.dialogCg_.alpha = 0

				local var_261_54 = LeanTween.value(arg_258_1.dialog_, 0, 1, 0.3)

				var_261_54:setOnUpdate(LuaHelper.FloatAction(function(arg_262_0)
					arg_258_1.dialogCg_.alpha = arg_262_0
				end))
				var_261_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_258_1.dialog_)
					var_261_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_258_1.duration_ = arg_258_1.duration_ + 0.3

				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_55 = arg_258_1:FormatText(StoryNameCfg[471].name)

				arg_258_1.leftNameTxt_.text = var_261_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_56 = arg_258_1:GetWordFromCfg(411111061)
				local var_261_57 = arg_258_1:FormatText(var_261_56.content)

				arg_258_1.text_.text = var_261_57

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_58 = 16
				local var_261_59 = utf8.len(var_261_57)
				local var_261_60 = var_261_58 <= 0 and var_261_53 or var_261_53 * (var_261_59 / var_261_58)

				if var_261_60 > 0 and var_261_53 < var_261_60 then
					arg_258_1.talkMaxDuration = var_261_60
					var_261_52 = var_261_52 + 0.3

					if var_261_60 + var_261_52 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_60 + var_261_52
					end
				end

				arg_258_1.text_.text = var_261_57
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111061", "story_v_out_411111.awb") ~= 0 then
					local var_261_61 = manager.audio:GetVoiceLength("story_v_out_411111", "411111061", "story_v_out_411111.awb") / 1000

					if var_261_61 + var_261_52 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_61 + var_261_52
					end

					if var_261_56.prefab_name ~= "" and arg_258_1.actors_[var_261_56.prefab_name] ~= nil then
						local var_261_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_56.prefab_name].transform, "story_v_out_411111", "411111061", "story_v_out_411111.awb")

						arg_258_1:RecordAudio("411111061", var_261_62)
						arg_258_1:RecordAudio("411111061", var_261_62)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_411111", "411111061", "story_v_out_411111.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_411111", "411111061", "story_v_out_411111.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_63 = var_261_52 + 0.3
			local var_261_64 = math.max(var_261_53, arg_258_1.talkMaxDuration)

			if var_261_63 <= arg_258_1.time_ and arg_258_1.time_ < var_261_63 + var_261_64 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_63) / var_261_64

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_63 + var_261_64 and arg_258_1.time_ < var_261_63 + var_261_64 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play411111062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 411111062
		arg_264_1.duration_ = 12.5

		local var_264_0 = {
			zh = 3.466,
			ja = 12.5
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play411111063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1095ui_story"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1095ui_story == nil then
				arg_264_1.var_.characterEffect1095ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect1095ui_story and not isNil(var_267_0) then
					local var_267_4 = Mathf.Lerp(0, 0.5, var_267_3)

					arg_264_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1095ui_story.fillRatio = var_267_4
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1095ui_story then
				local var_267_5 = 0.5

				arg_264_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1095ui_story.fillRatio = var_267_5
			end

			local var_267_6 = arg_264_1.actors_["1095ui_story"].transform
			local var_267_7 = 0

			if var_267_7 < arg_264_1.time_ and arg_264_1.time_ <= var_267_7 + arg_267_0 then
				arg_264_1.var_.moveOldPos1095ui_story = var_267_6.localPosition
			end

			local var_267_8 = 0.001

			if var_267_7 <= arg_264_1.time_ and arg_264_1.time_ < var_267_7 + var_267_8 then
				local var_267_9 = (arg_264_1.time_ - var_267_7) / var_267_8
				local var_267_10 = Vector3.New(0, 100, 0)

				var_267_6.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1095ui_story, var_267_10, var_267_9)

				local var_267_11 = manager.ui.mainCamera.transform.position - var_267_6.position

				var_267_6.forward = Vector3.New(var_267_11.x, var_267_11.y, var_267_11.z)

				local var_267_12 = var_267_6.localEulerAngles

				var_267_12.z = 0
				var_267_12.x = 0
				var_267_6.localEulerAngles = var_267_12
			end

			if arg_264_1.time_ >= var_267_7 + var_267_8 and arg_264_1.time_ < var_267_7 + var_267_8 + arg_267_0 then
				var_267_6.localPosition = Vector3.New(0, 100, 0)

				local var_267_13 = manager.ui.mainCamera.transform.position - var_267_6.position

				var_267_6.forward = Vector3.New(var_267_13.x, var_267_13.y, var_267_13.z)

				local var_267_14 = var_267_6.localEulerAngles

				var_267_14.z = 0
				var_267_14.x = 0
				var_267_6.localEulerAngles = var_267_14
			end

			local var_267_15 = 0

			if var_267_15 < arg_264_1.time_ and arg_264_1.time_ <= var_267_15 + arg_267_0 then
				local var_267_16 = manager.ui.mainCamera.transform.localPosition
				local var_267_17 = Vector3.New(0, 0, 10) + Vector3.New(var_267_16.x, var_267_16.y, 0)
				local var_267_18 = arg_264_1.bgs_.STblack

				var_267_18.transform.localPosition = var_267_17
				var_267_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_267_19 = var_267_18:GetComponent("SpriteRenderer")

				if var_267_19 and var_267_19.sprite then
					local var_267_20 = (var_267_18.transform.localPosition - var_267_16).z
					local var_267_21 = manager.ui.mainCameraCom_
					local var_267_22 = 2 * var_267_20 * Mathf.Tan(var_267_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_267_23 = var_267_22 * var_267_21.aspect
					local var_267_24 = var_267_19.sprite.bounds.size.x
					local var_267_25 = var_267_19.sprite.bounds.size.y
					local var_267_26 = var_267_23 / var_267_24
					local var_267_27 = var_267_22 / var_267_25
					local var_267_28 = var_267_27 < var_267_26 and var_267_26 or var_267_27

					var_267_18.transform.localScale = Vector3.New(var_267_28, var_267_28, 0)
				end

				for iter_267_0, iter_267_1 in pairs(arg_264_1.bgs_) do
					if iter_267_0 ~= "STblack" then
						iter_267_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_267_29 = 0

			if var_267_29 < arg_264_1.time_ and arg_264_1.time_ <= var_267_29 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_30 = 2.03333333333333

			if var_267_29 <= arg_264_1.time_ and arg_264_1.time_ < var_267_29 + var_267_30 then
				local var_267_31 = (arg_264_1.time_ - var_267_29) / var_267_30
				local var_267_32 = Color.New(1, 1, 1)

				var_267_32.a = Mathf.Lerp(1, 0, var_267_31)
				arg_264_1.mask_.color = var_267_32
			end

			if arg_264_1.time_ >= var_267_29 + var_267_30 and arg_264_1.time_ < var_267_29 + var_267_30 + arg_267_0 then
				local var_267_33 = Color.New(1, 1, 1)
				local var_267_34 = 0

				arg_264_1.mask_.enabled = false
				var_267_33.a = var_267_34
				arg_264_1.mask_.color = var_267_33
			end

			if arg_264_1.frameCnt_ <= 1 then
				arg_264_1.dialog_:SetActive(false)
			end

			local var_267_35 = 2
			local var_267_36 = 0.075

			if var_267_35 < arg_264_1.time_ and arg_264_1.time_ <= var_267_35 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				arg_264_1.dialog_:SetActive(true)

				arg_264_1.dialogCg_.alpha = 0

				local var_267_37 = LeanTween.value(arg_264_1.dialog_, 0, 1, 0.3)

				var_267_37:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_264_1.dialogCg_.alpha = arg_268_0
				end))
				var_267_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_264_1.dialog_)
					var_267_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_264_1.duration_ = arg_264_1.duration_ + 0.3

				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_38 = arg_264_1:FormatText(StoryNameCfg[687].name)

				arg_264_1.leftNameTxt_.text = var_267_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_39 = arg_264_1:GetWordFromCfg(411111062)
				local var_267_40 = arg_264_1:FormatText(var_267_39.content)

				arg_264_1.text_.text = var_267_40

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_41 = 3
				local var_267_42 = utf8.len(var_267_40)
				local var_267_43 = var_267_41 <= 0 and var_267_36 or var_267_36 * (var_267_42 / var_267_41)

				if var_267_43 > 0 and var_267_36 < var_267_43 then
					arg_264_1.talkMaxDuration = var_267_43
					var_267_35 = var_267_35 + 0.3

					if var_267_43 + var_267_35 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_43 + var_267_35
					end
				end

				arg_264_1.text_.text = var_267_40
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111062", "story_v_out_411111.awb") ~= 0 then
					local var_267_44 = manager.audio:GetVoiceLength("story_v_out_411111", "411111062", "story_v_out_411111.awb") / 1000

					if var_267_44 + var_267_35 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_44 + var_267_35
					end

					if var_267_39.prefab_name ~= "" and arg_264_1.actors_[var_267_39.prefab_name] ~= nil then
						local var_267_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_39.prefab_name].transform, "story_v_out_411111", "411111062", "story_v_out_411111.awb")

						arg_264_1:RecordAudio("411111062", var_267_45)
						arg_264_1:RecordAudio("411111062", var_267_45)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_411111", "411111062", "story_v_out_411111.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_411111", "411111062", "story_v_out_411111.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_46 = var_267_35 + 0.3
			local var_267_47 = math.max(var_267_36, arg_264_1.talkMaxDuration)

			if var_267_46 <= arg_264_1.time_ and arg_264_1.time_ < var_267_46 + var_267_47 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_46) / var_267_47

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_46 + var_267_47 and arg_264_1.time_ < var_267_46 + var_267_47 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play411111063 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 411111063
		arg_270_1.duration_ = 13.53

		local var_270_0 = {
			zh = 13.533,
			ja = 8.9
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play411111064(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 1.2

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[471].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_3 = arg_270_1:GetWordFromCfg(411111063)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 48
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111063", "story_v_out_411111.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111063", "story_v_out_411111.awb") / 1000

					if var_273_8 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_0
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_411111", "411111063", "story_v_out_411111.awb")

						arg_270_1:RecordAudio("411111063", var_273_9)
						arg_270_1:RecordAudio("411111063", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_411111", "411111063", "story_v_out_411111.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_411111", "411111063", "story_v_out_411111.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_10 and arg_270_1.time_ < var_273_0 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play411111064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 411111064
		arg_274_1.duration_ = 4.3

		local var_274_0 = {
			zh = 2.1,
			ja = 4.3
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
				arg_274_0:Play411111065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.175

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[29].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_3 = arg_274_1:GetWordFromCfg(411111064)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 7
				local var_277_6 = utf8.len(var_277_4)
				local var_277_7 = var_277_5 <= 0 and var_277_1 or var_277_1 * (var_277_6 / var_277_5)

				if var_277_7 > 0 and var_277_1 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111064", "story_v_out_411111.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111064", "story_v_out_411111.awb") / 1000

					if var_277_8 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_0
					end

					if var_277_3.prefab_name ~= "" and arg_274_1.actors_[var_277_3.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_3.prefab_name].transform, "story_v_out_411111", "411111064", "story_v_out_411111.awb")

						arg_274_1:RecordAudio("411111064", var_277_9)
						arg_274_1:RecordAudio("411111064", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_411111", "411111064", "story_v_out_411111.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_411111", "411111064", "story_v_out_411111.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_10 and arg_274_1.time_ < var_277_0 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play411111065 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 411111065
		arg_278_1.duration_ = 13.63

		local var_278_0 = {
			zh = 12.333,
			ja = 13.633
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
				arg_278_0:Play411111066(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 1.225

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[471].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_3 = arg_278_1:GetWordFromCfg(411111065)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 49
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111065", "story_v_out_411111.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111065", "story_v_out_411111.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_411111", "411111065", "story_v_out_411111.awb")

						arg_278_1:RecordAudio("411111065", var_281_9)
						arg_278_1:RecordAudio("411111065", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_411111", "411111065", "story_v_out_411111.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_411111", "411111065", "story_v_out_411111.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_10 and arg_278_1.time_ < var_281_0 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play411111066 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 411111066
		arg_282_1.duration_ = 2.23

		local var_282_0 = {
			zh = 2.233,
			ja = 2.066
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
				arg_282_0:Play411111067(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.15

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_2 = arg_282_1:FormatText(StoryNameCfg[687].name)

				arg_282_1.leftNameTxt_.text = var_285_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_3 = arg_282_1:GetWordFromCfg(411111066)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 6
				local var_285_6 = utf8.len(var_285_4)
				local var_285_7 = var_285_5 <= 0 and var_285_1 or var_285_1 * (var_285_6 / var_285_5)

				if var_285_7 > 0 and var_285_1 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111066", "story_v_out_411111.awb") ~= 0 then
					local var_285_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111066", "story_v_out_411111.awb") / 1000

					if var_285_8 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_8 + var_285_0
					end

					if var_285_3.prefab_name ~= "" and arg_282_1.actors_[var_285_3.prefab_name] ~= nil then
						local var_285_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_3.prefab_name].transform, "story_v_out_411111", "411111066", "story_v_out_411111.awb")

						arg_282_1:RecordAudio("411111066", var_285_9)
						arg_282_1:RecordAudio("411111066", var_285_9)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_411111", "411111066", "story_v_out_411111.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_411111", "411111066", "story_v_out_411111.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_10 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_10 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_10

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_10 and arg_282_1.time_ < var_285_0 + var_285_10 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play411111067 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 411111067
		arg_286_1.duration_ = 7.3

		local var_286_0 = {
			zh = 4.6,
			ja = 7.3
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play411111068(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.45

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[471].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_3 = arg_286_1:GetWordFromCfg(411111067)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 18
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111067", "story_v_out_411111.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111067", "story_v_out_411111.awb") / 1000

					if var_289_8 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_0
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_out_411111", "411111067", "story_v_out_411111.awb")

						arg_286_1:RecordAudio("411111067", var_289_9)
						arg_286_1:RecordAudio("411111067", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_411111", "411111067", "story_v_out_411111.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_411111", "411111067", "story_v_out_411111.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_10 and arg_286_1.time_ < var_289_0 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play411111068 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 411111068
		arg_290_1.duration_ = 5.6

		local var_290_0 = {
			zh = 5.6,
			ja = 5.3
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
				arg_290_0:Play411111069(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.4

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[687].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_3 = arg_290_1:GetWordFromCfg(411111068)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 16
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111068", "story_v_out_411111.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111068", "story_v_out_411111.awb") / 1000

					if var_293_8 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_0
					end

					if var_293_3.prefab_name ~= "" and arg_290_1.actors_[var_293_3.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_3.prefab_name].transform, "story_v_out_411111", "411111068", "story_v_out_411111.awb")

						arg_290_1:RecordAudio("411111068", var_293_9)
						arg_290_1:RecordAudio("411111068", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_411111", "411111068", "story_v_out_411111.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_411111", "411111068", "story_v_out_411111.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_10 and arg_290_1.time_ < var_293_0 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play411111069 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 411111069
		arg_294_1.duration_ = 7

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play411111070(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = "B04f"

			if arg_294_1.bgs_[var_297_0] == nil then
				local var_297_1 = Object.Instantiate(arg_294_1.paintGo_)

				var_297_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_297_0)
				var_297_1.name = var_297_0
				var_297_1.transform.parent = arg_294_1.stage_.transform
				var_297_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.bgs_[var_297_0] = var_297_1
			end

			local var_297_2 = 0

			if var_297_2 < arg_294_1.time_ and arg_294_1.time_ <= var_297_2 + arg_297_0 then
				local var_297_3 = manager.ui.mainCamera.transform.localPosition
				local var_297_4 = Vector3.New(0, 0, 10) + Vector3.New(var_297_3.x, var_297_3.y, 0)
				local var_297_5 = arg_294_1.bgs_.B04f

				var_297_5.transform.localPosition = var_297_4
				var_297_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_6 = var_297_5:GetComponent("SpriteRenderer")

				if var_297_6 and var_297_6.sprite then
					local var_297_7 = (var_297_5.transform.localPosition - var_297_3).z
					local var_297_8 = manager.ui.mainCameraCom_
					local var_297_9 = 2 * var_297_7 * Mathf.Tan(var_297_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_297_10 = var_297_9 * var_297_8.aspect
					local var_297_11 = var_297_6.sprite.bounds.size.x
					local var_297_12 = var_297_6.sprite.bounds.size.y
					local var_297_13 = var_297_10 / var_297_11
					local var_297_14 = var_297_9 / var_297_12
					local var_297_15 = var_297_14 < var_297_13 and var_297_13 or var_297_14

					var_297_5.transform.localScale = Vector3.New(var_297_15, var_297_15, 0)
				end

				for iter_297_0, iter_297_1 in pairs(arg_294_1.bgs_) do
					if iter_297_0 ~= "B04f" then
						iter_297_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_16 = 0

			if var_297_16 < arg_294_1.time_ and arg_294_1.time_ <= var_297_16 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_17 = 2

			if var_297_16 <= arg_294_1.time_ and arg_294_1.time_ < var_297_16 + var_297_17 then
				local var_297_18 = (arg_294_1.time_ - var_297_16) / var_297_17
				local var_297_19 = Color.New(0, 0, 0)

				var_297_19.a = Mathf.Lerp(1, 0, var_297_18)
				arg_294_1.mask_.color = var_297_19
			end

			if arg_294_1.time_ >= var_297_16 + var_297_17 and arg_294_1.time_ < var_297_16 + var_297_17 + arg_297_0 then
				local var_297_20 = Color.New(0, 0, 0)
				local var_297_21 = 0

				arg_294_1.mask_.enabled = false
				var_297_20.a = var_297_21
				arg_294_1.mask_.color = var_297_20
			end

			local var_297_22 = 2.9
			local var_297_23 = 0.325

			if var_297_22 < arg_294_1.time_ and arg_294_1.time_ <= var_297_22 + arg_297_0 then
				local var_297_24 = "play"
				local var_297_25 = "effect"

				arg_294_1:AudioAction(var_297_24, var_297_25, "se_story_126_01", "se_story_126_01_fight_loop", "")
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_26 = 2
			local var_297_27 = 1.225

			if var_297_26 < arg_294_1.time_ and arg_294_1.time_ <= var_297_26 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_28 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_28:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_29 = arg_294_1:GetWordFromCfg(411111069)
				local var_297_30 = arg_294_1:FormatText(var_297_29.content)

				arg_294_1.text_.text = var_297_30

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_31 = 49
				local var_297_32 = utf8.len(var_297_30)
				local var_297_33 = var_297_31 <= 0 and var_297_27 or var_297_27 * (var_297_32 / var_297_31)

				if var_297_33 > 0 and var_297_27 < var_297_33 then
					arg_294_1.talkMaxDuration = var_297_33
					var_297_26 = var_297_26 + 0.3

					if var_297_33 + var_297_26 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_33 + var_297_26
					end
				end

				arg_294_1.text_.text = var_297_30
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_34 = var_297_26 + 0.3
			local var_297_35 = math.max(var_297_27, arg_294_1.talkMaxDuration)

			if var_297_34 <= arg_294_1.time_ and arg_294_1.time_ < var_297_34 + var_297_35 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_34) / var_297_35

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_34 + var_297_35 and arg_294_1.time_ < var_297_34 + var_297_35 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play411111070 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 411111070
		arg_300_1.duration_ = 2.63

		local var_300_0 = {
			zh = 1.999999999999,
			ja = 2.633
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play411111071(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["1095ui_story"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos1095ui_story = var_303_0.localPosition
			end

			local var_303_2 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2
				local var_303_4 = Vector3.New(0, -0.98, -6.1)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1095ui_story, var_303_4, var_303_3)

				local var_303_5 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_5.x, var_303_5.y, var_303_5.z)

				local var_303_6 = var_303_0.localEulerAngles

				var_303_6.z = 0
				var_303_6.x = 0
				var_303_0.localEulerAngles = var_303_6
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_303_7 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_7.x, var_303_7.y, var_303_7.z)

				local var_303_8 = var_303_0.localEulerAngles

				var_303_8.z = 0
				var_303_8.x = 0
				var_303_0.localEulerAngles = var_303_8
			end

			local var_303_9 = arg_300_1.actors_["1095ui_story"]
			local var_303_10 = 0

			if var_303_10 < arg_300_1.time_ and arg_300_1.time_ <= var_303_10 + arg_303_0 and not isNil(var_303_9) and arg_300_1.var_.characterEffect1095ui_story == nil then
				arg_300_1.var_.characterEffect1095ui_story = var_303_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_11 = 0.200000002980232

			if var_303_10 <= arg_300_1.time_ and arg_300_1.time_ < var_303_10 + var_303_11 and not isNil(var_303_9) then
				local var_303_12 = (arg_300_1.time_ - var_303_10) / var_303_11

				if arg_300_1.var_.characterEffect1095ui_story and not isNil(var_303_9) then
					arg_300_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_10 + var_303_11 and arg_300_1.time_ < var_303_10 + var_303_11 + arg_303_0 and not isNil(var_303_9) and arg_300_1.var_.characterEffect1095ui_story then
				arg_300_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_303_13 = 0

			if var_303_13 < arg_300_1.time_ and arg_300_1.time_ <= var_303_13 + arg_303_0 then
				arg_300_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action8_2")
			end

			local var_303_14 = 0

			if var_303_14 < arg_300_1.time_ and arg_300_1.time_ <= var_303_14 + arg_303_0 then
				arg_300_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_303_15 = 0
			local var_303_16 = 0.2

			if var_303_15 < arg_300_1.time_ and arg_300_1.time_ <= var_303_15 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_17 = arg_300_1:FormatText(StoryNameCfg[471].name)

				arg_300_1.leftNameTxt_.text = var_303_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_18 = arg_300_1:GetWordFromCfg(411111070)
				local var_303_19 = arg_300_1:FormatText(var_303_18.content)

				arg_300_1.text_.text = var_303_19

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_20 = 8
				local var_303_21 = utf8.len(var_303_19)
				local var_303_22 = var_303_20 <= 0 and var_303_16 or var_303_16 * (var_303_21 / var_303_20)

				if var_303_22 > 0 and var_303_16 < var_303_22 then
					arg_300_1.talkMaxDuration = var_303_22

					if var_303_22 + var_303_15 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_22 + var_303_15
					end
				end

				arg_300_1.text_.text = var_303_19
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111070", "story_v_out_411111.awb") ~= 0 then
					local var_303_23 = manager.audio:GetVoiceLength("story_v_out_411111", "411111070", "story_v_out_411111.awb") / 1000

					if var_303_23 + var_303_15 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_23 + var_303_15
					end

					if var_303_18.prefab_name ~= "" and arg_300_1.actors_[var_303_18.prefab_name] ~= nil then
						local var_303_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_18.prefab_name].transform, "story_v_out_411111", "411111070", "story_v_out_411111.awb")

						arg_300_1:RecordAudio("411111070", var_303_24)
						arg_300_1:RecordAudio("411111070", var_303_24)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_411111", "411111070", "story_v_out_411111.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_411111", "411111070", "story_v_out_411111.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_25 = math.max(var_303_16, arg_300_1.talkMaxDuration)

			if var_303_15 <= arg_300_1.time_ and arg_300_1.time_ < var_303_15 + var_303_25 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_15) / var_303_25

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_15 + var_303_25 and arg_300_1.time_ < var_303_15 + var_303_25 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play411111071 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 411111071
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play411111072(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1095ui_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1095ui_story == nil then
				arg_304_1.var_.characterEffect1095ui_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect1095ui_story and not isNil(var_307_0) then
					local var_307_4 = Mathf.Lerp(0, 0.5, var_307_3)

					arg_304_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1095ui_story.fillRatio = var_307_4
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1095ui_story then
				local var_307_5 = 0.5

				arg_304_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1095ui_story.fillRatio = var_307_5
			end

			local var_307_6 = 0
			local var_307_7 = 1.375

			if var_307_6 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_8 = arg_304_1:GetWordFromCfg(411111071)
				local var_307_9 = arg_304_1:FormatText(var_307_8.content)

				arg_304_1.text_.text = var_307_9

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_10 = 55
				local var_307_11 = utf8.len(var_307_9)
				local var_307_12 = var_307_10 <= 0 and var_307_7 or var_307_7 * (var_307_11 / var_307_10)

				if var_307_12 > 0 and var_307_7 < var_307_12 then
					arg_304_1.talkMaxDuration = var_307_12

					if var_307_12 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_12 + var_307_6
					end
				end

				arg_304_1.text_.text = var_307_9
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_13 = math.max(var_307_7, arg_304_1.talkMaxDuration)

			if var_307_6 <= arg_304_1.time_ and arg_304_1.time_ < var_307_6 + var_307_13 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_6) / var_307_13

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_6 + var_307_13 and arg_304_1.time_ < var_307_6 + var_307_13 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play411111072 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 411111072
		arg_308_1.duration_ = 9.87

		local var_308_0 = {
			zh = 9.866,
			ja = 4.566
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play411111073(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1095ui_story"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1095ui_story == nil then
				arg_308_1.var_.characterEffect1095ui_story = var_311_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.characterEffect1095ui_story and not isNil(var_311_0) then
					arg_308_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1095ui_story then
				arg_308_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_311_4 = 0
			local var_311_5 = 0.65

			if var_311_4 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_6 = arg_308_1:FormatText(StoryNameCfg[471].name)

				arg_308_1.leftNameTxt_.text = var_311_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_7 = arg_308_1:GetWordFromCfg(411111072)
				local var_311_8 = arg_308_1:FormatText(var_311_7.content)

				arg_308_1.text_.text = var_311_8

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_9 = 26
				local var_311_10 = utf8.len(var_311_8)
				local var_311_11 = var_311_9 <= 0 and var_311_5 or var_311_5 * (var_311_10 / var_311_9)

				if var_311_11 > 0 and var_311_5 < var_311_11 then
					arg_308_1.talkMaxDuration = var_311_11

					if var_311_11 + var_311_4 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_11 + var_311_4
					end
				end

				arg_308_1.text_.text = var_311_8
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111072", "story_v_out_411111.awb") ~= 0 then
					local var_311_12 = manager.audio:GetVoiceLength("story_v_out_411111", "411111072", "story_v_out_411111.awb") / 1000

					if var_311_12 + var_311_4 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_12 + var_311_4
					end

					if var_311_7.prefab_name ~= "" and arg_308_1.actors_[var_311_7.prefab_name] ~= nil then
						local var_311_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_7.prefab_name].transform, "story_v_out_411111", "411111072", "story_v_out_411111.awb")

						arg_308_1:RecordAudio("411111072", var_311_13)
						arg_308_1:RecordAudio("411111072", var_311_13)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_411111", "411111072", "story_v_out_411111.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_411111", "411111072", "story_v_out_411111.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_14 = math.max(var_311_5, arg_308_1.talkMaxDuration)

			if var_311_4 <= arg_308_1.time_ and arg_308_1.time_ < var_311_4 + var_311_14 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_4) / var_311_14

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_4 + var_311_14 and arg_308_1.time_ < var_311_4 + var_311_14 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play411111073 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 411111073
		arg_312_1.duration_ = 4.27

		local var_312_0 = {
			zh = 3.666,
			ja = 4.266
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play411111074(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1095ui_story"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect1095ui_story == nil then
				arg_312_1.var_.characterEffect1095ui_story = var_315_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.characterEffect1095ui_story and not isNil(var_315_0) then
					local var_315_4 = Mathf.Lerp(0, 0.5, var_315_3)

					arg_312_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1095ui_story.fillRatio = var_315_4
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect1095ui_story then
				local var_315_5 = 0.5

				arg_312_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1095ui_story.fillRatio = var_315_5
			end

			local var_315_6 = 0
			local var_315_7 = 0.5

			if var_315_6 < arg_312_1.time_ and arg_312_1.time_ <= var_315_6 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_8 = arg_312_1:FormatText(StoryNameCfg[681].name)

				arg_312_1.leftNameTxt_.text = var_315_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_9 = arg_312_1:GetWordFromCfg(411111073)
				local var_315_10 = arg_312_1:FormatText(var_315_9.content)

				arg_312_1.text_.text = var_315_10

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_11 = 20
				local var_315_12 = utf8.len(var_315_10)
				local var_315_13 = var_315_11 <= 0 and var_315_7 or var_315_7 * (var_315_12 / var_315_11)

				if var_315_13 > 0 and var_315_7 < var_315_13 then
					arg_312_1.talkMaxDuration = var_315_13

					if var_315_13 + var_315_6 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_13 + var_315_6
					end
				end

				arg_312_1.text_.text = var_315_10
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111073", "story_v_out_411111.awb") ~= 0 then
					local var_315_14 = manager.audio:GetVoiceLength("story_v_out_411111", "411111073", "story_v_out_411111.awb") / 1000

					if var_315_14 + var_315_6 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_14 + var_315_6
					end

					if var_315_9.prefab_name ~= "" and arg_312_1.actors_[var_315_9.prefab_name] ~= nil then
						local var_315_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_9.prefab_name].transform, "story_v_out_411111", "411111073", "story_v_out_411111.awb")

						arg_312_1:RecordAudio("411111073", var_315_15)
						arg_312_1:RecordAudio("411111073", var_315_15)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_411111", "411111073", "story_v_out_411111.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_411111", "411111073", "story_v_out_411111.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_16 = math.max(var_315_7, arg_312_1.talkMaxDuration)

			if var_315_6 <= arg_312_1.time_ and arg_312_1.time_ < var_315_6 + var_315_16 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_6) / var_315_16

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_6 + var_315_16 and arg_312_1.time_ < var_315_6 + var_315_16 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play411111074 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 411111074
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play411111075(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1095ui_story"].transform
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.var_.moveOldPos1095ui_story = var_319_0.localPosition
			end

			local var_319_2 = 0.001

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2
				local var_319_4 = Vector3.New(0, 100, 0)

				var_319_0.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1095ui_story, var_319_4, var_319_3)

				local var_319_5 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_5.x, var_319_5.y, var_319_5.z)

				local var_319_6 = var_319_0.localEulerAngles

				var_319_6.z = 0
				var_319_6.x = 0
				var_319_0.localEulerAngles = var_319_6
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 then
				var_319_0.localPosition = Vector3.New(0, 100, 0)

				local var_319_7 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_7.x, var_319_7.y, var_319_7.z)

				local var_319_8 = var_319_0.localEulerAngles

				var_319_8.z = 0
				var_319_8.x = 0
				var_319_0.localEulerAngles = var_319_8
			end

			local var_319_9 = 0
			local var_319_10 = 1.625

			if var_319_9 < arg_316_1.time_ and arg_316_1.time_ <= var_319_9 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_11 = arg_316_1:GetWordFromCfg(411111074)
				local var_319_12 = arg_316_1:FormatText(var_319_11.content)

				arg_316_1.text_.text = var_319_12

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_13 = 65
				local var_319_14 = utf8.len(var_319_12)
				local var_319_15 = var_319_13 <= 0 and var_319_10 or var_319_10 * (var_319_14 / var_319_13)

				if var_319_15 > 0 and var_319_10 < var_319_15 then
					arg_316_1.talkMaxDuration = var_319_15

					if var_319_15 + var_319_9 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_15 + var_319_9
					end
				end

				arg_316_1.text_.text = var_319_12
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = math.max(var_319_10, arg_316_1.talkMaxDuration)

			if var_319_9 <= arg_316_1.time_ and arg_316_1.time_ < var_319_9 + var_319_16 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_9) / var_319_16

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_9 + var_319_16 and arg_316_1.time_ < var_319_9 + var_319_16 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play411111075 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 411111075
		arg_320_1.duration_ = 1.47

		local var_320_0 = {
			zh = 1.266,
			ja = 1.466
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play411111076(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1095ui_story"].transform
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.var_.moveOldPos1095ui_story = var_323_0.localPosition
			end

			local var_323_2 = 0.001

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2
				local var_323_4 = Vector3.New(0, -0.98, -6.1)

				var_323_0.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1095ui_story, var_323_4, var_323_3)

				local var_323_5 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_5.x, var_323_5.y, var_323_5.z)

				local var_323_6 = var_323_0.localEulerAngles

				var_323_6.z = 0
				var_323_6.x = 0
				var_323_0.localEulerAngles = var_323_6
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 then
				var_323_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_323_7 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_7.x, var_323_7.y, var_323_7.z)

				local var_323_8 = var_323_0.localEulerAngles

				var_323_8.z = 0
				var_323_8.x = 0
				var_323_0.localEulerAngles = var_323_8
			end

			local var_323_9 = arg_320_1.actors_["1095ui_story"]
			local var_323_10 = 0

			if var_323_10 < arg_320_1.time_ and arg_320_1.time_ <= var_323_10 + arg_323_0 and not isNil(var_323_9) and arg_320_1.var_.characterEffect1095ui_story == nil then
				arg_320_1.var_.characterEffect1095ui_story = var_323_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_11 = 0.200000002980232

			if var_323_10 <= arg_320_1.time_ and arg_320_1.time_ < var_323_10 + var_323_11 and not isNil(var_323_9) then
				local var_323_12 = (arg_320_1.time_ - var_323_10) / var_323_11

				if arg_320_1.var_.characterEffect1095ui_story and not isNil(var_323_9) then
					arg_320_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= var_323_10 + var_323_11 and arg_320_1.time_ < var_323_10 + var_323_11 + arg_323_0 and not isNil(var_323_9) and arg_320_1.var_.characterEffect1095ui_story then
				arg_320_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_323_13 = 0
			local var_323_14 = 0.175

			if var_323_13 < arg_320_1.time_ and arg_320_1.time_ <= var_323_13 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_15 = arg_320_1:FormatText(StoryNameCfg[471].name)

				arg_320_1.leftNameTxt_.text = var_323_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_16 = arg_320_1:GetWordFromCfg(411111075)
				local var_323_17 = arg_320_1:FormatText(var_323_16.content)

				arg_320_1.text_.text = var_323_17

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_18 = 7
				local var_323_19 = utf8.len(var_323_17)
				local var_323_20 = var_323_18 <= 0 and var_323_14 or var_323_14 * (var_323_19 / var_323_18)

				if var_323_20 > 0 and var_323_14 < var_323_20 then
					arg_320_1.talkMaxDuration = var_323_20

					if var_323_20 + var_323_13 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_20 + var_323_13
					end
				end

				arg_320_1.text_.text = var_323_17
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111075", "story_v_out_411111.awb") ~= 0 then
					local var_323_21 = manager.audio:GetVoiceLength("story_v_out_411111", "411111075", "story_v_out_411111.awb") / 1000

					if var_323_21 + var_323_13 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_21 + var_323_13
					end

					if var_323_16.prefab_name ~= "" and arg_320_1.actors_[var_323_16.prefab_name] ~= nil then
						local var_323_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_16.prefab_name].transform, "story_v_out_411111", "411111075", "story_v_out_411111.awb")

						arg_320_1:RecordAudio("411111075", var_323_22)
						arg_320_1:RecordAudio("411111075", var_323_22)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_411111", "411111075", "story_v_out_411111.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_411111", "411111075", "story_v_out_411111.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_23 = math.max(var_323_14, arg_320_1.talkMaxDuration)

			if var_323_13 <= arg_320_1.time_ and arg_320_1.time_ < var_323_13 + var_323_23 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_13) / var_323_23

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_13 + var_323_23 and arg_320_1.time_ < var_323_13 + var_323_23 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play411111076 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 411111076
		arg_324_1.duration_ = 8.47

		local var_324_0 = {
			zh = 6.2,
			ja = 8.466
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play411111077(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.6

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_2 = arg_324_1:FormatText(StoryNameCfg[471].name)

				arg_324_1.leftNameTxt_.text = var_327_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_3 = arg_324_1:GetWordFromCfg(411111076)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 24
				local var_327_6 = utf8.len(var_327_4)
				local var_327_7 = var_327_5 <= 0 and var_327_1 or var_327_1 * (var_327_6 / var_327_5)

				if var_327_7 > 0 and var_327_1 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111076", "story_v_out_411111.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111076", "story_v_out_411111.awb") / 1000

					if var_327_8 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_0
					end

					if var_327_3.prefab_name ~= "" and arg_324_1.actors_[var_327_3.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_3.prefab_name].transform, "story_v_out_411111", "411111076", "story_v_out_411111.awb")

						arg_324_1:RecordAudio("411111076", var_327_9)
						arg_324_1:RecordAudio("411111076", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_411111", "411111076", "story_v_out_411111.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_411111", "411111076", "story_v_out_411111.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_10 and arg_324_1.time_ < var_327_0 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play411111077 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 411111077
		arg_328_1.duration_ = 3.57

		local var_328_0 = {
			zh = 2.733,
			ja = 3.566
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play411111078(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1095ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1095ui_story == nil then
				arg_328_1.var_.characterEffect1095ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect1095ui_story and not isNil(var_331_0) then
					local var_331_4 = Mathf.Lerp(0, 0.5, var_331_3)

					arg_328_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_328_1.var_.characterEffect1095ui_story.fillRatio = var_331_4
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1095ui_story then
				local var_331_5 = 0.5

				arg_328_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_328_1.var_.characterEffect1095ui_story.fillRatio = var_331_5
			end

			local var_331_6 = 0
			local var_331_7 = 0.25

			if var_331_6 < arg_328_1.time_ and arg_328_1.time_ <= var_331_6 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_8 = arg_328_1:FormatText(StoryNameCfg[681].name)

				arg_328_1.leftNameTxt_.text = var_331_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_9 = arg_328_1:GetWordFromCfg(411111077)
				local var_331_10 = arg_328_1:FormatText(var_331_9.content)

				arg_328_1.text_.text = var_331_10

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_11 = 10
				local var_331_12 = utf8.len(var_331_10)
				local var_331_13 = var_331_11 <= 0 and var_331_7 or var_331_7 * (var_331_12 / var_331_11)

				if var_331_13 > 0 and var_331_7 < var_331_13 then
					arg_328_1.talkMaxDuration = var_331_13

					if var_331_13 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_13 + var_331_6
					end
				end

				arg_328_1.text_.text = var_331_10
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111077", "story_v_out_411111.awb") ~= 0 then
					local var_331_14 = manager.audio:GetVoiceLength("story_v_out_411111", "411111077", "story_v_out_411111.awb") / 1000

					if var_331_14 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_14 + var_331_6
					end

					if var_331_9.prefab_name ~= "" and arg_328_1.actors_[var_331_9.prefab_name] ~= nil then
						local var_331_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_9.prefab_name].transform, "story_v_out_411111", "411111077", "story_v_out_411111.awb")

						arg_328_1:RecordAudio("411111077", var_331_15)
						arg_328_1:RecordAudio("411111077", var_331_15)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_411111", "411111077", "story_v_out_411111.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_411111", "411111077", "story_v_out_411111.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_16 = math.max(var_331_7, arg_328_1.talkMaxDuration)

			if var_331_6 <= arg_328_1.time_ and arg_328_1.time_ < var_331_6 + var_331_16 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_6) / var_331_16

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_6 + var_331_16 and arg_328_1.time_ < var_331_6 + var_331_16 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play411111078 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 411111078
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play411111079(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = false

				arg_332_1:SetGaussion(false)
			end

			local var_335_1 = 0.133333333333333

			if var_335_0 <= arg_332_1.time_ and arg_332_1.time_ < var_335_0 + var_335_1 then
				local var_335_2 = (arg_332_1.time_ - var_335_0) / var_335_1
				local var_335_3 = Color.New(1, 1, 1)

				var_335_3.a = Mathf.Lerp(1, 0, var_335_2)
				arg_332_1.mask_.color = var_335_3
			end

			if arg_332_1.time_ >= var_335_0 + var_335_1 and arg_332_1.time_ < var_335_0 + var_335_1 + arg_335_0 then
				local var_335_4 = Color.New(1, 1, 1)
				local var_335_5 = 0

				arg_332_1.mask_.enabled = false
				var_335_4.a = var_335_5
				arg_332_1.mask_.color = var_335_4
			end

			local var_335_6 = manager.ui.mainCamera.transform
			local var_335_7 = 0

			if var_335_7 < arg_332_1.time_ and arg_332_1.time_ <= var_335_7 + arg_335_0 then
				arg_332_1.var_.shakeOldPos = var_335_6.localPosition
			end

			local var_335_8 = 0.833333333333333

			if var_335_7 <= arg_332_1.time_ and arg_332_1.time_ < var_335_7 + var_335_8 then
				local var_335_9 = (arg_332_1.time_ - var_335_7) / 0.066
				local var_335_10, var_335_11 = math.modf(var_335_9)

				var_335_6.localPosition = Vector3.New(var_335_11 * 0.13, var_335_11 * 0.13, var_335_11 * 0.13) + arg_332_1.var_.shakeOldPos
			end

			if arg_332_1.time_ >= var_335_7 + var_335_8 and arg_332_1.time_ < var_335_7 + var_335_8 + arg_335_0 then
				var_335_6.localPosition = arg_332_1.var_.shakeOldPos
			end

			local var_335_12 = arg_332_1.actors_["1095ui_story"].transform
			local var_335_13 = 0

			if var_335_13 < arg_332_1.time_ and arg_332_1.time_ <= var_335_13 + arg_335_0 then
				arg_332_1.var_.moveOldPos1095ui_story = var_335_12.localPosition
			end

			local var_335_14 = 0.001

			if var_335_13 <= arg_332_1.time_ and arg_332_1.time_ < var_335_13 + var_335_14 then
				local var_335_15 = (arg_332_1.time_ - var_335_13) / var_335_14
				local var_335_16 = Vector3.New(0, 100, 0)

				var_335_12.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1095ui_story, var_335_16, var_335_15)

				local var_335_17 = manager.ui.mainCamera.transform.position - var_335_12.position

				var_335_12.forward = Vector3.New(var_335_17.x, var_335_17.y, var_335_17.z)

				local var_335_18 = var_335_12.localEulerAngles

				var_335_18.z = 0
				var_335_18.x = 0
				var_335_12.localEulerAngles = var_335_18
			end

			if arg_332_1.time_ >= var_335_13 + var_335_14 and arg_332_1.time_ < var_335_13 + var_335_14 + arg_335_0 then
				var_335_12.localPosition = Vector3.New(0, 100, 0)

				local var_335_19 = manager.ui.mainCamera.transform.position - var_335_12.position

				var_335_12.forward = Vector3.New(var_335_19.x, var_335_19.y, var_335_19.z)

				local var_335_20 = var_335_12.localEulerAngles

				var_335_20.z = 0
				var_335_20.x = 0
				var_335_12.localEulerAngles = var_335_20
			end

			local var_335_21 = 0
			local var_335_22 = 1.6

			if var_335_21 < arg_332_1.time_ and arg_332_1.time_ <= var_335_21 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_23 = arg_332_1:GetWordFromCfg(411111078)
				local var_335_24 = arg_332_1:FormatText(var_335_23.content)

				arg_332_1.text_.text = var_335_24

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_25 = 64
				local var_335_26 = utf8.len(var_335_24)
				local var_335_27 = var_335_25 <= 0 and var_335_22 or var_335_22 * (var_335_26 / var_335_25)

				if var_335_27 > 0 and var_335_22 < var_335_27 then
					arg_332_1.talkMaxDuration = var_335_27

					if var_335_27 + var_335_21 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_27 + var_335_21
					end
				end

				arg_332_1.text_.text = var_335_24
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_28 = math.max(var_335_22, arg_332_1.talkMaxDuration)

			if var_335_21 <= arg_332_1.time_ and arg_332_1.time_ < var_335_21 + var_335_28 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_21) / var_335_28

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_21 + var_335_28 and arg_332_1.time_ < var_335_21 + var_335_28 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play411111079 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 411111079
		arg_336_1.duration_ = 3.77

		local var_336_0 = {
			zh = 2.833,
			ja = 3.766
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play411111080(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0
			local var_339_1 = 0.25

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_2 = arg_336_1:FormatText(StoryNameCfg[681].name)

				arg_336_1.leftNameTxt_.text = var_339_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_3 = arg_336_1:GetWordFromCfg(411111079)
				local var_339_4 = arg_336_1:FormatText(var_339_3.content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 10
				local var_339_6 = utf8.len(var_339_4)
				local var_339_7 = var_339_5 <= 0 and var_339_1 or var_339_1 * (var_339_6 / var_339_5)

				if var_339_7 > 0 and var_339_1 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111079", "story_v_out_411111.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111079", "story_v_out_411111.awb") / 1000

					if var_339_8 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_0
					end

					if var_339_3.prefab_name ~= "" and arg_336_1.actors_[var_339_3.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_3.prefab_name].transform, "story_v_out_411111", "411111079", "story_v_out_411111.awb")

						arg_336_1:RecordAudio("411111079", var_339_9)
						arg_336_1:RecordAudio("411111079", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_411111", "411111079", "story_v_out_411111.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_411111", "411111079", "story_v_out_411111.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_10 and arg_336_1.time_ < var_339_0 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play411111080 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 411111080
		arg_340_1.duration_ = 5.3

		local var_340_0 = {
			zh = 2.8,
			ja = 5.3
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play411111081(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1095ui_story"].transform
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.var_.moveOldPos1095ui_story = var_343_0.localPosition
			end

			local var_343_2 = 0.001

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2
				local var_343_4 = Vector3.New(0, -0.98, -6.1)

				var_343_0.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1095ui_story, var_343_4, var_343_3)

				local var_343_5 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_5.x, var_343_5.y, var_343_5.z)

				local var_343_6 = var_343_0.localEulerAngles

				var_343_6.z = 0
				var_343_6.x = 0
				var_343_0.localEulerAngles = var_343_6
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 then
				var_343_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_343_7 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_7.x, var_343_7.y, var_343_7.z)

				local var_343_8 = var_343_0.localEulerAngles

				var_343_8.z = 0
				var_343_8.x = 0
				var_343_0.localEulerAngles = var_343_8
			end

			local var_343_9 = arg_340_1.actors_["1095ui_story"]
			local var_343_10 = 0

			if var_343_10 < arg_340_1.time_ and arg_340_1.time_ <= var_343_10 + arg_343_0 and not isNil(var_343_9) and arg_340_1.var_.characterEffect1095ui_story == nil then
				arg_340_1.var_.characterEffect1095ui_story = var_343_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_11 = 0.200000002980232

			if var_343_10 <= arg_340_1.time_ and arg_340_1.time_ < var_343_10 + var_343_11 and not isNil(var_343_9) then
				local var_343_12 = (arg_340_1.time_ - var_343_10) / var_343_11

				if arg_340_1.var_.characterEffect1095ui_story and not isNil(var_343_9) then
					arg_340_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= var_343_10 + var_343_11 and arg_340_1.time_ < var_343_10 + var_343_11 + arg_343_0 and not isNil(var_343_9) and arg_340_1.var_.characterEffect1095ui_story then
				arg_340_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_343_13 = 0

			if var_343_13 < arg_340_1.time_ and arg_340_1.time_ <= var_343_13 + arg_343_0 then
				arg_340_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action8_2")
			end

			local var_343_14 = 0
			local var_343_15 = 0.125

			if var_343_14 < arg_340_1.time_ and arg_340_1.time_ <= var_343_14 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_16 = arg_340_1:FormatText(StoryNameCfg[471].name)

				arg_340_1.leftNameTxt_.text = var_343_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_17 = arg_340_1:GetWordFromCfg(411111080)
				local var_343_18 = arg_340_1:FormatText(var_343_17.content)

				arg_340_1.text_.text = var_343_18

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_19 = 5
				local var_343_20 = utf8.len(var_343_18)
				local var_343_21 = var_343_19 <= 0 and var_343_15 or var_343_15 * (var_343_20 / var_343_19)

				if var_343_21 > 0 and var_343_15 < var_343_21 then
					arg_340_1.talkMaxDuration = var_343_21

					if var_343_21 + var_343_14 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_21 + var_343_14
					end
				end

				arg_340_1.text_.text = var_343_18
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111080", "story_v_out_411111.awb") ~= 0 then
					local var_343_22 = manager.audio:GetVoiceLength("story_v_out_411111", "411111080", "story_v_out_411111.awb") / 1000

					if var_343_22 + var_343_14 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_22 + var_343_14
					end

					if var_343_17.prefab_name ~= "" and arg_340_1.actors_[var_343_17.prefab_name] ~= nil then
						local var_343_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_17.prefab_name].transform, "story_v_out_411111", "411111080", "story_v_out_411111.awb")

						arg_340_1:RecordAudio("411111080", var_343_23)
						arg_340_1:RecordAudio("411111080", var_343_23)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_411111", "411111080", "story_v_out_411111.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_411111", "411111080", "story_v_out_411111.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_24 = math.max(var_343_15, arg_340_1.talkMaxDuration)

			if var_343_14 <= arg_340_1.time_ and arg_340_1.time_ < var_343_14 + var_343_24 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_14) / var_343_24

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_14 + var_343_24 and arg_340_1.time_ < var_343_14 + var_343_24 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play411111081 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 411111081
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play411111082(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1095ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1095ui_story == nil then
				arg_344_1.var_.characterEffect1095ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect1095ui_story and not isNil(var_347_0) then
					local var_347_4 = Mathf.Lerp(0, 0.5, var_347_3)

					arg_344_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1095ui_story.fillRatio = var_347_4
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1095ui_story then
				local var_347_5 = 0.5

				arg_344_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1095ui_story.fillRatio = var_347_5
			end

			local var_347_6 = 0
			local var_347_7 = 1.375

			if var_347_6 < arg_344_1.time_ and arg_344_1.time_ <= var_347_6 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_8 = arg_344_1:GetWordFromCfg(411111081)
				local var_347_9 = arg_344_1:FormatText(var_347_8.content)

				arg_344_1.text_.text = var_347_9

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_10 = 55
				local var_347_11 = utf8.len(var_347_9)
				local var_347_12 = var_347_10 <= 0 and var_347_7 or var_347_7 * (var_347_11 / var_347_10)

				if var_347_12 > 0 and var_347_7 < var_347_12 then
					arg_344_1.talkMaxDuration = var_347_12

					if var_347_12 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_12 + var_347_6
					end
				end

				arg_344_1.text_.text = var_347_9
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_13 = math.max(var_347_7, arg_344_1.talkMaxDuration)

			if var_347_6 <= arg_344_1.time_ and arg_344_1.time_ < var_347_6 + var_347_13 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_6) / var_347_13

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_6 + var_347_13 and arg_344_1.time_ < var_347_6 + var_347_13 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play411111082 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 411111082
		arg_348_1.duration_ = 4.83

		local var_348_0 = {
			zh = 2.9,
			ja = 4.833
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play411111083(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.3

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[681].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_3 = arg_348_1:GetWordFromCfg(411111082)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 12
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111082", "story_v_out_411111.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111082", "story_v_out_411111.awb") / 1000

					if var_351_8 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_0
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_out_411111", "411111082", "story_v_out_411111.awb")

						arg_348_1:RecordAudio("411111082", var_351_9)
						arg_348_1:RecordAudio("411111082", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_411111", "411111082", "story_v_out_411111.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_411111", "411111082", "story_v_out_411111.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_10 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_10 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_10

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_10 and arg_348_1.time_ < var_351_0 + var_351_10 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play411111083 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 411111083
		arg_352_1.duration_ = 4.77

		local var_352_0 = {
			zh = 3.166,
			ja = 4.766
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play411111084(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1095ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1095ui_story == nil then
				arg_352_1.var_.characterEffect1095ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect1095ui_story and not isNil(var_355_0) then
					arg_352_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1095ui_story then
				arg_352_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_355_4 = 0
			local var_355_5 = 0.325

			if var_355_4 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_6 = arg_352_1:FormatText(StoryNameCfg[471].name)

				arg_352_1.leftNameTxt_.text = var_355_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_7 = arg_352_1:GetWordFromCfg(411111083)
				local var_355_8 = arg_352_1:FormatText(var_355_7.content)

				arg_352_1.text_.text = var_355_8

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_9 = 13
				local var_355_10 = utf8.len(var_355_8)
				local var_355_11 = var_355_9 <= 0 and var_355_5 or var_355_5 * (var_355_10 / var_355_9)

				if var_355_11 > 0 and var_355_5 < var_355_11 then
					arg_352_1.talkMaxDuration = var_355_11

					if var_355_11 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_11 + var_355_4
					end
				end

				arg_352_1.text_.text = var_355_8
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111083", "story_v_out_411111.awb") ~= 0 then
					local var_355_12 = manager.audio:GetVoiceLength("story_v_out_411111", "411111083", "story_v_out_411111.awb") / 1000

					if var_355_12 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_12 + var_355_4
					end

					if var_355_7.prefab_name ~= "" and arg_352_1.actors_[var_355_7.prefab_name] ~= nil then
						local var_355_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_7.prefab_name].transform, "story_v_out_411111", "411111083", "story_v_out_411111.awb")

						arg_352_1:RecordAudio("411111083", var_355_13)
						arg_352_1:RecordAudio("411111083", var_355_13)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_411111", "411111083", "story_v_out_411111.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_411111", "411111083", "story_v_out_411111.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_14 = math.max(var_355_5, arg_352_1.talkMaxDuration)

			if var_355_4 <= arg_352_1.time_ and arg_352_1.time_ < var_355_4 + var_355_14 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_4) / var_355_14

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_4 + var_355_14 and arg_352_1.time_ < var_355_4 + var_355_14 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play411111084 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 411111084
		arg_356_1.duration_ = 8.37

		local var_356_0 = {
			zh = 5.833,
			ja = 8.366
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play411111085(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1095ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1095ui_story == nil then
				arg_356_1.var_.characterEffect1095ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect1095ui_story and not isNil(var_359_0) then
					local var_359_4 = Mathf.Lerp(0, 0.5, var_359_3)

					arg_356_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_356_1.var_.characterEffect1095ui_story.fillRatio = var_359_4
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1095ui_story then
				local var_359_5 = 0.5

				arg_356_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_356_1.var_.characterEffect1095ui_story.fillRatio = var_359_5
			end

			local var_359_6 = 0
			local var_359_7 = 0.675

			if var_359_6 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_8 = arg_356_1:FormatText(StoryNameCfg[681].name)

				arg_356_1.leftNameTxt_.text = var_359_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_9 = arg_356_1:GetWordFromCfg(411111084)
				local var_359_10 = arg_356_1:FormatText(var_359_9.content)

				arg_356_1.text_.text = var_359_10

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_11 = 27
				local var_359_12 = utf8.len(var_359_10)
				local var_359_13 = var_359_11 <= 0 and var_359_7 or var_359_7 * (var_359_12 / var_359_11)

				if var_359_13 > 0 and var_359_7 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_10
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111084", "story_v_out_411111.awb") ~= 0 then
					local var_359_14 = manager.audio:GetVoiceLength("story_v_out_411111", "411111084", "story_v_out_411111.awb") / 1000

					if var_359_14 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_14 + var_359_6
					end

					if var_359_9.prefab_name ~= "" and arg_356_1.actors_[var_359_9.prefab_name] ~= nil then
						local var_359_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_9.prefab_name].transform, "story_v_out_411111", "411111084", "story_v_out_411111.awb")

						arg_356_1:RecordAudio("411111084", var_359_15)
						arg_356_1:RecordAudio("411111084", var_359_15)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_411111", "411111084", "story_v_out_411111.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_411111", "411111084", "story_v_out_411111.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_16 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_16 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_16

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_16 and arg_356_1.time_ < var_359_6 + var_359_16 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play411111085 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 411111085
		arg_360_1.duration_ = 4.93

		local var_360_0 = {
			zh = 4.933,
			ja = 4.2
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play411111086(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.475

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[681].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_3 = arg_360_1:GetWordFromCfg(411111085)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 19
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111085", "story_v_out_411111.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111085", "story_v_out_411111.awb") / 1000

					if var_363_8 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_0
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_411111", "411111085", "story_v_out_411111.awb")

						arg_360_1:RecordAudio("411111085", var_363_9)
						arg_360_1:RecordAudio("411111085", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_411111", "411111085", "story_v_out_411111.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_411111", "411111085", "story_v_out_411111.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_10 and arg_360_1.time_ < var_363_0 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play411111086 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 411111086
		arg_364_1.duration_ = 3.03

		local var_364_0 = {
			zh = 2.766,
			ja = 3.033
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play411111087(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["1095ui_story"].transform
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.var_.moveOldPos1095ui_story = var_367_0.localPosition
			end

			local var_367_2 = 0.001

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2
				local var_367_4 = Vector3.New(0, -0.98, -6.1)

				var_367_0.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1095ui_story, var_367_4, var_367_3)

				local var_367_5 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_5.x, var_367_5.y, var_367_5.z)

				local var_367_6 = var_367_0.localEulerAngles

				var_367_6.z = 0
				var_367_6.x = 0
				var_367_0.localEulerAngles = var_367_6
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 then
				var_367_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_367_7 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_7.x, var_367_7.y, var_367_7.z)

				local var_367_8 = var_367_0.localEulerAngles

				var_367_8.z = 0
				var_367_8.x = 0
				var_367_0.localEulerAngles = var_367_8
			end

			local var_367_9 = arg_364_1.actors_["1095ui_story"]
			local var_367_10 = 0

			if var_367_10 < arg_364_1.time_ and arg_364_1.time_ <= var_367_10 + arg_367_0 and not isNil(var_367_9) and arg_364_1.var_.characterEffect1095ui_story == nil then
				arg_364_1.var_.characterEffect1095ui_story = var_367_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_11 = 0.200000002980232

			if var_367_10 <= arg_364_1.time_ and arg_364_1.time_ < var_367_10 + var_367_11 and not isNil(var_367_9) then
				local var_367_12 = (arg_364_1.time_ - var_367_10) / var_367_11

				if arg_364_1.var_.characterEffect1095ui_story and not isNil(var_367_9) then
					arg_364_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= var_367_10 + var_367_11 and arg_364_1.time_ < var_367_10 + var_367_11 + arg_367_0 and not isNil(var_367_9) and arg_364_1.var_.characterEffect1095ui_story then
				arg_364_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_367_13 = 0
			local var_367_14 = 0.2

			if var_367_13 < arg_364_1.time_ and arg_364_1.time_ <= var_367_13 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_15 = arg_364_1:FormatText(StoryNameCfg[471].name)

				arg_364_1.leftNameTxt_.text = var_367_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_16 = arg_364_1:GetWordFromCfg(411111086)
				local var_367_17 = arg_364_1:FormatText(var_367_16.content)

				arg_364_1.text_.text = var_367_17

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_18 = 8
				local var_367_19 = utf8.len(var_367_17)
				local var_367_20 = var_367_18 <= 0 and var_367_14 or var_367_14 * (var_367_19 / var_367_18)

				if var_367_20 > 0 and var_367_14 < var_367_20 then
					arg_364_1.talkMaxDuration = var_367_20

					if var_367_20 + var_367_13 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_20 + var_367_13
					end
				end

				arg_364_1.text_.text = var_367_17
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111086", "story_v_out_411111.awb") ~= 0 then
					local var_367_21 = manager.audio:GetVoiceLength("story_v_out_411111", "411111086", "story_v_out_411111.awb") / 1000

					if var_367_21 + var_367_13 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_21 + var_367_13
					end

					if var_367_16.prefab_name ~= "" and arg_364_1.actors_[var_367_16.prefab_name] ~= nil then
						local var_367_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_16.prefab_name].transform, "story_v_out_411111", "411111086", "story_v_out_411111.awb")

						arg_364_1:RecordAudio("411111086", var_367_22)
						arg_364_1:RecordAudio("411111086", var_367_22)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_411111", "411111086", "story_v_out_411111.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_411111", "411111086", "story_v_out_411111.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_23 = math.max(var_367_14, arg_364_1.talkMaxDuration)

			if var_367_13 <= arg_364_1.time_ and arg_364_1.time_ < var_367_13 + var_367_23 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_13) / var_367_23

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_13 + var_367_23 and arg_364_1.time_ < var_367_13 + var_367_23 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play411111087 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 411111087
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play411111088(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1095ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1095ui_story == nil then
				arg_368_1.var_.characterEffect1095ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect1095ui_story and not isNil(var_371_0) then
					local var_371_4 = Mathf.Lerp(0, 0.5, var_371_3)

					arg_368_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_368_1.var_.characterEffect1095ui_story.fillRatio = var_371_4
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1095ui_story then
				local var_371_5 = 0.5

				arg_368_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_368_1.var_.characterEffect1095ui_story.fillRatio = var_371_5
			end

			local var_371_6 = arg_368_1.actors_["1095ui_story"].transform
			local var_371_7 = 0

			if var_371_7 < arg_368_1.time_ and arg_368_1.time_ <= var_371_7 + arg_371_0 then
				arg_368_1.var_.moveOldPos1095ui_story = var_371_6.localPosition
			end

			local var_371_8 = 0.001

			if var_371_7 <= arg_368_1.time_ and arg_368_1.time_ < var_371_7 + var_371_8 then
				local var_371_9 = (arg_368_1.time_ - var_371_7) / var_371_8
				local var_371_10 = Vector3.New(0, 100, 0)

				var_371_6.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1095ui_story, var_371_10, var_371_9)

				local var_371_11 = manager.ui.mainCamera.transform.position - var_371_6.position

				var_371_6.forward = Vector3.New(var_371_11.x, var_371_11.y, var_371_11.z)

				local var_371_12 = var_371_6.localEulerAngles

				var_371_12.z = 0
				var_371_12.x = 0
				var_371_6.localEulerAngles = var_371_12
			end

			if arg_368_1.time_ >= var_371_7 + var_371_8 and arg_368_1.time_ < var_371_7 + var_371_8 + arg_371_0 then
				var_371_6.localPosition = Vector3.New(0, 100, 0)

				local var_371_13 = manager.ui.mainCamera.transform.position - var_371_6.position

				var_371_6.forward = Vector3.New(var_371_13.x, var_371_13.y, var_371_13.z)

				local var_371_14 = var_371_6.localEulerAngles

				var_371_14.z = 0
				var_371_14.x = 0
				var_371_6.localEulerAngles = var_371_14
			end

			local var_371_15 = 0
			local var_371_16 = 0.325

			if var_371_15 < arg_368_1.time_ and arg_368_1.time_ <= var_371_15 + arg_371_0 then
				local var_371_17 = "stop"
				local var_371_18 = "effect"

				arg_368_1:AudioAction(var_371_17, var_371_18, "se_story_126_01", "se_story_126_01_fight_loop", "")
			end

			local var_371_19 = 0
			local var_371_20 = 1.075

			if var_371_19 < arg_368_1.time_ and arg_368_1.time_ <= var_371_19 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_21 = arg_368_1:GetWordFromCfg(411111087)
				local var_371_22 = arg_368_1:FormatText(var_371_21.content)

				arg_368_1.text_.text = var_371_22

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_23 = 43
				local var_371_24 = utf8.len(var_371_22)
				local var_371_25 = var_371_23 <= 0 and var_371_20 or var_371_20 * (var_371_24 / var_371_23)

				if var_371_25 > 0 and var_371_20 < var_371_25 then
					arg_368_1.talkMaxDuration = var_371_25

					if var_371_25 + var_371_19 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_25 + var_371_19
					end
				end

				arg_368_1.text_.text = var_371_22
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_26 = math.max(var_371_20, arg_368_1.talkMaxDuration)

			if var_371_19 <= arg_368_1.time_ and arg_368_1.time_ < var_371_19 + var_371_26 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_19) / var_371_26

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_19 + var_371_26 and arg_368_1.time_ < var_371_19 + var_371_26 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play411111088 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 411111088
		arg_372_1.duration_ = 5.8

		local var_372_0 = {
			zh = 4,
			ja = 5.8
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play411111089(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 0.225

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_2 = arg_372_1:FormatText(StoryNameCfg[681].name)

				arg_372_1.leftNameTxt_.text = var_375_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_3 = arg_372_1:GetWordFromCfg(411111088)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 9
				local var_375_6 = utf8.len(var_375_4)
				local var_375_7 = var_375_5 <= 0 and var_375_1 or var_375_1 * (var_375_6 / var_375_5)

				if var_375_7 > 0 and var_375_1 < var_375_7 then
					arg_372_1.talkMaxDuration = var_375_7

					if var_375_7 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111088", "story_v_out_411111.awb") ~= 0 then
					local var_375_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111088", "story_v_out_411111.awb") / 1000

					if var_375_8 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_8 + var_375_0
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_out_411111", "411111088", "story_v_out_411111.awb")

						arg_372_1:RecordAudio("411111088", var_375_9)
						arg_372_1:RecordAudio("411111088", var_375_9)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_411111", "411111088", "story_v_out_411111.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_411111", "411111088", "story_v_out_411111.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_10 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_10 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_10

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_10 and arg_372_1.time_ < var_375_0 + var_375_10 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play411111089 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 411111089
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play411111090(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.475

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_2 = arg_376_1:GetWordFromCfg(411111089)
				local var_379_3 = arg_376_1:FormatText(var_379_2.content)

				arg_376_1.text_.text = var_379_3

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 19
				local var_379_5 = utf8.len(var_379_3)
				local var_379_6 = var_379_4 <= 0 and var_379_1 or var_379_1 * (var_379_5 / var_379_4)

				if var_379_6 > 0 and var_379_1 < var_379_6 then
					arg_376_1.talkMaxDuration = var_379_6

					if var_379_6 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_6 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_3
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_7 and arg_376_1.time_ < var_379_0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play411111090 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 411111090
		arg_380_1.duration_ = 4.57

		local var_380_0 = {
			zh = 2.333,
			ja = 4.566
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play411111091(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.175

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_2 = arg_380_1:FormatText(StoryNameCfg[681].name)

				arg_380_1.leftNameTxt_.text = var_383_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:GetWordFromCfg(411111090)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 7
				local var_383_6 = utf8.len(var_383_4)
				local var_383_7 = var_383_5 <= 0 and var_383_1 or var_383_1 * (var_383_6 / var_383_5)

				if var_383_7 > 0 and var_383_1 < var_383_7 then
					arg_380_1.talkMaxDuration = var_383_7

					if var_383_7 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111090", "story_v_out_411111.awb") ~= 0 then
					local var_383_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111090", "story_v_out_411111.awb") / 1000

					if var_383_8 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_0
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_out_411111", "411111090", "story_v_out_411111.awb")

						arg_380_1:RecordAudio("411111090", var_383_9)
						arg_380_1:RecordAudio("411111090", var_383_9)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_411111", "411111090", "story_v_out_411111.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_411111", "411111090", "story_v_out_411111.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_10 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_10 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_10

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_10 and arg_380_1.time_ < var_383_0 + var_383_10 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play411111091 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 411111091
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play411111092(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 1.075

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_2 = arg_384_1:GetWordFromCfg(411111091)
				local var_387_3 = arg_384_1:FormatText(var_387_2.content)

				arg_384_1.text_.text = var_387_3

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_4 = 43
				local var_387_5 = utf8.len(var_387_3)
				local var_387_6 = var_387_4 <= 0 and var_387_1 or var_387_1 * (var_387_5 / var_387_4)

				if var_387_6 > 0 and var_387_1 < var_387_6 then
					arg_384_1.talkMaxDuration = var_387_6

					if var_387_6 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_6 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_3
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_7 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_7 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_7

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_7 and arg_384_1.time_ < var_387_0 + var_387_7 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play411111092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 411111092
		arg_388_1.duration_ = 2.4

		local var_388_0 = {
			zh = 2.4,
			ja = 1.866
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play411111093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = "2079ui_story"

			if arg_388_1.actors_[var_391_0] == nil then
				local var_391_1 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_391_1) then
					local var_391_2 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_388_1.stage_.transform)

					var_391_2.name = var_391_0
					var_391_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_388_1.actors_[var_391_0] = var_391_2

					local var_391_3 = var_391_2:GetComponentInChildren(typeof(CharacterEffect))

					var_391_3.enabled = true

					local var_391_4 = GameObjectTools.GetOrAddComponent(var_391_2, typeof(DynamicBoneHelper))

					if var_391_4 then
						var_391_4:EnableDynamicBone(false)
					end

					arg_388_1:ShowWeapon(var_391_3.transform, false)

					arg_388_1.var_[var_391_0 .. "Animator"] = var_391_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_388_1.var_[var_391_0 .. "Animator"].applyRootMotion = true
					arg_388_1.var_[var_391_0 .. "LipSync"] = var_391_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_391_5 = arg_388_1.actors_["2079ui_story"]
			local var_391_6 = 0

			if var_391_6 < arg_388_1.time_ and arg_388_1.time_ <= var_391_6 + arg_391_0 and not isNil(var_391_5) and arg_388_1.var_.characterEffect2079ui_story == nil then
				arg_388_1.var_.characterEffect2079ui_story = var_391_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_7 = 0.200000002980232

			if var_391_6 <= arg_388_1.time_ and arg_388_1.time_ < var_391_6 + var_391_7 and not isNil(var_391_5) then
				local var_391_8 = (arg_388_1.time_ - var_391_6) / var_391_7

				if arg_388_1.var_.characterEffect2079ui_story and not isNil(var_391_5) then
					arg_388_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_6 + var_391_7 and arg_388_1.time_ < var_391_6 + var_391_7 + arg_391_0 and not isNil(var_391_5) and arg_388_1.var_.characterEffect2079ui_story then
				arg_388_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_391_9 = arg_388_1.actors_["2079ui_story"].transform
			local var_391_10 = 0

			if var_391_10 < arg_388_1.time_ and arg_388_1.time_ <= var_391_10 + arg_391_0 then
				arg_388_1.var_.moveOldPos2079ui_story = var_391_9.localPosition
			end

			local var_391_11 = 0.001

			if var_391_10 <= arg_388_1.time_ and arg_388_1.time_ < var_391_10 + var_391_11 then
				local var_391_12 = (arg_388_1.time_ - var_391_10) / var_391_11
				local var_391_13 = Vector3.New(0, -1.28, -5.6)

				var_391_9.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos2079ui_story, var_391_13, var_391_12)

				local var_391_14 = manager.ui.mainCamera.transform.position - var_391_9.position

				var_391_9.forward = Vector3.New(var_391_14.x, var_391_14.y, var_391_14.z)

				local var_391_15 = var_391_9.localEulerAngles

				var_391_15.z = 0
				var_391_15.x = 0
				var_391_9.localEulerAngles = var_391_15
			end

			if arg_388_1.time_ >= var_391_10 + var_391_11 and arg_388_1.time_ < var_391_10 + var_391_11 + arg_391_0 then
				var_391_9.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_391_16 = manager.ui.mainCamera.transform.position - var_391_9.position

				var_391_9.forward = Vector3.New(var_391_16.x, var_391_16.y, var_391_16.z)

				local var_391_17 = var_391_9.localEulerAngles

				var_391_17.z = 0
				var_391_17.x = 0
				var_391_9.localEulerAngles = var_391_17
			end

			local var_391_18 = 0
			local var_391_19 = 0.375

			if var_391_18 < arg_388_1.time_ and arg_388_1.time_ <= var_391_18 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_20 = arg_388_1:FormatText(StoryNameCfg[688].name)

				arg_388_1.leftNameTxt_.text = var_391_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_21 = arg_388_1:GetWordFromCfg(411111092)
				local var_391_22 = arg_388_1:FormatText(var_391_21.content)

				arg_388_1.text_.text = var_391_22

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_23 = 15
				local var_391_24 = utf8.len(var_391_22)
				local var_391_25 = var_391_23 <= 0 and var_391_19 or var_391_19 * (var_391_24 / var_391_23)

				if var_391_25 > 0 and var_391_19 < var_391_25 then
					arg_388_1.talkMaxDuration = var_391_25

					if var_391_25 + var_391_18 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_25 + var_391_18
					end
				end

				arg_388_1.text_.text = var_391_22
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111092", "story_v_out_411111.awb") ~= 0 then
					local var_391_26 = manager.audio:GetVoiceLength("story_v_out_411111", "411111092", "story_v_out_411111.awb") / 1000

					if var_391_26 + var_391_18 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_26 + var_391_18
					end

					if var_391_21.prefab_name ~= "" and arg_388_1.actors_[var_391_21.prefab_name] ~= nil then
						local var_391_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_21.prefab_name].transform, "story_v_out_411111", "411111092", "story_v_out_411111.awb")

						arg_388_1:RecordAudio("411111092", var_391_27)
						arg_388_1:RecordAudio("411111092", var_391_27)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_411111", "411111092", "story_v_out_411111.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_411111", "411111092", "story_v_out_411111.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_28 = math.max(var_391_19, arg_388_1.talkMaxDuration)

			if var_391_18 <= arg_388_1.time_ and arg_388_1.time_ < var_391_18 + var_391_28 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_18) / var_391_28

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_18 + var_391_28 and arg_388_1.time_ < var_391_18 + var_391_28 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play411111093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 411111093
		arg_392_1.duration_ = 7.1

		local var_392_0 = {
			zh = 2.5,
			ja = 7.1
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play411111094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["2079ui_story"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect2079ui_story == nil then
				arg_392_1.var_.characterEffect2079ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.characterEffect2079ui_story and not isNil(var_395_0) then
					arg_392_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect2079ui_story then
				arg_392_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_395_4 = 0
			local var_395_5 = 0.35

			if var_395_4 < arg_392_1.time_ and arg_392_1.time_ <= var_395_4 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_6 = arg_392_1:FormatText(StoryNameCfg[688].name)

				arg_392_1.leftNameTxt_.text = var_395_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_7 = arg_392_1:GetWordFromCfg(411111093)
				local var_395_8 = arg_392_1:FormatText(var_395_7.content)

				arg_392_1.text_.text = var_395_8

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_9 = 14
				local var_395_10 = utf8.len(var_395_8)
				local var_395_11 = var_395_9 <= 0 and var_395_5 or var_395_5 * (var_395_10 / var_395_9)

				if var_395_11 > 0 and var_395_5 < var_395_11 then
					arg_392_1.talkMaxDuration = var_395_11

					if var_395_11 + var_395_4 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_11 + var_395_4
					end
				end

				arg_392_1.text_.text = var_395_8
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111093", "story_v_out_411111.awb") ~= 0 then
					local var_395_12 = manager.audio:GetVoiceLength("story_v_out_411111", "411111093", "story_v_out_411111.awb") / 1000

					if var_395_12 + var_395_4 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_12 + var_395_4
					end

					if var_395_7.prefab_name ~= "" and arg_392_1.actors_[var_395_7.prefab_name] ~= nil then
						local var_395_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_7.prefab_name].transform, "story_v_out_411111", "411111093", "story_v_out_411111.awb")

						arg_392_1:RecordAudio("411111093", var_395_13)
						arg_392_1:RecordAudio("411111093", var_395_13)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_411111", "411111093", "story_v_out_411111.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_411111", "411111093", "story_v_out_411111.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_14 = math.max(var_395_5, arg_392_1.talkMaxDuration)

			if var_395_4 <= arg_392_1.time_ and arg_392_1.time_ < var_395_4 + var_395_14 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_4) / var_395_14

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_4 + var_395_14 and arg_392_1.time_ < var_395_4 + var_395_14 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play411111094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 411111094
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play411111095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["2079ui_story"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos2079ui_story = var_399_0.localPosition
			end

			local var_399_2 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2
				local var_399_4 = Vector3.New(0, 100, 0)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos2079ui_story, var_399_4, var_399_3)

				local var_399_5 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_5.x, var_399_5.y, var_399_5.z)

				local var_399_6 = var_399_0.localEulerAngles

				var_399_6.z = 0
				var_399_6.x = 0
				var_399_0.localEulerAngles = var_399_6
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(0, 100, 0)

				local var_399_7 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_7.x, var_399_7.y, var_399_7.z)

				local var_399_8 = var_399_0.localEulerAngles

				var_399_8.z = 0
				var_399_8.x = 0
				var_399_0.localEulerAngles = var_399_8
			end

			local var_399_9 = 0
			local var_399_10 = 1.175

			if var_399_9 < arg_396_1.time_ and arg_396_1.time_ <= var_399_9 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_11 = arg_396_1:GetWordFromCfg(411111094)
				local var_399_12 = arg_396_1:FormatText(var_399_11.content)

				arg_396_1.text_.text = var_399_12

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_13 = 47
				local var_399_14 = utf8.len(var_399_12)
				local var_399_15 = var_399_13 <= 0 and var_399_10 or var_399_10 * (var_399_14 / var_399_13)

				if var_399_15 > 0 and var_399_10 < var_399_15 then
					arg_396_1.talkMaxDuration = var_399_15

					if var_399_15 + var_399_9 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_15 + var_399_9
					end
				end

				arg_396_1.text_.text = var_399_12
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_16 = math.max(var_399_10, arg_396_1.talkMaxDuration)

			if var_399_9 <= arg_396_1.time_ and arg_396_1.time_ < var_399_9 + var_399_16 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_9) / var_399_16

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_9 + var_399_16 and arg_396_1.time_ < var_399_9 + var_399_16 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play411111095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 411111095
		arg_400_1.duration_ = 4.53

		local var_400_0 = {
			zh = 4.533,
			ja = 3.633
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play411111096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.25

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_2 = arg_400_1:FormatText(StoryNameCfg[681].name)

				arg_400_1.leftNameTxt_.text = var_403_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_3 = arg_400_1:GetWordFromCfg(411111095)
				local var_403_4 = arg_400_1:FormatText(var_403_3.content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 10
				local var_403_6 = utf8.len(var_403_4)
				local var_403_7 = var_403_5 <= 0 and var_403_1 or var_403_1 * (var_403_6 / var_403_5)

				if var_403_7 > 0 and var_403_1 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111095", "story_v_out_411111.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_out_411111", "411111095", "story_v_out_411111.awb") / 1000

					if var_403_8 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_0
					end

					if var_403_3.prefab_name ~= "" and arg_400_1.actors_[var_403_3.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_3.prefab_name].transform, "story_v_out_411111", "411111095", "story_v_out_411111.awb")

						arg_400_1:RecordAudio("411111095", var_403_9)
						arg_400_1:RecordAudio("411111095", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_411111", "411111095", "story_v_out_411111.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_411111", "411111095", "story_v_out_411111.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_10 and arg_400_1.time_ < var_403_0 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play411111096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 411111096
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play411111097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 0.875

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_2 = arg_404_1:GetWordFromCfg(411111096)
				local var_407_3 = arg_404_1:FormatText(var_407_2.content)

				arg_404_1.text_.text = var_407_3

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 35
				local var_407_5 = utf8.len(var_407_3)
				local var_407_6 = var_407_4 <= 0 and var_407_1 or var_407_1 * (var_407_5 / var_407_4)

				if var_407_6 > 0 and var_407_1 < var_407_6 then
					arg_404_1.talkMaxDuration = var_407_6

					if var_407_6 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_6 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_3
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_7 and arg_404_1.time_ < var_407_0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play411111097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 411111097
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play411111098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 1

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_2 = arg_408_1:GetWordFromCfg(411111097)
				local var_411_3 = arg_408_1:FormatText(var_411_2.content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 40
				local var_411_5 = utf8.len(var_411_3)
				local var_411_6 = var_411_4 <= 0 and var_411_1 or var_411_1 * (var_411_5 / var_411_4)

				if var_411_6 > 0 and var_411_1 < var_411_6 then
					arg_408_1.talkMaxDuration = var_411_6

					if var_411_6 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_6 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_7 and arg_408_1.time_ < var_411_0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play411111098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 411111098
		arg_412_1.duration_ = 2

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play411111099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1095ui_story"].transform
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.var_.moveOldPos1095ui_story = var_415_0.localPosition
			end

			local var_415_2 = 0.001

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2
				local var_415_4 = Vector3.New(0, -0.98, -6.1)

				var_415_0.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1095ui_story, var_415_4, var_415_3)

				local var_415_5 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_5.x, var_415_5.y, var_415_5.z)

				local var_415_6 = var_415_0.localEulerAngles

				var_415_6.z = 0
				var_415_6.x = 0
				var_415_0.localEulerAngles = var_415_6
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 then
				var_415_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_415_7 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_7.x, var_415_7.y, var_415_7.z)

				local var_415_8 = var_415_0.localEulerAngles

				var_415_8.z = 0
				var_415_8.x = 0
				var_415_0.localEulerAngles = var_415_8
			end

			local var_415_9 = arg_412_1.actors_["1095ui_story"]
			local var_415_10 = 0

			if var_415_10 < arg_412_1.time_ and arg_412_1.time_ <= var_415_10 + arg_415_0 and not isNil(var_415_9) and arg_412_1.var_.characterEffect1095ui_story == nil then
				arg_412_1.var_.characterEffect1095ui_story = var_415_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_11 = 0.200000002980232

			if var_415_10 <= arg_412_1.time_ and arg_412_1.time_ < var_415_10 + var_415_11 and not isNil(var_415_9) then
				local var_415_12 = (arg_412_1.time_ - var_415_10) / var_415_11

				if arg_412_1.var_.characterEffect1095ui_story and not isNil(var_415_9) then
					arg_412_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= var_415_10 + var_415_11 and arg_412_1.time_ < var_415_10 + var_415_11 + arg_415_0 and not isNil(var_415_9) and arg_412_1.var_.characterEffect1095ui_story then
				arg_412_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_415_13 = 0

			if var_415_13 < arg_412_1.time_ and arg_412_1.time_ <= var_415_13 + arg_415_0 then
				arg_412_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action8_2")
			end

			local var_415_14 = 0

			if var_415_14 < arg_412_1.time_ and arg_412_1.time_ <= var_415_14 + arg_415_0 then
				arg_412_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_415_15 = 0
			local var_415_16 = 0.175

			if var_415_15 < arg_412_1.time_ and arg_412_1.time_ <= var_415_15 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_17 = arg_412_1:FormatText(StoryNameCfg[471].name)

				arg_412_1.leftNameTxt_.text = var_415_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_18 = arg_412_1:GetWordFromCfg(411111098)
				local var_415_19 = arg_412_1:FormatText(var_415_18.content)

				arg_412_1.text_.text = var_415_19

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_20 = 7
				local var_415_21 = utf8.len(var_415_19)
				local var_415_22 = var_415_20 <= 0 and var_415_16 or var_415_16 * (var_415_21 / var_415_20)

				if var_415_22 > 0 and var_415_16 < var_415_22 then
					arg_412_1.talkMaxDuration = var_415_22

					if var_415_22 + var_415_15 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_22 + var_415_15
					end
				end

				arg_412_1.text_.text = var_415_19
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111098", "story_v_out_411111.awb") ~= 0 then
					local var_415_23 = manager.audio:GetVoiceLength("story_v_out_411111", "411111098", "story_v_out_411111.awb") / 1000

					if var_415_23 + var_415_15 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_23 + var_415_15
					end

					if var_415_18.prefab_name ~= "" and arg_412_1.actors_[var_415_18.prefab_name] ~= nil then
						local var_415_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_18.prefab_name].transform, "story_v_out_411111", "411111098", "story_v_out_411111.awb")

						arg_412_1:RecordAudio("411111098", var_415_24)
						arg_412_1:RecordAudio("411111098", var_415_24)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_411111", "411111098", "story_v_out_411111.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_411111", "411111098", "story_v_out_411111.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_25 = math.max(var_415_16, arg_412_1.talkMaxDuration)

			if var_415_15 <= arg_412_1.time_ and arg_412_1.time_ < var_415_15 + var_415_25 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_15) / var_415_25

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_15 + var_415_25 and arg_412_1.time_ < var_415_15 + var_415_25 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play411111099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 411111099
		arg_416_1.duration_ = 5.7

		local var_416_0 = {
			zh = 5.266,
			ja = 5.7
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
			arg_416_1.auto_ = false
		end

		function arg_416_1.playNext_(arg_418_0)
			arg_416_1.onStoryFinished_()
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 2

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				local var_419_1 = manager.ui.mainCamera.transform.localPosition
				local var_419_2 = Vector3.New(0, 0, 10) + Vector3.New(var_419_1.x, var_419_1.y, 0)
				local var_419_3 = arg_416_1.bgs_.STblack

				var_419_3.transform.localPosition = var_419_2
				var_419_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_419_4 = var_419_3:GetComponent("SpriteRenderer")

				if var_419_4 and var_419_4.sprite then
					local var_419_5 = (var_419_3.transform.localPosition - var_419_1).z
					local var_419_6 = manager.ui.mainCameraCom_
					local var_419_7 = 2 * var_419_5 * Mathf.Tan(var_419_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_419_8 = var_419_7 * var_419_6.aspect
					local var_419_9 = var_419_4.sprite.bounds.size.x
					local var_419_10 = var_419_4.sprite.bounds.size.y
					local var_419_11 = var_419_8 / var_419_9
					local var_419_12 = var_419_7 / var_419_10
					local var_419_13 = var_419_12 < var_419_11 and var_419_11 or var_419_12

					var_419_3.transform.localScale = Vector3.New(var_419_13, var_419_13, 0)
				end

				for iter_419_0, iter_419_1 in pairs(arg_416_1.bgs_) do
					if iter_419_0 ~= "STblack" then
						iter_419_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_419_14 = 0

			if var_419_14 < arg_416_1.time_ and arg_416_1.time_ <= var_419_14 + arg_419_0 then
				arg_416_1.mask_.enabled = true
				arg_416_1.mask_.raycastTarget = true

				arg_416_1:SetGaussion(false)
			end

			local var_419_15 = 2

			if var_419_14 <= arg_416_1.time_ and arg_416_1.time_ < var_419_14 + var_419_15 then
				local var_419_16 = (arg_416_1.time_ - var_419_14) / var_419_15
				local var_419_17 = Color.New(1, 1, 1)

				var_419_17.a = Mathf.Lerp(0, 1, var_419_16)
				arg_416_1.mask_.color = var_419_17
			end

			if arg_416_1.time_ >= var_419_14 + var_419_15 and arg_416_1.time_ < var_419_14 + var_419_15 + arg_419_0 then
				local var_419_18 = Color.New(1, 1, 1)

				var_419_18.a = 1
				arg_416_1.mask_.color = var_419_18
			end

			local var_419_19 = 2

			if var_419_19 < arg_416_1.time_ and arg_416_1.time_ <= var_419_19 + arg_419_0 then
				arg_416_1.mask_.enabled = true
				arg_416_1.mask_.raycastTarget = true

				arg_416_1:SetGaussion(false)
			end

			local var_419_20 = 2

			if var_419_19 <= arg_416_1.time_ and arg_416_1.time_ < var_419_19 + var_419_20 then
				local var_419_21 = (arg_416_1.time_ - var_419_19) / var_419_20
				local var_419_22 = Color.New(1, 1, 1)

				var_419_22.a = Mathf.Lerp(1, 0, var_419_21)
				arg_416_1.mask_.color = var_419_22
			end

			if arg_416_1.time_ >= var_419_19 + var_419_20 and arg_416_1.time_ < var_419_19 + var_419_20 + arg_419_0 then
				local var_419_23 = Color.New(1, 1, 1)
				local var_419_24 = 0

				arg_416_1.mask_.enabled = false
				var_419_23.a = var_419_24
				arg_416_1.mask_.color = var_419_23
			end

			local var_419_25 = arg_416_1.actors_["1095ui_story"].transform
			local var_419_26 = 0

			if var_419_26 < arg_416_1.time_ and arg_416_1.time_ <= var_419_26 + arg_419_0 then
				arg_416_1.var_.moveOldPos1095ui_story = var_419_25.localPosition
			end

			local var_419_27 = 0.001

			if var_419_26 <= arg_416_1.time_ and arg_416_1.time_ < var_419_26 + var_419_27 then
				local var_419_28 = (arg_416_1.time_ - var_419_26) / var_419_27
				local var_419_29 = Vector3.New(0, 100, 0)

				var_419_25.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1095ui_story, var_419_29, var_419_28)

				local var_419_30 = manager.ui.mainCamera.transform.position - var_419_25.position

				var_419_25.forward = Vector3.New(var_419_30.x, var_419_30.y, var_419_30.z)

				local var_419_31 = var_419_25.localEulerAngles

				var_419_31.z = 0
				var_419_31.x = 0
				var_419_25.localEulerAngles = var_419_31
			end

			if arg_416_1.time_ >= var_419_26 + var_419_27 and arg_416_1.time_ < var_419_26 + var_419_27 + arg_419_0 then
				var_419_25.localPosition = Vector3.New(0, 100, 0)

				local var_419_32 = manager.ui.mainCamera.transform.position - var_419_25.position

				var_419_25.forward = Vector3.New(var_419_32.x, var_419_32.y, var_419_32.z)

				local var_419_33 = var_419_25.localEulerAngles

				var_419_33.z = 0
				var_419_33.x = 0
				var_419_25.localEulerAngles = var_419_33
			end

			local var_419_34 = arg_416_1.actors_["1095ui_story"]
			local var_419_35 = 0

			if var_419_35 < arg_416_1.time_ and arg_416_1.time_ <= var_419_35 + arg_419_0 and not isNil(var_419_34) and arg_416_1.var_.characterEffect1095ui_story == nil then
				arg_416_1.var_.characterEffect1095ui_story = var_419_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_36 = 0.200000002980232

			if var_419_35 <= arg_416_1.time_ and arg_416_1.time_ < var_419_35 + var_419_36 and not isNil(var_419_34) then
				local var_419_37 = (arg_416_1.time_ - var_419_35) / var_419_36

				if arg_416_1.var_.characterEffect1095ui_story and not isNil(var_419_34) then
					arg_416_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= var_419_35 + var_419_36 and arg_416_1.time_ < var_419_35 + var_419_36 + arg_419_0 and not isNil(var_419_34) and arg_416_1.var_.characterEffect1095ui_story then
				arg_416_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_419_38 = 0

			if var_419_38 < arg_416_1.time_ and arg_416_1.time_ <= var_419_38 + arg_419_0 then
				arg_416_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_419_39 = 0

			if var_419_39 < arg_416_1.time_ and arg_416_1.time_ <= var_419_39 + arg_419_0 then
				arg_416_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_416_1.frameCnt_ <= 1 then
				arg_416_1.dialog_:SetActive(false)
			end

			local var_419_40 = 4
			local var_419_41 = 0.125

			if var_419_40 < arg_416_1.time_ and arg_416_1.time_ <= var_419_40 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0

				arg_416_1.dialog_:SetActive(true)

				arg_416_1.dialogCg_.alpha = 0

				local var_419_42 = LeanTween.value(arg_416_1.dialog_, 0, 1, 0.3)

				var_419_42:setOnUpdate(LuaHelper.FloatAction(function(arg_420_0)
					arg_416_1.dialogCg_.alpha = arg_420_0
				end))
				var_419_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_416_1.dialog_)
					var_419_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_416_1.duration_ = arg_416_1.duration_ + 0.3

				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_43 = arg_416_1:FormatText(StoryNameCfg[471].name)

				arg_416_1.leftNameTxt_.text = var_419_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_44 = arg_416_1:GetWordFromCfg(411111099)
				local var_419_45 = arg_416_1:FormatText(var_419_44.content)

				arg_416_1.text_.text = var_419_45

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_46 = 5
				local var_419_47 = utf8.len(var_419_45)
				local var_419_48 = var_419_46 <= 0 and var_419_41 or var_419_41 * (var_419_47 / var_419_46)

				if var_419_48 > 0 and var_419_41 < var_419_48 then
					arg_416_1.talkMaxDuration = var_419_48
					var_419_40 = var_419_40 + 0.3

					if var_419_48 + var_419_40 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_48 + var_419_40
					end
				end

				arg_416_1.text_.text = var_419_45
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411111", "411111099", "story_v_out_411111.awb") ~= 0 then
					local var_419_49 = manager.audio:GetVoiceLength("story_v_out_411111", "411111099", "story_v_out_411111.awb") / 1000

					if var_419_49 + var_419_40 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_49 + var_419_40
					end

					if var_419_44.prefab_name ~= "" and arg_416_1.actors_[var_419_44.prefab_name] ~= nil then
						local var_419_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_44.prefab_name].transform, "story_v_out_411111", "411111099", "story_v_out_411111.awb")

						arg_416_1:RecordAudio("411111099", var_419_50)
						arg_416_1:RecordAudio("411111099", var_419_50)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_411111", "411111099", "story_v_out_411111.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_411111", "411111099", "story_v_out_411111.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_51 = var_419_40 + 0.3
			local var_419_52 = math.max(var_419_41, arg_416_1.talkMaxDuration)

			if var_419_51 <= arg_416_1.time_ and arg_416_1.time_ < var_419_51 + var_419_52 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_51) / var_419_52

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_51 + var_419_52 and arg_416_1.time_ < var_419_51 + var_419_52 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B04g",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/B04f"
	},
	voices = {
		"story_v_out_411111.awb"
	}
}
